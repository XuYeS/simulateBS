//
//  XYSRecommedTagCell.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/3.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//
#import <UIImageView+WebCache.h>
#import "XYSRecommendTagCell.h"
#import "XYSRecommendTagModel.h"
@interface XYSRecommendTagCell()
@property (weak, nonatomic) IBOutlet UIImageView *image_list;
@property (weak, nonatomic) IBOutlet UILabel *theme_name;
@property (weak, nonatomic) IBOutlet UILabel *sub_number;


@end
@implementation XYSRecommendTagCell

- (void)awakeFromNib {
    // Initialization code
    
}
/**
 *  为了让cell缩小点
 *
 */
-(void)setFrame:(CGRect)frame
{
    frame.origin.x = 6;
    frame.size.width -=2*frame.origin.x ;
    
    [super setFrame:frame];
}
-(void)setRecommendTagModel:(XYSRecommendTagModel *)recommendTagModel
{
    _recommendTagModel = recommendTagModel;
    [self.image_list sd_setImageWithURL:[NSURL URLWithString:recommendTagModel.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.theme_name.text = recommendTagModel.theme_name;
    if ([recommendTagModel.sub_number integerValue]>10000) {
        self.sub_number.text = [NSString stringWithFormat:@"%.1f万人订阅",[recommendTagModel.sub_number integerValue]/10000.0];
    }else{
        self.sub_number.text = [NSString stringWithFormat:@"%zd",[recommendTagModel.sub_number integerValue]];
    }
    
}

@end
