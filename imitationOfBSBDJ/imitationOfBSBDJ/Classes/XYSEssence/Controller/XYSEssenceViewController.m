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
/**
 *  红色的下标
 */
@property (weak,nonatomic)UIView* redMarkView;
@property (strong,nonatomic)UIScrollView * tagView;
@property (weak,nonatomic)UIButton* currentSelectButton;
@end

@implementation XYSEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavigation];
    [self setUpTagView];
    
}
/**
 *  设置navigation
 */
-(void)setUpNavigation
{
    self.view.backgroundColor = XYSBackGroundColor ;
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" selectedImage:@"MainTagSubIconClick" target:self action:@selector(moreEssence)];
}
/**
 *  设置频道选择标签
 */
-(void)setUpTagView
{
    self.navigationController.navigationBar.translucent = NO;
    CGFloat height = 40.0;
    
    NSArray* tagButtonTitle = @[@"全部",@"图片",@"视频",@"声音",@"段子",@"全部",@"图片",@"视频",@"声音",@"段子"];
    UIScrollView *tagView = [[UIScrollView alloc]init];
    tagView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];

    tagView.xys_width = screenWidth;
    tagView.xys_height = height;

    //奇怪，设置成0不行，设置成负数就可以不上下拉了。。。
    [tagView setContentSize:CGSizeMake((screenWidth/6.0)*tagButtonTitle.count, -height)];
    
    
    CGPoint contentOffset = tagView.contentOffset;
    contentOffset = CGPointZero;
    tagView.contentOffset = contentOffset;
    
    [self.view addSubview:tagView];
    self.tagView = tagView;
    
    
    CGFloat buttonWeight = tagView.contentSize.width/tagButtonTitle.count;
    
    for (int i = 0; i<tagButtonTitle.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.xys_height = height;
        btn.xys_width = buttonWeight;
        btn.xys_x = i*buttonWeight;
        [btn setTitle:tagButtonTitle[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(redMakerChange:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.tagView addSubview:btn];
        
    }
    
    UIView *redMakerView = [[UIView alloc]init];
    
    redMakerView.xys_height = 4.0;
    redMakerView.backgroundColor = [UIColor redColor];
    redMakerView.xys_y = height-redMakerView.xys_height;
    self.redMarkView = redMakerView;
    [self.tagView addSubview:self.redMarkView];
    
    
}
-(void)redMakerChange:(UIButton *)button
{
    self.currentSelectButton.enabled = YES;
    self.currentSelectButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    button.enabled = NO;
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    
    self.currentSelectButton = button;
    [UIView animateWithDuration:0.3 animations:^{
        self.redMarkView.xys_width = button.titleLabel.xys_width;
        self.redMarkView.xys_centerX = button.xys_centerX;

    }];
}

-(void)moreEssence
{
    XYSRecommendTableViewController *rtvc = [[XYSRecommendTableViewController alloc]init];
    [self.navigationController pushViewController:rtvc animated:YES];
}



@end
