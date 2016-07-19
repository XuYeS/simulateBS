//
//  XYSCommentController.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/17.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSCommentController.h"
#import "XYSTopicModel.h"
#import "XYSTopicCell.h"
#import "XYSCommentCell.h"
#import "XYSTopCommentModel.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import <SVProgressHUD.h>
@interface XYSCommentController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *keyboardConstraint;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 总评论数*/
@property (assign,nonatomic)NSInteger total;
/** 热门评论*/
@property (strong,nonatomic)NSMutableArray *listOfHotComment;
/** 普通评论*/
@property (strong,nonatomic)NSMutableArray *listOfComment;
/** 最后一个评论的ID*/
@property (strong,nonatomic)NSString *lastId;

/** AFN manger*/
@property (strong,nonatomic)AFHTTPSessionManager *manger;
@end

@implementation XYSCommentController
#pragma mark - lazy
-(AFHTTPSessionManager *)manger
{
    if (!_manger) {
        _manger = [AFHTTPSessionManager manager];
    }
    return _manger;
}

#pragma mark - init

static NSString *commentCellId = @"commentCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论";
    self.tableView.backgroundColor = XYSBackGroundColor;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" selectedImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    //监听键盘弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.tableView.estimatedRowHeight = 40;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self setUpHeaderCell];
    
    [self setUpTableViewCell];
    
    [self setUpRefresh];
    
    
}
/**
 *  键盘弹出后处理函数
 *
 *  @param note 键盘弹出过程中的具体信息
 */
-(void) keyboardWillChangeFrame:(NSNotification *)note
{
    CGRect KeyboardEndFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyboardConstraint.constant = screenHeight - KeyboardEndFrame.origin.y;
   
    // 动画
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}
/**
 *  设置该topic的内容在头部
 */
-(void)setUpHeaderCell
{
    UIView *headerCellView = [[UIView alloc]init];
    
    XYSTopicCell *cell = [XYSTopicCell cell];
    cell.topicModel = self.topicModel;
    cell.xys_size = CGSizeMake(screenWidth, cell.topicModel.topicCellHeight);
    
    [headerCellView addSubview:cell];
    
    headerCellView.xys_height = cell.topicModel.topicCellHeight + XYSTopicCellMargin;
    
    self.tableView.tableHeaderView = headerCellView;
    
}
/**
 *  设置评论cell
 */
-(void)setUpTableViewCell
{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XYSCommentCell class]) bundle:nil] forCellReuseIdentifier:commentCellId];
}
/**
 *  设置refresh头
 */
-(void)setUpRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self
                                                                refreshingAction:@selector(loadNewComment)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComment)];
}
/**
 *  获取网络数据
 */
-(void)loadNewComment
{
    //取消其他所有网络任务
    [self.manger.tasks makeObjectsPerformSelector:@selector(cancel)];
    //参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"dataList";
    parameters[@"c"] = @"comment";
    parameters[@"data_id"] = self.topicModel.ID;
    parameters[@"hot"] = @"1";
    
    [self.manger GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //防止服务器没有评论数据返回一个空数组而崩溃
        self.total = [responseObject[@"total"] integerValue];
        if ([responseObject isKindOfClass:[NSArray class]]) {
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            return ;
        }else{
            self.listOfHotComment = [XYSTopCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
            
            self.listOfComment = [XYSTopCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            
            XYSTopCommentModel *lastmodel = [self.listOfComment lastObject];
            self.lastId =lastmodel.commentId;
            
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];

        [SVProgressHUD showErrorWithStatus:@"网络连接失败~。~"];
    }];

}
-(void)loadMoreComment
{
    //取消其他所有网络任务
    [self.manger.tasks makeObjectsPerformSelector:@selector(cancel)];
    //参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"dataList";
    parameters[@"c"] = @"comment";
    parameters[@"data_id"] = self.topicModel.ID;
    parameters[@"hot"] = @"1";
    parameters[@"lastcid"] = self.lastId;
    
    [self.manger GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //防止服务器没有评论数据返回一个空数组而崩溃
        if ([responseObject isKindOfClass:[NSArray class]]) {
            [self.tableView reloadData];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return ;
        }else{
            NSArray *commentArray = [XYSTopCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.listOfComment addObjectsFromArray:commentArray];
            //判断是否还有新数据
            if (self.listOfComment.count >=self.total) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }else
            {
                XYSTopCommentModel *lastmodel = [self.listOfComment lastObject];
                self.lastId =lastmodel.commentId;
                
                [self.tableView reloadData];
                [self.tableView.mj_footer endRefreshing];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
        
        [SVProgressHUD showErrorWithStatus:@"网络连接失败~。~"];
    }];
}
/**
 *  结束后释放掉通知监听者
 */
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    [self.manger invalidateSessionCancelingTasks:YES];
}


/**
 * 返回第section组的所有评论数组
 */
- (NSArray *)commentsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.listOfHotComment.count ? self.listOfHotComment : self.listOfComment;
    }
    return self.listOfComment;
}

- (XYSTopCommentModel *)commentInIndexPath:(NSIndexPath *)indexPath
{
    return [self commentsInSection:indexPath.section][indexPath.row];
}
#pragma mark -<UITableViewDataSource>
/**
 *  设置有几个分组
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger hotNum = self.listOfHotComment.count;
    NSInteger nomalNum = self.listOfComment.count;
    
    if (hotNum)return 2;
    if (nomalNum) return 1;
    
    return 0;
}
/**
 *  设置分组名称
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSInteger hotNum = self.listOfHotComment.count;
    if (section == 0) {
        return hotNum ? @"最热评论" : @"最新评论";
    }
    return @"最新评论";
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotNum = self.listOfHotComment.count;
    NSInteger nomalNum = self.listOfComment.count;
    
    if (section == 0) {
        return hotNum ? hotNum : nomalNum;
    }
    return nomalNum;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYSCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCellId];
    cell.commentModel = [self commentInIndexPath:indexPath];
    return cell;
}
#pragma mark - <UITableViewDelegate>
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

@end
