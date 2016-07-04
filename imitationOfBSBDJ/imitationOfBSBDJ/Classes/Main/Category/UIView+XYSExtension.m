//
//  UIView+XYSExtension.m
//  simulateBS
//
//  Created by 徐烨晟 on 16/6/26.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "UIView+XYSExtension.h"

@implementation UIView (XYSExtension)
-(void)setXys_x:(CGFloat)xys_x
{
    CGRect frame = self.frame;
    frame.origin.x = xys_x;
    self.frame = frame;
}
-(CGFloat)xys_x
{
    return self.frame.origin.x;
}

-(void)setXys_y:(CGFloat)xys_y
{
    CGRect frame = self.frame;
    frame.origin.y = xys_y;
    self.frame = frame;
}
-(CGFloat)xys_y
{
    return self.frame.origin.y;
}

-(void)setXys_size:(CGSize)xys_size
{
    CGRect frame = self.frame;
    frame.size.width = xys_size.width;
    frame.size.height = xys_size.height;
    self.frame = frame;
}
-(CGSize)xys_size
{
    return self.frame.size;
}

-(void)setXys_height:(CGFloat)xys_height
{
    CGRect frame = self.frame;
    frame.size.height = xys_height;
    self.frame = frame;
}
-(CGFloat)xys_height
{
    return self.frame.size.height;
}

-(void)setXys_width:(CGFloat)xys_width
{
    CGRect frame = self.frame;
    frame.size.width= xys_width;
    self.frame = frame;
}
-(CGFloat)xys_width
{
    return self.frame.size.width;
}
-(void)setXys_centerX:(CGFloat)xys_centerX
{
    CGPoint center = self.center;
    center.x = xys_centerX;
    self.center = center;
}
-(void)setXys_centerY:(CGFloat)xys_centerY
{
    CGPoint center = self.center;
    center.y = xys_centerY;
    self.center = center;
}
-(CGFloat)xys_centerX
{
    return self.center.x;
}
-(CGFloat)xys_centerY
{
    return self.center.y;
}
@end
