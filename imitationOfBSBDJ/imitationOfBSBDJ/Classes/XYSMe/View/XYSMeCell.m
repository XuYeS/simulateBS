//
//  XYSMeCell.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/20.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSMeCell.h"

@implementation XYSMeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIImageView *bgView = [[UIImageView alloc] init];
        bgView.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = bgView;
        
        self.textLabel.textColor = [UIColor grayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];

    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.imageView.image == nil) return;
    
    self.imageView.xys_width = 30;
    self.imageView.xys_height = self.imageView.xys_width;
    self.imageView.xys_centerY = self.contentView.xys_height * 0.5;
    
    self.textLabel.xys_x = CGRectGetMaxX(self.imageView.frame) + XYSTopicCellMargin;
}

@end
