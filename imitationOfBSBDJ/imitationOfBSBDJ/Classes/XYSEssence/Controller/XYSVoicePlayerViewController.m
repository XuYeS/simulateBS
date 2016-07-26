//
//  XYSVoicePlayerViewController.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/25.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSVoicePlayerViewController.h"
#import "XYSTopicModel.h"
#import "XYSCircularProgressView.h"
#import <KRVideoPlayerController.h>
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
@interface XYSVoicePlayerViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
/** 显示的图片*/
@property (weak,nonatomic)UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet XYSCircularProgressView *progressView;
@property (strong,nonatomic)KRVideoPlayerController *voicePlayer;
@end

@implementation XYSVoicePlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SVProgressHUD.minimumDismissTimeInterval = 1.0;
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    [self.progressView setProgress:self.topicModel.progressPerc animated:YES];
    //显示图片
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topicModel.large_image]placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        self.progressView.roundedCorners = 2.0;
        self.topicModel.progressPerc =1.0 *receivedSize/expectedSize;
        
        [self.progressView setProgress:self.topicModel.progressPerc animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    [self.contentScrollView addSubview:imageView];
    self.pictureView = imageView;
    
    
    CGFloat pictureW = screenW;
    CGFloat pictureH = self.topicModel.height*pictureW/self.topicModel.width;
    
    self.pictureView.frame = CGRectMake(0, 0, pictureW, pictureH);
    //图片大于屏幕
    if (pictureH > screenH) {
        self.contentScrollView.contentSize = CGSizeMake(0, pictureH);
        self.contentScrollView.minimumZoomScale = 1;
        self.contentScrollView.maximumZoomScale = self.topicModel.width/pictureW;
    }else//小于屏幕，居中
    {
        self.pictureView.xys_centerY = screenH*0.5;
    }
    
    self.voicePlayer = [[KRVideoPlayerController alloc]initWithFrame:self.pictureView.frame];
    //修改voicePlayer的背景为透明。
    [self.voicePlayer.view setValue:[UIColor clearColor] forKeyPath:@"backgroundColor"];
    
    self.voicePlayer.contentURL = [NSURL URLWithString:self.topicModel.voiceuri];
    __weak __typeof (self) weakSelf = self;
    [self.voicePlayer setDimissCompleteBlock:^{
        [weakSelf back];
    }];
    [self.voicePlayer showInWindow];


}

- (IBAction)back {
    [self.voicePlayer stop];
    [self.voicePlayer dismiss];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
