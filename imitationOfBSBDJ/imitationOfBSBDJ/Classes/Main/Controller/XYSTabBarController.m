//
//  XYSTabBarController.m
//  simulateBS
//
//  Created by 徐烨晟 on 16/6/26.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSTabBarController.h"
#import "XYSTabBar.h"
#import "XYSNavigationController.h"
#import "XYSEssenceViewController.h"
#import "XYSNewViewController.h"
#import "XYSFriendTrendsViewController.h"
#import "XYSMeViewController.h"
@implementation XYSTabBarController
+(void)initialize
{
    
    UITabBarItem *itemAppearance = [UITabBarItem appearance];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [itemAppearance setTitleTextAttributes:attributes forState:UIControlStateSelected];

}

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpAllChildViewConntroller];
    [self setValue:[[XYSTabBar alloc]init] forKey:@"tabBar"];

}
-(void)setUpAllChildViewConntroller
{
    XYSEssenceViewController *essenceViewController = [[XYSEssenceViewController alloc]init];
    XYSNewViewController *newViewController = [[XYSNewViewController alloc]init];
    XYSFriendTrendsViewController *friendTrendsViewController = [[XYSFriendTrendsViewController alloc]init];
    XYSMeViewController *meViewController = [[XYSMeViewController alloc]init];

    
    [self setUpChildViewController:essenceViewController title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setUpChildViewController:newViewController title:@"最新" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setUpChildViewController:friendTrendsViewController title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setUpChildViewController:meViewController title:@"我的" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    
}

-(void)setUpChildViewController:(UIViewController*)vc title:(NSString*)title image:(NSString*)image selectedImage:(NSString *)selectedImage
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    [self addChildViewController:[[XYSNavigationController alloc]initWithRootViewController:vc]];
    
}
@end
