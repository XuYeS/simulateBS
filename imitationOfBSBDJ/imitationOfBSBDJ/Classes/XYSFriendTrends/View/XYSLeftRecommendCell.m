//
//  XYSLeftRecommendCell.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/6/30.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSLeftRecommendCell.h"
#import "XYSLeftRecommendModel.h"
@interface XYSLeftRecommendCell()
@property (weak, nonatomic) IBOutlet UIView *selectedMarker;

@end

@implementation XYSLeftRecommendCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
    self.textLabel.textColor = XYSRGB(78, 78, 78);
}
-(void)setLeftRecommendModel:(XYSLeftRecommendModel *)leftRecommendModel
{
    _leftRecommendModel = leftRecommendModel;
    self.textLabel.text = self.leftRecommendModel.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    self.selectedMarker.hidden = !selected;
    if(selected)
    {
        self.textLabel.textColor = [UIColor redColor];
        self.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        self.textLabel.textColor = XYSRGB(78, 78, 78);
        self.backgroundColor = [UIColor clearColor];
    }
}

@end
