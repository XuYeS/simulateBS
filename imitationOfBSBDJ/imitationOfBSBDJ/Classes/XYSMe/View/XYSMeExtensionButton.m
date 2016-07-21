//
//  XYSMeExtensionButton.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/20.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSMeExtensionButton.h"
#import "XYSMeExtensionModel.h"
#import <UIButton+WebCache.h>
@implementation XYSMeExtensionButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];

    }
    return self;
}
-(void)awakeFromNib{
    [self setUp];
}


-(void)setUp
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];

}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整图片
    self.imageView.xys_y  = self.xys_height * 0.15;
    self.imageView.xys_width = self.xys_width * 0.5;
    self.imageView.xys_height = self.imageView.xys_width;
    self.imageView.xys_centerX = self.xys_width * 0.5;
    
    // 调整文字
    self.titleLabel.xys_x= 0;
    self.titleLabel.xys_y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.xys_width = self.xys_width;
    self.titleLabel.xys_height = self.xys_height - self.titleLabel.xys_y;
}

-(void)setMeExtensionModel:(XYSMeExtensionModel *)meExtensionModel
{
    _meExtensionModel = meExtensionModel;
    [self sd_setImageWithURL:[NSURL URLWithString:meExtensionModel.icon] forState:UIControlStateNormal];
    [self setTitle:meExtensionModel.name forState:UIControlStateNormal];
}
@end
