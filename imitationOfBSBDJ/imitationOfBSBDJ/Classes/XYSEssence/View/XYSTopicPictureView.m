//
//  XYSTopicPictureView.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/10.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSTopicPictureView.h"
#import <UIImageView+WebCache.h>
#import "XYSShowPictureController.h"
@interface  XYSTopicPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *pictureView;
@property (weak, nonatomic) IBOutlet UIImageView *gifFlagView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;

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
    
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:topicModel.large_image]];
    
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
