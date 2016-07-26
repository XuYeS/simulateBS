//
//  XYSTopicVideoView.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/14.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSTopicVideoView.h"
#import "XYSTopicModel.h"
#import "XYSShowPictureController.h"
#import "XYSVideoPlayViewController.h"
#import <UIImageView+WebCache.h>
@interface XYSTopicVideoView()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *seenNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;

@end
@implementation XYSTopicVideoView

+(instancetype)videoView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    //添加点击手势
    [self.backgroundImageView setUserInteractionEnabled:YES];
    [self.backgroundImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showVideoDetail)]];
    
}
-(void)setTopicModel:(XYSTopicModel *)topicModel
{
    _topicModel = topicModel;
    
    self.seenNumLabel.text = [NSString stringWithFormat:@"%zd次播放",topicModel.playfcount];
    NSInteger min = topicModel.videotime / 60 ;
    NSInteger sec = topicModel.videotime % 60 ;
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",min,sec];
    
    [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:topicModel.large_image]];
}
-(void)showVideoDetail
{
//    XYSShowPictureController *spc = [[XYSShowPictureController alloc]init];
//    spc.topicModel = self.topicModel;
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:spc animated:YES completion:nil];
    XYSVideoPlayViewController *vpc = [[XYSVideoPlayViewController alloc]init];
    vpc.topicModel = self.topicModel;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vpc animated:YES completion:nil];

}
@end
