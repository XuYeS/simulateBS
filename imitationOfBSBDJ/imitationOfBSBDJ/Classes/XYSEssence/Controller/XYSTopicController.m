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

}
-(void)setUpTableView
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYSTopicCell class]) bundle:nil] forCellReuseIdentifier:cellId];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshTopics)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshBackStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}

-(void)refreshTopics
{
    [self endRefreshAll];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
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
-(void)loadMoreTopics
{
    [self endRefreshAll];
    //参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
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

- (void)endRefreshAll
{
    //结束上下拉
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listOfTopicModel.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYSTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.topicModel = self.listOfTopicModel[indexPath.row];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYSTopicModel *model = self.listOfTopicModel[indexPath.row];
    return model.topicCellHeight;
}

@end