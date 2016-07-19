//
//  XYSTopicController.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/6.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSTopicController.h"
#import "XYSTopicModel.h"
#import "XYSTopicCell.h"
#import "XYSCommentController.h"
#import "XYSNewViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import <MJRefresh.h>
@interface XYSTopicController ()
/** 模型集合*/
@property (strong,nonatomic)NSMutableArray *listOfTopicModel;
/**AFN*/
@property (strong,nonatomic)AFHTTPSessionManager *manager;
/**网络参数*/
@property (strong,nonatomic)NSMutableDictionary *parameters;
/**MaxTime*/
@property (copy,nonatomic) NSString *maxtime;
/** 当前页码 */
@property (nonatomic, assign) NSInteger page;

/**  a参数 */
@property (copy,nonatomic)NSString *a;

@end

@implementation XYSTopicController
static NSString * cellId = @"topicCell";
#pragma mark - lazy
-(AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
-(NSMutableArray *)listOfTopicModel
{
    if (!_listOfTopicModel) {
        _listOfTopicModel = [NSMutableArray array];
    }
    return _listOfTopicModel;
}




#pragma mark - viewdidload
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XYSBackGroundColor;
    self.title = @"段子";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setUpTableView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tabBarClick) name:XYSTabBarDidSelectNotification object:nil];

}
-(void)tabBarClick
{
    [self.tableView.mj_header beginRefreshing];
}
-(void)setUpTableView
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYSTopicCell class]) bundle:nil] forCellReuseIdentifier:cellId];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshTopics)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}
-(NSString *)a
{
    if ([self.parentViewController isKindOfClass:[XYSNewViewController class]]) {
        return @"newlist";
    }else{
        return @"list";
    }
}
/**
 *  下拉刷新
 */
-(void)refreshTopics
{
    [self endRefreshAll];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = self.a;
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    self.parameters = parameters;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.parameters != parameters) return;
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //字典转模型
        self.listOfTopicModel= [XYSTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新tableview
        [self.tableView reloadData];
        
        self.page = 0;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.parameters != parameters) return;

        
        [SVProgressHUD showErrorWithStatus:@"网络连接失败~。~"];
        
        [self endRefreshAll];
    }];
}
/**
 *  上拉刷新
 */
-(void)loadMoreTopics
{
    [self endRefreshAll];
    //参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = self.a;
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.type);
    NSInteger page = self.page++;
    parameters[@"page"] =@(page);
    parameters[@"maxtime"] = self.maxtime;
    self.parameters = parameters;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.parameters != parameters) return;

        self.maxtime = responseObject[@"info"][@"maxtime"];
        //字典转模型
        NSArray *newModelArray = [XYSTopicModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //模型加入模型列表
        [self.listOfTopicModel  addObjectsFromArray:newModelArray];
        
        //刷新tableview
        [self.tableView reloadData];
        
        
        self.page = page;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.parameters != parameters) return;

        [SVProgressHUD showErrorWithStatus:@"网络连接失败~。~"];
        self.page = self.page--;
        [self endRefreshAll];
    }];
}
/**
 *  结束上下拉
 */
- (void)endRefreshAll
{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
/**
 *  显示评论界面
 */
-(void)showComment:(NSIndexPath *)indexPath
{
    XYSCommentController *cc = [[XYSCommentController alloc]init];
    cc.topicModel = self.listOfTopicModel[indexPath.row];
    [self.navigationController pushViewController:cc animated:YES];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listOfTopicModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYSTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.topicModel = self.listOfTopicModel[indexPath.row];
    cell.commentTap = ^{
        [self showComment:indexPath];
    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYSTopicModel *model = self.listOfTopicModel[indexPath.row];
    return model.topicCellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self showComment:indexPath];
}

@end
