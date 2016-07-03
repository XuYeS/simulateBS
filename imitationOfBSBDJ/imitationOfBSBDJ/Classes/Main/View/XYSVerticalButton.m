//
//  XYSVerticalButton.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/3.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSVerticalButton.h"

@implementation XYSVerticalButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)layoutSubviews
{
   [super layoutSubviews];
    CGRect frame ;
    CGPoint center = CGPointZero;
    center.x = self.imageView.center.x;
    center.y = self.imageView.center.y + self.imageView.xys_height*0.5+20;
    frame.size = self.titleLabel.intrinsicContentSize;

    [self.titleLabel setFrame:frame];
    [self.titleLabel setCenter:center];
    
}

@end
