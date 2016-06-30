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
#import "XYSRecommendController.h"
#import "XYSLeftRecommendCell.h"
#import "XYSLeftRecommendModel.h"
@interface XYSRecommendController()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)NSArray *listOfLeftRecommendModel;
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@end

@implementation XYSRecommendController
static NSString *leftCellId = @"leftRecommendCell";

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = XYSBackGroundColor ;
    self.navigationItem.title = @"推荐关注";
    //注册xib 的cell 需要 registerNib
    [self.leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYSLeftRecommendCell class]) bundle:nil] forCellReuseIdentifier:leftCellId];

    [SVProgressHUD setBackgroundColor:[UIColor darkGrayColor]];
    [SVProgressHUD show];//显示HUB
    
//--------------------------------网络请求--------------------------------
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"category";
    parameters[@"c"] = @"subscribe";
    
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];//取消HUB
        //字典转模型
        self.listOfLeftRecommendModel = [XYSLeftRecommendModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //重写刷新tableview
        [self.leftTableView reloadData];
        //进入后默认选中第一行
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD setStatus:@"网络连接失败啦~。~"];
    }];
 //----------------------------------------------------------------
}

#pragma mark -<UITableViewDelegate,UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listOfLeftRecommendModel.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYSLeftRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:leftCellId];
    cell.leftRecommendModel = self.listOfLeftRecommendModel[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYSLeftRecommendModel *model = self.listOfLeftRecommendModel[indexPath.row];
    XYSLog(@"%zd",model.ID);
}

@end
