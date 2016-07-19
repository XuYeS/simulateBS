//
//  XYSRollBackWindow.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/19.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSRollBackWindow.h"

@implementation XYSRollBackWindow
static UIWindow *rollBackWindow_;
+(void)initialize
{
    rollBackWindow_ = [[UIWindow alloc]init];
    rollBackWindow_.backgroundColor = [UIColor clearColor];
    rollBackWindow_.frame = CGRectMake(0, 0, screenWidth, 20);
    rollBackWindow_.windowLevel = UIWindowLevelAlert;
    [rollBackWindow_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
}

+(void)windowClick
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:keyWindow];

}

+ (void)searchScrollViewInView:(UIView *)superview
{
    for (UIScrollView *subview in superview.subviews) {
        
        // 如果是scrollview, 滚动最顶部
        if ([subview isKindOfClass:[UIScrollView class]] && subview.isOnCurrentScreen) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        
        // 继续查找子控件
        [self searchScrollViewInView:subview];
    }
}

+(void)show
{
    rollBackWindow_.hidden = NO;
}


+(void)hide
{
    rollBackWindow_.hidden = YES;
}
@end
