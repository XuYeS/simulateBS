//
//  XYSTopicCell.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/8.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSTopicCell.h"
#import <UIImageView+WebCache.h>
@interface XYSTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commenButton;

@end
@implementation XYSTopicCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImageView *backgroundView = [[UIImageView alloc]init];
    backgroundView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = backgroundView;
}
-(void)setFrame:(CGRect)frame
{
    frame.origin.x = 10;
    frame.size.width -=2*frame.origin.x ;
    frame.size.height -= 2*5;
    [super setFrame:frame];
}
-(void)setTopicModel:(XYSTopicModel *)topicModel
{
    _topicModel = topicModel;
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:topicModel.profile_image]];
    self.nameLabel.text= topicModel.name;
    self.creatTimeLabel.text = topicModel.create_time;
//    self.dingButton.titleLabel.text = [NSString stringWithFormat:@"%zd",topicModel.ding];
//    self.caiButton.titleLabel.text = [NSString stringWithFormat:@"%zd",topicModel.cai];
//    self.repostButton.titleLabel.text = [NSString stringWithFormat:@"%zd",topicModel.repost];
//    self.commenButton.titleLabel.text = [NSString stringWithFormat:@"%zd",topicModel.comment];
    [self setupButtonTitle:self.dingButton count:topicModel.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topicModel.cai placeholder:@"踩"];
    [self setupButtonTitle:self.repostButton count:topicModel.repost placeholder:@"转发"];
    [self setupButtonTitle:self.commenButton count:topicModel.comment placeholder:@"评论"];
}
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{

    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

@end
