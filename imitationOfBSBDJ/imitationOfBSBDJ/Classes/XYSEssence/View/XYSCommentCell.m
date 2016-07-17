//
//  XYSCommentCell.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/17.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSCommentCell.h"
#import "XYSTopCommentModel.h"
#import "XYSUser.h"
#import <UIImageView+WebCache.h>
@interface XYSCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *hearImageView;
@property (weak, nonatomic) IBOutlet UIImageView *sexImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeNumLabel;


@end
@implementation XYSCommentCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setCommentModel:(XYSTopCommentModel *)commentModel
{
    _commentModel = commentModel;
    [self.hearImageView sd_setImageWithURL:[NSURL URLWithString:commentModel.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.sexImageView.image= [commentModel.user.sex isEqualToString:XYSUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"]:[UIImage imageNamed:@"Profile_womanIcon"];
    
    self.nameLabel.text = commentModel.user.username;
    
    self.commentLabel.text = commentModel.content;
    
    self.likeNumLabel.text = [NSString stringWithFormat:@"%zd",commentModel.like_count];
    
}
@end
