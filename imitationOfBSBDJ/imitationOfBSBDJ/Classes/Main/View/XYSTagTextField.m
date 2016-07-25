//
//  XYSTagTextField.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/24.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSTagTextField.h"

@implementation XYSTagTextField

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.xys_width = screenWidth;
        self.xys_height = 25;
        self.placeholder = @"多个标签用逗号或者换行隔开";
        self.font = [UIFont systemFontOfSize:15];
    }
    return self;
}

-(void)deleteBackward
{
    if (!self.hasText) {
        !self.deleteBlock ? : self.deleteBlock() ;
    }
    [super deleteBackward];
}

@end
