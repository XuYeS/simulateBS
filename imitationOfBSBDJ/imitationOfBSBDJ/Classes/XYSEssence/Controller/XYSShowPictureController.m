//
//  XYSShowPictureController.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/10.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSShowPictureController.h"
#import "XYSTopicModel.h"
#import "XYSCircularProgressView.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
@interface XYSShowPictureController ()
/** 背景scrollView*/
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;
/** 显示的图片*/
@property (nonatomic,weak)UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet XYSCircularProgressView *progressView;

@end

@implementation XYSShowPictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    //添加点击手势
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)]];
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

}
/**
 *  隐藏状态栏
 */
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)savePicture {
    if (self.pictureView == nil) {
        [SVProgressHUD showErrorWithStatus:@"没有下载完成"];
        return;
    }
    UIImageWriteToSavedPhotosAlbum(self.pictureView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }
    [UIView animateWithDuration:2 animations:^{
        [SVProgressHUD dismiss];
    }];

}

@end
