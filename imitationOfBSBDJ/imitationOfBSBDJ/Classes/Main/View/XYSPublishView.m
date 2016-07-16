//
//  XYSPublishView.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/13.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSPublishView.h"
#import <POPSpringAnimation.h>
#import "XYSVerticalButton.h"
@implementation XYSPublishView

static UIWindow * window_;

+(instancetype)showPublishView
{
    XYSPublishView *view = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    window_ = [[UIWindow alloc]init];
    window_.backgroundColor = [UIColor clearColor];
    window_.windowLevel = UIWindowLevelAlert;
    view.frame = window_.bounds;
    [window_ addSubview:view];
    window_.hidden = NO;
    
    return view;
}

-(void)awakeFromNib
{

    self.userInteractionEnabled = NO;
    //button
    NSArray *btnImageName = @[@"publish-audio",@"publish-offline",@"publish-picture",@"publish-review",@"publish-text",@"publish-video"];
    NSArray *btnTitleName = @[@"发声音",@"离线",@"图片",@"审帖",@"发段子",@"发视频"];
    CGFloat btnW = 72;
    CGFloat btnH = btnW +30;
    CGFloat startX = 20;
    CGFloat startY = 250;
    NSInteger maxRowNume = 3;
    CGFloat btnMargin =1.0*([UIScreen mainScreen].bounds.size.width - 2*startX - 3*btnW)/(maxRowNume-1);
    
    for (int i = 0; i<btnImageName.count; i++) {
        XYSVerticalButton *btn = [XYSVerticalButton buttonWithType:UIButtonTypeCustom];
        
        
        [btn setImage:[UIImage imageNamed:btnImageName[i]] forState:UIControlStateNormal];
        [btn setTitle:btnTitleName[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.xys_width = btnW;
        btn.xys_height = btnH;
        int row = i % maxRowNume;
        int col = i / maxRowNume;
        CGFloat btnX = startX + row * (btnW + btnMargin);
        CGFloat btnY = startY+col*(btnH + 20);
        btn.xys_x = - (startX + row * (btnW + btnMargin));
        btn.xys_y = - (startY+col*(btnH + 20));
        
        //添加弹簧效果
        POPSpringAnimation *anima = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anima.fromValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnY - 1000, btnW, btnH)];
        anima.toValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnY , btnW, btnH)];
        anima.springBounciness = 1;
        anima.springSpeed = 1;
        anima.beginTime = CACurrentMediaTime() + 0.1*i ;
        [btn pop_addAnimation:anima forKey:nil];
        
        [self addSubview:btn];


        
    }
    
    //slogan
    UIImageView *sloganImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"app_slogan"]];
    CGFloat sloganImageCenterX = [UIScreen mainScreen].bounds.size.width*0.5;
    CGFloat sloganImageY = 150;
    sloganImage.xys_centerX = -sloganImageCenterX;
    [self addSubview:sloganImage];
    //弹簧动画
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(sloganImageCenterX, 0)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(sloganImageCenterX, sloganImageY)];
    animation.springBounciness = 1;
    animation.springSpeed = 1;
    animation.beginTime = CACurrentMediaTime() + btnImageName.count*0.1;
    [sloganImage pop_addAnimation:animation forKey:nil];
    [animation setCompletionBlock:^(POPAnimation *anima, BOOL finished) {
        self.userInteractionEnabled = YES;
    }];
    
   
}
- (IBAction)back{
    
    for (int i = 1; i<self.subviews.count; i++) {
        UIView *subView = self.subviews[i];
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
        animation.toValue = [NSValue valueWithCGPoint:CGPointMake(subView.xys_centerX,subView.xys_centerY +600 )];
        animation.beginTime = CACurrentMediaTime() +i*0.1;
        [subView pop_addAnimation:animation forKey:nil];
        
        if (i == self.subviews.count - 1) {
            [animation setCompletionBlock:^(POPAnimation *anima, BOOL finished) {
                window_ = Nil;
            }];
        }
    }
    
    
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self back];
}
@end