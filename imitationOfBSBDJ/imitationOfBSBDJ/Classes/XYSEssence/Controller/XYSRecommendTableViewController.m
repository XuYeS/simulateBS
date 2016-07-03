//
//  XYSRecommendTableViewController.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/3.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSRecommendTableViewController.h"
#import "XYSRecommendTagModel.h"
#import "XYSRecommendTagCell.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
@interface XYSRecommendTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic)NSMutableArray *listOfRecommendModel;

@property (strong,nonatomic)AFHTTPSessionManager *manger;

@end

@implementation XYSRecommendTableViewController
static NSString* recommendTagId = @"recommendTagCell";

-(AFHTTPSessionManager *)manger
{
    if (!_manger) {
        _manger = [AFHTTPSessionManager manager];
    }
    return _manger;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
    [self getRecommendTags];
    
    
}
/**
 *  初始化tableView
 */
-(void)setUpTableView
{
    self.view.backgroundColor = XYSBackGroundColor;
    self.tableView.rowHeight = 80;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYSRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:recommendTagId];
}
/**
 *获取左侧网络请求数据
 */
-(void)getRecommendTags
{
    [SVProgressHUD show];//显示HUB
    //--------------------------------网络请求--------------------------------
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"c"] = @"topic";
    parameters[@"action"] = @"sub";
    
    [self.manger GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];//取消HUB
        //字典转模型
        self.listOfRecommendModel= [XYSRecommendTagModel mj_objectArrayWithKeyValuesArray:responseObject];
        //重写刷新tableview
        [self.tableView reloadData];
        //进入后默认选中第一行
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接失败啦~。~"];
    }];
    //----------------------------------------------------------------
}

#pragma mark - <UITableViewDataSource,UITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listOfRecommendModel.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XYSRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendTagId forIndexPath:indexPath];
    
    cell.recommendTagModel = self.listOfRecommendModel[indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
