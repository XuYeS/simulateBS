//
//  XYSTopicPictureView.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/10.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSTopicPictureView.h"
#import <UIImageView+WebCache.h>
#import "XYSCircularProgressView.h"
#import "XYSShowPictureController.h"
@interface  XYSTopicPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UIImageView *gifFlagView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@property (weak, nonatomic) IBOutlet XYSCircularProgressView *progressView;

@end
@implementation XYSTopicPictureView
+(instancetype)pictureView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    //添加点击手势
    [self.pictureView setUserInteractionEnabled:YES];
    [self.pictureView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPictureDetail)]];
    
}

-(void)setTopicModel:(XYSTopicModel *)topicModel
{
    _topicModel = topicModel;
    
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:self.topicModel.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        self.progressView.hidden = NO;
        self.progressView.roundedCorners = 2.0;
        self.topicModel.progressPerc = 1.0 * receivedSize/expectedSize;        
        [self.progressView setProgress:self.topicModel.progressPerc animated:NO];
        
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.progressView.hidden = YES;
        
        if (self.topicModel.isBigPicture == YES)
        {
            // 开启图形上下文
            UIGraphicsBeginImageContextWithOptions(self.topicModel.pictureViewFrame.size, YES, 0.0);
            
            // 将下载完的image对象绘制到图形上下文
            CGFloat width = self.topicModel.pictureViewFrame.size.width;
            CGFloat height = width * image.size.height / image.size.width;
            [image drawInRect:CGRectMake(0, 0, width, height)];
            
            // 获得图片
            self.pictureView.image = UIGraphicsGetImageFromCurrentImageContext();
            
            // 结束图形上下文
            UIGraphicsEndImageContext();
        }
    }];
    
    
    
    NSString *pathExtension = topicModel.large_image.pathExtension;
    
    self.gifFlagView.hidden = ![pathExtension.lowercaseString isEqualToString:@"gif"];
    if (topicModel.isBigPicture) {
        self.seeBigButton.hidden = NO;
        self.pictureView.contentMode = UIViewContentModeScaleAspectFill;

    }else
    {
        self.seeBigButton.hidden = YES;
        self.pictureView.contentMode = UIViewContentModeScaleAspectFill;

    }
}


-(void)showPictureDetail
{
    XYSShowPictureController *spc = [[XYSShowPictureController alloc]init];
    spc.topicModel = self.topicModel;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:spc animated:YES completion:nil];
}
@end
