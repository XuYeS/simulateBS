//
//  XYSTextField.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/3.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSTextField.h"
#import <objc/runtime.h>
@implementation XYSTextField
static NSString * const XYSPlacerholderColorKeyPath = @"_placeholderLabel.textColor";

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib
{
    self.tintColor = self.textColor;
    [self resignFirstResponder];
}
-(BOOL)becomeFirstResponder
{
    [self setValue:self.textColor forKeyPath:XYSPlacerholderColorKeyPath];

    return [super becomeFirstResponder];
}
-(BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:XYSPlacerholderColorKeyPath];

    return [super resignFirstResponder];
}

@end
