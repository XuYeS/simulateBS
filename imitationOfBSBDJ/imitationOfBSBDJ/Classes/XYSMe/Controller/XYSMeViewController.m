//
//  XYSMeViewController.m
//  simulateBS
//
//  Created by 徐烨晟 on 16/6/26.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSMeViewController.h"
#import "XYSMeCell.h"
#import "XYSLoginRegisterController.h"
#import "XYSMeExtensionView.h"
#import "XYSMeExtensionModel.h"

@interface XYSMeViewController ()

@end

@implementation XYSMeViewController

static NSString *meCellId = @"meCell";

/**
 *  修改tableView样式为group
 */
-(instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setup];
    [self setUpTableView];
}
/**
 *  初始化navigation
 */
-(void)setup
{
    self.view.backgroundColor = XYSBackGroundColor ;
    self.navigationItem.title = @"我的";
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" selectedImage:@"mine-setting-icon-click" target:self action:@selector(enterSetting)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" selectedImage:@"mine-moon-icon-click" target:self action:@selector(moonMode)];
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
    
}
/**
 *  初始化tableView
 */
-(void)setUpTableView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = XYSTopicCellMargin;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    
    [self.tableView registerClass:[XYSMeCell class] forCellReuseIdentifier:meCellId];
    XYSMeExtensionView *mev = [[XYSMeExtensionView alloc]init];
    self.tableView.tableFooterView =mev;
 
}

-(void)enterSetting
{
    XYSLogFuc;
}
-(void)moonMode
{
    XYSLogFuc;
}


#pragma mark - <UITableViewDateSource>

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYSMeCell *cell = [tableView dequeueReusableCellWithIdentifier:meCellId];
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"defaultUserIcon"];
        cell.textLabel.text = @"登陆/注册";
    }else if(indexPath.section == 1)
    {
        cell.textLabel.text = @"我的身份";
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYSLoginRegisterController *lrc = [[XYSLoginRegisterController alloc]init];
    [self presentViewController:lrc animated:YES completion:nil];
}

@end
