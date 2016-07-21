//
//  XYSMeExtensionView.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/20.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSMeExtensionView.h"
#import "XYSMeExtensionModel.h"
#import "XYSMeExtensionButton.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
@interface XYSMeExtensionView()
@property (strong,nonatomic)NSArray *listOfMeExtensionModel;
@end
@implementation XYSMeExtensionView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self setUpMeExtension];
    
    }
    
    return self;
}
/**
 *  获取模型参数
 */
-(void)setUpMeExtension
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.listOfMeExtensionModel = [XYSMeExtensionModel mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        [self creatMeExtensionButton];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接失败了~。~"];
    }];
 
}
/**
 *  创建button
 */
-(void)creatMeExtensionButton
{
    NSInteger totalBtnNum = self.listOfMeExtensionModel.count/4;
    NSInteger maxLineNum = 4;
    CGFloat btnW = screenWidth/maxLineNum;
    CGFloat btnH = btnW;
    for (int i = 0; i<totalBtnNum; i++) {
        XYSMeExtensionButton *btn = [[XYSMeExtensionButton alloc]init];
        
        NSInteger row = i/4;
        NSInteger line = i%4;
        
        btn.meExtensionModel = self.listOfMeExtensionModel[i];
        
        btn.xys_width = btnW;
        btn.xys_height = btnH;
        
        btn.xys_x = line * btnW;
        btn.xys_y = row*btnH;
        
        [self addSubview:btn];
        
    }
    //更多按钮
    XYSMeExtensionButton *btn = [[XYSMeExtensionButton alloc]init];
    NSInteger row = totalBtnNum/4;
    NSInteger line = totalBtnNum%4;
    btn.xys_width = btnW;
    btn.xys_height = btnH;
    btn.xys_x = line * btnW;
    btn.xys_y = row*btnH;
    [btn setTitle:@"更多" forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
    [self addSubview:btn];
    
    
    // 总页数 == (总个数 + 每页的最大数 - 1) / 每页最大数
    NSUInteger rows = ((totalBtnNum+1) + maxLineNum - 1) / maxLineNum;
    // 计算footer的高度
    self.xys_height = rows * btnH;
    // 重绘
    //[self setNeedsDisplay];

    
}

@end
