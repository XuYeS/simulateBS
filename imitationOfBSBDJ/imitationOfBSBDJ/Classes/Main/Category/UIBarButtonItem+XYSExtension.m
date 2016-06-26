//
//  UIBarButtonItem+XYSExtension.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/6/26.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "UIBarButtonItem+XYSExtension.h"

@implementation UIBarButtonItem (XYSExtension)
+(instancetype)itemWithImage:(NSString*)image selectedImage:(NSString*)selectedImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.xys_size = button.currentBackgroundImage.size;
    
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}
@end
