//
//  XYSEssenceViewController.m
//  simulateBS
//
//  Created by 徐烨晟 on 16/6/26.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSEssenceViewController.h"
#import "XYSRecommendTableViewController.h"
#import "XYSTopicController.h"

@interface XYSEssenceViewController () <UIScrollViewDelegate>
/** 红色的下标*/
@property (weak,nonatomic)UIView* redMarkView;
/** 装载button的scrollView*/
@property (strong,nonatomic)UIScrollView * tagView;
/** 现在选中的button*/
@property (weak,nonatomic)UIButton* currentSelectButton;
/** 背景的scrollView */
@property (strong,nonatomic)UIScrollView * contentView;

@end

@implementation XYSEssenceViewController
#pragma mark -lazy

#pragma mark -viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化顺序很重要，setUpTagView要在SetUpBackgroundContentView之后，不然会数组越界
    [self setUpNavigation];
    [self setupChildVCs];
    [self SetUpBackgroundContentView];
    [self setUpTagView];

    
}
/**
 *  设置navigation
 */
- (void)setUpNavigation
{
    self.view.backgroundColor = XYSBackGroundColor ;
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" selectedImage:@"MainTagSubIconClick" target:self action:@selector(moreEssence)];
}

/**
 * 初始化子控制器
 */
- (void)setupChildVCs
{
    
    XYSTopicController *picture = [[XYSTopicController alloc] init];
    picture.title = @"图片";
    picture.type = XYSTopicTypePicture;
    [self addChildViewController:picture];
    
    XYSTopicController *all = [[XYSTopicController alloc] init];
    all.title = @"全部";
    all.type = XYSTopicTypeAll;
    [self addChildViewController:all];
    
    XYSTopicController *video = [[XYSTopicController alloc] init];
    video.title = @"视频";
    video.type = XYSTopicTypeVideo;
    [self addChildViewController:video];
    
    XYSTopicController *voice = [[XYSTopicController alloc] init];
    voice.title = @"声音";
    voice.type = XYSTopicTypeVoice;
    [self addChildViewController:voice];
    
    XYSTopicController *joke = [[XYSTopicController alloc] init];
    joke.title = @"段子";
    joke.type = XYSTopicTypeJoke;
    [self addChildViewController:joke];
}
/**
 *  设置背景scrollView
 */
- (void)SetUpBackgroundContentView
{
    UIScrollView *contentView = [[UIScrollView alloc]init];
    //contentView.backgroundColor = [UIColor orangeColor];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    contentView.contentSize = CGSizeMake(contentView.xys_width * self.childViewControllers.count, 0);
    [self.view insertSubview:contentView atIndex:0];
    
    self.contentView = contentView;
}

/**
 *  设置频道选择标签
 */
- (void)setUpTagView
{
    CGFloat height = 40.0;
    //背景scrollView
    UIScrollView *tagView = [[UIScrollView alloc]init];
    tagView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    tagView.xys_y = NavigationBarButtomY;
    tagView.xys_width = screenWidth;
    tagView.xys_height = height;

        //- -奇怪，设置成0不行，设置成负数就可以不上下拉了。。。
    [tagView setContentSize:CGSizeMake((screenWidth/5.0)*self.childViewControllers.count, -height)];
    
    CGPoint contentOffset = tagView.contentOffset;
    contentOffset = CGPointZero;
    tagView.contentOffset = contentOffset;
    
    [self.view addSubview:tagView];
    self.tagView = tagView;
    
    //红色指示器
    UIView *redMakerView = [[UIView alloc]init];
    redMakerView.xys_height = 4.0;
    redMakerView.backgroundColor = [UIColor redColor];
    redMakerView.xys_y = height-redMakerView.xys_height;
    self.redMarkView = redMakerView;
    [self.tagView addSubview:self.redMarkView];
    
    //按钮
    CGFloat buttonWeight = tagView.contentSize.width/self.childViewControllers.count;
    
    for (int i = 0; i<self.childViewControllers.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTag:i];
        btn.xys_height = height;
        btn.xys_width = buttonWeight;
        btn.xys_x = i*buttonWeight;
        [btn setTitle:self.childViewControllers[i].title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(selectTopic:) forControlEvents:UIControlEventTouchUpInside];
        [self.tagView insertSubview:btn atIndex:btn.tag];
        
        // 默认点击了第一个按钮
        if (i == 0) {
            btn.enabled = NO;
            self.currentSelectButton = btn;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [btn.titleLabel sizeToFit];
            self.redMarkView.xys_width = btn.titleLabel.xys_width;
            self.redMarkView.xys_centerX = btn.xys_centerX;
            [self scrollViewDidEndScrollingAnimation:self.contentView];
        }

    }

}
/**
 *  选择不同的topic
 *
 *  @param button 选中的button
 */
- (void)selectTopic:(UIButton *)button
{
    //红色指示器位置的改变
    self.currentSelectButton.enabled = YES;
    self.currentSelectButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    button.enabled = NO;
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    
    self.currentSelectButton = button;
    [UIView animateWithDuration:0.3 animations:^{
        self.redMarkView.xys_width = button.titleLabel.xys_width;
        self.redMarkView.xys_centerX = button.xys_centerX;

    }];
    //不同按钮对应的子控制器view的出现
    CGPoint contentOffset = self.contentView.contentOffset;
    contentOffset.x = button.tag*self.contentView.xys_width;
    [self.contentView setContentOffset:contentOffset animated:NO];
    [self showTopic];

}
-(void)showTopic
{
    
    NSInteger index = self.contentView.contentOffset.x/self.contentView.xys_width;
    UITableViewController *tvc = self.childViewControllers[index];
    tvc.view.xys_x = self.contentView.contentOffset.x;
    tvc.view.xys_y = 0;
    tvc.view.xys_height = self.contentView.xys_height;
    
    CGFloat bottom = self.tabBarController.tabBar.xys_height;
    CGFloat top = self.tagView.xys_height;
    tvc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    [self.contentView addSubview:tvc.view];
}
#pragma mark - <UIScrollViewDelegate>


/**
 *  动画滑动后加载子控制器的view（必须是动画才行，手动滑动不会进入）
 */
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/scrollView.xys_width;
    UITableViewController *tvc = self.childViewControllers[index];
    tvc.view.xys_x = scrollView.contentOffset.x;
    tvc.view.xys_y = 0;
    tvc.view.xys_height = scrollView.xys_height;
    
    CGFloat bottom = self.tabBarController.tabBar.xys_height;
    CGFloat top = self.tagView.xys_height;
    tvc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);

    [scrollView addSubview:tvc.view];
    
    
}
/**
 *  手动拖拽结束
 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/scrollView.xys_width;
    UIButton* btn = self.tagView.subviews[index];
    [self selectTopic:btn];
    [self scrollViewDidEndScrollingAnimation:scrollView];

}

#pragma mark - buttonTapSector
/**
 *  点击进入推荐标签
 */
- (void)moreEssence
{
    XYSRecommendTableViewController *rtvc = [[XYSRecommendTableViewController alloc]init];
    [self.navigationController pushViewController:rtvc animated:YES];
}



@end
