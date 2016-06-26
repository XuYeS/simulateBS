//
//  XYSEssenceViewController.m
//  simulateBS
//
//  Created by 徐烨晟 on 16/6/26.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSEssenceViewController.h"

@interface XYSEssenceViewController ()

@end

@implementation XYSEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = XYSBackGroundColor ;
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" selectedImage:@"MainTagSubIconClick" target:self action:@selector(moreEssence)];
}

-(void)moreEssence
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
