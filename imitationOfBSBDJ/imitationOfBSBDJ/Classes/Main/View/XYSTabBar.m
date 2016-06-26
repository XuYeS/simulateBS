//
//  XYSTabBar.m
//  simulateBS
//
//  Created by 徐烨晟 on 16/6/26.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSTabBar.h"
@interface XYSTabBar()
/**发布按钮*/
@property (strong,nonatomic)UIButton *publishButton;
@end

@implementation XYSTabBar
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton *publishButton = [[UIButton alloc]init];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [publishButton addTarget:self action:@selector(tapPublish) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:publishButton];
        self.publishButton = publishButton;
        
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
    }

    return self;
}

-(void)tapPublish
{
    XYSLogFuc;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.publishButton.bounds = CGRectMake(0, 0,self.publishButton.currentBackgroundImage.size.width,self.publishButton.currentBackgroundImage.size.height);
    self.publishButton.center = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5);
    
    CGFloat oneWidth = self.bounds.size.width/5.0;
    NSInteger index = 0;
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:[UIControl class]]||button==self.publishButton) {
            continue;
        }
        else
        {
            button.frame = CGRectMake(oneWidth * ((index>1)?(index+1):(index)), 0, oneWidth, self.bounds.size.height);
            index++;
        }
        
    }
    }



@end

