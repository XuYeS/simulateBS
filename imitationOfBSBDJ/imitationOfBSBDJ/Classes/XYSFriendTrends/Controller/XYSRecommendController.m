//
//  XYSRecommendController.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/6/30.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "XYSRecommendController.h"
#import "XYSLeftRecommendCell.h"
#import "XYSLeftRecommendModel.h"
#import "XYSRightRecommendUserCell.h"
#import "XYSRightRecommendUserModel.h"
@interface XYSRecommendController()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)NSArray *listOfLeftRecommendModel;
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightUserTableView;
/**用于只解析一次当前正选择的请求*/
@property (strong,nonatomic)NSMutableDictionary* parameters;
/**AFN manger*/
@property (strong,nonatomic)AFHTTPSessionManager* manger;
@end

@implementation XYSRecommendController
#define CurrentSelectedLeft self.listOfLeftRecommendModel[self.leftTableView.indexPathForSelectedRow.row]
static NSString *leftCellId = @"leftRecommendCell";
static NSString *rightCellId = @"rightRecommendUserCell";

-(AFHTTPSessionManager *)manger
{
    if (!_manger) {
        _manger = [AFHTTPSessionManager manager];
    }
    return _manger;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpTableView];
    [self getLeftRecommendData];
    [self setUpRefresh];


}
#pragma mark - setup/getHTTPdata
/**
 *初始化背景、标题及tableView
 */
-(void)setUpTableView
{
    self.view.backgroundColor = XYSBackGroundColor ;
    self.navigationItem.title = @"推荐关注";
    self.rightUserTableView.rowHeight = 80;//cell高度
    //不要苹果自己增加64的insets
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.leftTableView.contentInset = UIEdgeInsetsMake(64, 0, 50, 0);
    self.rightUserTableView.contentInset = UIEdgeInsetsMake(64, 0, 50, 0);
    
    
    //注册xib 的cell 需要 registerNib
    [self.leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYSLeftRecommendCell class]) bundle:nil] forCellReuseIdentifier:leftCellId];
    
    [self.rightUserTableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYSRightRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:rightCellId];
}
/**
 *获取左侧网络请求数据
 */
-(void)getLeftRecommendData
{
    [SVProgressHUD show];//显示HUB
    //--------------------------------网络请求--------------------------------
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"category";
    parameters[@"c"] = @"subscribe";
    
    [self.manger GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];//取消HUB
        //字典转模型
        self.listOfLeftRecommendModel = [XYSLeftRecommendModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //重写刷新tableview
        [self.leftTableView reloadData];
        //进入后默认选中第一行
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        [self.rightUserTableView.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接失败啦~。~"];
    }];
    //----------------------------------------------------------------
}
#pragma mark - refresh
/**
 *添加refresh控件
 */
-(void)setUpRefresh
{
    //添加refreshheader控件
    self.rightUserTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    //添加refreshfooter控件
    self.rightUserTableView.mj_header.automaticallyChangeAlpha = YES;
    self.rightUserTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
   
}
-(void)loadNewUsers
{
    XYSLeftRecommendModel *leftRecommendModel = CurrentSelectedLeft;
    //每次下拉头控件时都将原有数据清除，换为新请求的数据
    [leftRecommendModel.listOfRecommendUser removeAllObjects];
    
    leftRecommendModel.current_page = 1;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = @(leftRecommendModel.ID);
    parameters[@"page"] = @(leftRecommendModel.current_page);
    [self.manger GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典转模型
        //XYSLog(@"%@",responseObject);
        NSArray *recommendUsers = [XYSRightRecommendUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //将推荐用户添加到左侧model里
        [leftRecommendModel.listOfRecommendUser addObjectsFromArray:recommendUsers];
        //总页数
        leftRecommendModel.total_page =[responseObject[@"total_page"]integerValue];
        //总的推荐用户数
        leftRecommendModel.totalRecommendUser = [responseObject[@"total"]integerValue];
        
        [self.rightUserTableView reloadData];
        [self checkFooter];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接失败啦~。~"];
        [self checkFooter];
    }];

}
-(void)loadMoreUsers
{
    XYSLeftRecommendModel *leftRecommendModel = CurrentSelectedLeft;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"subscribe";
    parameters[@"category_id"] = @(leftRecommendModel.ID);
    parameters[@"page"] = @(++leftRecommendModel.current_page);
    self.parameters = parameters;
    [self.manger GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.parameters!=parameters) return ;

        //字典转模型
        //XYSLog(@"%@",responseObject);
        NSArray *recommendUsers = [XYSRightRecommendUserModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //将推荐用户添加到左侧model里
        [leftRecommendModel.listOfRecommendUser addObjectsFromArray:recommendUsers];
        
        [self.rightUserTableView reloadData];
        [self checkFooter];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.parameters!=parameters) return ;

        [SVProgressHUD showErrorWithStatus:@"网络连接失败啦~。~"];
        [self checkFooter];
    }];

}
-(void)checkFooter
{
    XYSLeftRecommendModel *leftRecommendModel = CurrentSelectedLeft;
    [self.rightUserTableView.mj_header endRefreshing];

    if (leftRecommendModel.listOfRecommendUser.count == leftRecommendModel.totalRecommendUser) {
        [self.rightUserTableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.rightUserTableView.mj_footer endRefreshing];
    }
    
}
/**
 *  结束所有的refresh
 */
-(void)endRefreshAll
{
    [self.rightUserTableView.mj_header endRefreshing];
    [self.rightUserTableView.mj_footer endRefreshing];
}

#pragma mark -<UITableViewDelegate,UITableViewDataSource>

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftTableView) {
        return self.listOfLeftRecommendModel.count;
    }else{
        XYSLeftRecommendModel* leftRecommendModel = CurrentSelectedLeft;
        return leftRecommendModel.listOfRecommendUser.count;
    }
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) {
        XYSLeftRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:leftCellId];
        cell.leftRecommendModel = self.listOfLeftRecommendModel[indexPath.row];
        return cell;
    }else{
        XYSRightRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:rightCellId];
        XYSLeftRecommendModel *leftRecommendModel = CurrentSelectedLeft;
        cell.rightRecommendUserModel = leftRecommendModel.listOfRecommendUser[indexPath.row];
        [self checkFooter];
        return cell;
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self endRefreshAll];
    XYSLeftRecommendModel *leftRecommendModel = self.listOfLeftRecommendModel[indexPath.row];
    [self.rightUserTableView reloadData];
    if (!leftRecommendModel.listOfRecommendUser.count) {
        [self.rightUserTableView.mj_header beginRefreshing];
    }
}
/**
 *  为了防止网络请求中退出该界面，但是网络请求回来调用self.parameters造成的崩溃
 *  所以直接销毁manger
 */
-(void)dealloc
{
    [self.manger.operationQueue cancelAllOperations];
}

@end
