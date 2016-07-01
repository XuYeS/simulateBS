//
//  XYSRightRecommendUserCell.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/6/30.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSRightRecommendUserCell.h"
#import "XYSRightRecommendUserModel.h"
#import <UIImageView+WebCache.h>
@interface XYSRightRecommendUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansNumLabel;




@end

@implementation XYSRightRecommendUserCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setRightRecommendUserModel:(XYSRightRecommendUserModel *)rightRecommendUserModel
{
    _rightRecommendUserModel = rightRecommendUserModel;
    self.screenNameLabel.text = rightRecommendUserModel.screen_name;
    self.fansNumLabel.text = [NSString stringWithFormat:@"%zd人关注",rightRecommendUserModel.fans_count];
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:rightRecommendUserModel.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

@end
