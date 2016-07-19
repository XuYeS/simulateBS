//
//  XYSTopicCell.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/8.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSTopicCell.h"
#import "XYSTopicPictureView.h"
#import "XYSTopicVoiceView.h"
#import "XYSTopicVideoView.h"
#import "XYSTopCommentModel.h"
#import "XYSUser.h"
#import <UIImageView+WebCache.h>
@interface XYSTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commenButton;
@property (weak, nonatomic) IBOutlet UILabel *topicTextLabel;
@property (weak, nonatomic) IBOutlet UIView *topCommentView;
@property (weak, nonatomic) IBOutlet UILabel *topCommentTextLabel;


/**图片帖子中间的内容*/
@property (strong,nonatomic) XYSTopicPictureView *pictureView;
/**声音帖子中间的内容*/
@property (strong,nonatomic) XYSTopicVoiceView *voiceView;
/**视频帖子中间的内容*/
@property (strong,nonatomic) XYSTopicVideoView *videoView;
@end
@implementation XYSTopicCell
+(instancetype)cell{
    
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
    
}
- (XYSTopicPictureView *)pictureView
{
    if (!_pictureView) {
        XYSTopicPictureView *pictureView = [XYSTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (XYSTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        XYSTopicVoiceView *voiceView = [XYSTopicVoiceView voiceView];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (XYSTopicVideoView *)videoView
{
    if (!_videoView) {
        XYSTopicVideoView *videoView = [XYSTopicVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImageView *backgroundView = [[UIImageView alloc]init];
    backgroundView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = backgroundView;
}
-(void)setFrame:(CGRect)frame
{
//    frame.origin.x = XYSTopicCellMargin;
//    frame.size.width -=2*frame.origin.x ;
    frame.size.height = self.topicModel.topicCellHeight - XYSTopicCellMargin;
    frame.origin.y += XYSTopicCellMargin;
    [super setFrame:frame];
}
-(void)setTopicModel:(XYSTopicModel *)topicModel
{
    _topicModel = topicModel;
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:topicModel.profile_image]];
    self.nameLabel.text= topicModel.name;
    self.creatTimeLabel.text = topicModel.create_time;
    self.topicTextLabel.text = topicModel.text;
    //底部4个按钮
    [self setupButtonTitle:self.dingButton count:topicModel.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topicModel.cai placeholder:@"踩"];
    [self setupButtonTitle:self.repostButton count:topicModel.repost placeholder:@"转发"];
    [self setupButtonTitle:self.commenButton count:topicModel.comment placeholder:@"评论"];
    
    if (self.topicModel.type == XYSTopicTypePicture) {//图片
        //防止全部中循环利用
        self.pictureView.hidden = NO;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        
        self.pictureView.topicModel = topicModel;
        self.pictureView.frame = topicModel.pictureViewFrame;
    }else if (self.topicModel.type == XYSTopicTypeVoice){//声音
        //防止全部中循环利用
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = NO;
        
        self.voiceView.topicModel = topicModel;
        self.voiceView.frame = topicModel.voiceViewFrame;
        
    }else if(self.topicModel.type == XYSTopicTypeVideo){//视频
        //防止全部中循环利用
        self.pictureView.hidden = YES;
        self.videoView.hidden = NO;
        self.voiceView.hidden = YES;

        self.videoView.topicModel = topicModel;
        self.videoView.frame = topicModel.videoViewFrame;
       // XYSLog(@"%@",NSStringFromCGRect(self.videoView.frame));
    }else if (self.topicModel.type == XYSTopicTypeJoke){//段子
        //防止全部中循环利用
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
        self.voiceView.hidden = YES;
        
    }
    
    XYSTopCommentModel *commentModel = [self.topicModel.top_cmt firstObject];

    if (commentModel) {
        self.topCommentView.hidden = NO;
        self.topCommentTextLabel.text = [NSString stringWithFormat:@"%@: %@",commentModel.user.username,commentModel.content];
    }else{
        self.topCommentView.hidden = YES;

    }
    
    
    
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
- (IBAction)pushComment:(id)sender {
    
    if (self.commentTap) {
        self.commentTap();
    }
}

@end
