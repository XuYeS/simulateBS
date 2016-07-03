//
//  XYSEssenceViewController.m
//  simulateBS
//
//  Created by 徐烨晟 on 16/6/26.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSEssenceViewController.h"
#import "XYSRecommendTableViewController.h"
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
    XYSRecommendTableViewController *rtvc = [[XYSRecommendTableViewController alloc]init];
    [self.navigationController pushViewController:rtvc animated:YES];
}



@end
