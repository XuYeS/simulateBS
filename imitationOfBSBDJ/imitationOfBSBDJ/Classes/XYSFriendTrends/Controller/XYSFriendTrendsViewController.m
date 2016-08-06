//
//  XYSFriendTrendsViewController.m
//  simulateBS
//
//  Created by 徐烨晟 on 16/6/26.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSFriendTrendsViewController.h"
#import "XYSRecommendController.h"
#import "XYSLoginRegisterController.h"
@interface XYSFriendTrendsViewController ()


@end

@implementation XYSFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = XYSBackGroundColor ;
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" selectedImage:@"friendsRecommentIcon-click" target:self action:@selector(addFriends)];
}

-(void)addFriends
{
    XYSRecommendController *recommendController = [[XYSRecommendController alloc]init];
    [self.navigationController pushViewController:recommendController animated:YES];
    
}
- (IBAction)login:(UIButton *)sender {
    XYSLoginRegisterController *loginRigister = [[XYSLoginRegisterController alloc]init];
    
    if ([sender.titleLabel.text isEqualToString:@"登陆"]) {
        loginRigister.isLogin = YES;
        [self.navigationController presentViewController:loginRigister animated:YES completion:nil];
    }else{
        loginRigister.isLogin = NO;
        [self.navigationController presentViewController:loginRigister animated:YES completion:nil];

    }
    
    
}


@end
