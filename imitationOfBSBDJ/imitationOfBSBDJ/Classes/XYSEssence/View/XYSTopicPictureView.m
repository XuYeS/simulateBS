//
//  XYSTopicPictureView.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/10.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSTopicPictureView.h"
#import <UIImageView+WebCache.h>
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
    self.pictureView.contentMode = UIViewContentModeScaleAspectFill;
}

-(void)setTopicModel:(XYSTopicModel *)topicModel
{
    [self.pictureView sd_setImageWithURL:[NSURL URLWithString:topicModel.large_image]];
    
    NSString *pathExtension = topicModel.large_image.pathExtension;
    
    self.gifFlagView.hidden = ![pathExtension.lowercaseString isEqualToString:@"gif"];
    if (topicModel.isBigPicture) {
        self.seeBigButton.hidden = NO;
    }else
    {
        self.seeBigButton.hidden = YES;
    }
}
@end
