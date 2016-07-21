//
//  XYSNavigationController.m
//  simulateBS
//
//  Created by 徐烨晟 on 16/6/26.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSNavigationController.h"
#import <SVProgressHUD.h>
@interface XYSNavigationController ()

@end

@implementation XYSNavigationController
/*
 *一次性的设置，如appearance，最好放在initialize中，这个类初始化话的时候只会执行一次。
 */
+(void)initialize
{
    UINavigationBar *navigationbar= [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    [navigationbar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    [navigationbar setTitleTextAttributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}];
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
    NSMutableDictionary *disbaleAttrs = [NSMutableDictionary dictionary];
    disbaleAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:disbaleAttrs forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
   if(self.childViewControllers.count>0)
   {
       UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
       
       [btn setTitle:@"返回" forState:UIControlStateNormal];
       [btn setTitle:@"返回" forState:UIControlStateHighlighted];
       [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
       [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
       [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
       [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
       
       btn.xys_size = CGSizeMake(100, 30);
       btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
       btn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
       
       
       [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
       viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
       
       //跳转到评论vc时隐藏tabbar
       viewController.hidesBottomBarWhenPushed = YES;
   }
    
    [super pushViewController:viewController animated:animated];
    
}

-(void)back
{
    [self popViewControllerAnimated:YES];
    [SVProgressHUD dismiss];
}
@end
