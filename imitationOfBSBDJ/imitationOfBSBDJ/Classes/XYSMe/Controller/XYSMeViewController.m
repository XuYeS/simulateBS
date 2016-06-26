//
//  XYSMeViewController.m
//  simulateBS
//
//  Created by 徐烨晟 on 16/6/26.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSMeViewController.h"

@interface XYSMeViewController ()

@end

@implementation XYSMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = XYSBackGroundColor ;
    self.navigationItem.title = @"我的";
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" selectedImage:@"mine-setting-icon-click" target:self action:@selector(enterSetting)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" selectedImage:@"mine-moon-icon-click" target:self action:@selector(moonMode)];
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
}
-(void)enterSetting
{
    XYSLogFuc;
}
-(void)moonMode
{
    XYSLogFuc;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
