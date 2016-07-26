//
//  XYSVideoPlayViewController.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/25.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSVideoPlayViewController.h"
#import "XYSTopicModel.h"
#import <KRVideoPlayerController.h>
@interface XYSVideoPlayViewController ()
/**放视频的界面*/
@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (strong,nonatomic)KRVideoPlayerController *videoPlayer;
@end

@implementation XYSVideoPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.videoPlayer = [[KRVideoPlayerController alloc]initWithFrame:self.videoView.frame];
    [self.videoView addSubview:self.videoPlayer.view];
    __weak __typeof (self) weakSelf = self;
    [self.videoPlayer setDimissCompleteBlock:^{
        [weakSelf back];
    }];

    self.videoPlayer.contentURL = [NSURL URLWithString:self.topicModel.videouri];
    [self.videoPlayer showInWindow];
}


- (IBAction)back {
    [self.videoPlayer stop];
    [self.videoPlayer dismiss];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

/**
 *  隐藏状态栏
 */
-(BOOL)prefersStatusBarHidden
{
    return YES;
}


@end
