//
//  XYSTopicVoiceView.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/14.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSTopicVoiceView.h"
#import "XYSShowPictureController.h"
#import "XYSTopicModel.h"
#import "XYSPlayVoiceController.h"
#import <UIImageView+WebCache.h>
@interface XYSTopicVoiceView()
@property (weak, nonatomic) IBOutlet UILabel *seenNumlabel;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation XYSTopicVoiceView

+(instancetype)voiceView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    //添加点击手势
    [self.backgroundImageView setUserInteractionEnabled:YES];
    [self.backgroundImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showVoiceDetail)]];
    
}

-(void)setTopicModel:(XYSTopicModel *)topicModel
{
    _topicModel = topicModel;
    
    self.seenNumlabel.text = [NSString stringWithFormat:@"%zd次播放",topicModel.playfcount];
    NSInteger min = topicModel.voicetime / 60 ;
    NSInteger sec = topicModel.voicetime % 60 ;
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",min,sec];
    
    [self.backgroundImageView sd_setImageWithURL:[NSURL URLWithString:topicModel.large_image]];
}

-(void)showVoiceDetail
{
    XYSShowPictureController *spc = [[XYSShowPictureController alloc]init];
    spc.topicModel = self.topicModel;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:spc animated:YES completion:nil];

}
@end
