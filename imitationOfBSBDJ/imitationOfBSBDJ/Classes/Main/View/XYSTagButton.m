//
//  XYSTagButton.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/24.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSTagButton.h"

@implementation XYSTagButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:XYSTagColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 5;
        
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        

    }
    return self;
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    [self sizeToFit];
    
    self.xys_width += 3*XYSTagMargin;
    self.xys_height += 2*XYSTagMargin;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.xys_x = XYSTagMargin;
    
    self.imageView.xys_x = CGRectGetMaxX(self.titleLabel.frame)+XYSTagMargin;
}
@end
