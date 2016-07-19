//
//  XYSTopicModel.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/8.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSTopicModel.h"
#import "XYSTopCommentModel.h"
#import "XYSUser.h"
#import <MJExtension.h>
@interface XYSTopicModel()
{
    CGFloat _topicCellHeight;
}

@end
@implementation XYSTopicModel

+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"ID":@"id",
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2"
             };
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"top_cmt" : @"XYSTopCommentModel"};
}

-(CGFloat)topicCellHeight
{
    if (!_topicCellHeight) {
        
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 2*XYSTopicCellMargin, MAXFLOAT);
        
        //attributes
        NSMutableDictionary *attr = [NSMutableDictionary dictionary];
        attr[NSFontAttributeName] = [UIFont systemFontOfSize:14.0];
        
       CGFloat textHeight = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.height;
        _topicCellHeight = XYSTopicCellTextY + XYSTopicCellMargin + textHeight +2* XYSTopicCellMargin + XYSTopicCellBottomBarH;
        
        //中间内容高度
        if (self.type == XYSTopicTypePicture) {
            CGFloat pictureWidth = maxSize.width;
            CGFloat pictureHeight = self.height *pictureWidth/self.width;
            
            if (pictureHeight >= XYSMaxPictureHeight) {//图片过大
                pictureHeight = XYSClipPictureHeight;
                self.BigPicture = YES;
            }
            
            CGFloat pictureX = XYSTopicCellMargin;
            CGFloat pictureY = XYSTopicCellTextY + textHeight + XYSTopicCellMargin;
            _pictureViewFrame = CGRectMake(pictureX, pictureY, pictureWidth, pictureHeight);
            _topicCellHeight += pictureHeight + XYSTopicCellMargin;
        }else if (self.type == XYSTopicTypeVoice){
            CGFloat voiceX = XYSTopicCellMargin ;
            CGFloat voiceY = XYSTopicCellTextY + textHeight + XYSTopicCellMargin ;
            CGFloat voiceWidth = maxSize.width;
            CGFloat voiceHeight = self.height*voiceWidth/self.width;
            _voiceViewFrame = CGRectMake(voiceX, voiceY, voiceWidth, voiceHeight);
            _topicCellHeight += voiceHeight + XYSTopicCellMargin;
        }else if (self.type == XYSTopicTypeVideo){
            CGFloat videoX = XYSTopicCellMargin ;
            CGFloat videoY = XYSTopicCellTextY + textHeight + XYSTopicCellMargin ;
            CGFloat videoWidth = maxSize.width;
            CGFloat videoHeight = self.height*videoWidth/self.width;
            _videoViewFrame = CGRectMake(videoX, videoY, videoWidth, videoHeight);
            _topicCellHeight += videoHeight + XYSTopicCellMargin;
        }
        
        //最热评论高度
        XYSTopCommentModel *commentModel = [self.top_cmt firstObject];
        if (commentModel) {
            NSString *content = [NSString stringWithFormat:@"%@: %@",commentModel.user.username,commentModel.content];
            _topicCellHeight+=2*XYSTopicCellMargin+[content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
        }
    
    }
    return _topicCellHeight;
}
@end
