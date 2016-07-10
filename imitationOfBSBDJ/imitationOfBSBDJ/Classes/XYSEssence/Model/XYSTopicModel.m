//
//  XYSTopicModel.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/8.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSTopicModel.h"
#import <MJExtension.h>
@interface XYSTopicModel()
{
    CGFloat _topicCellHeight;
    CGRect _pictureViewFrame;
}

@end
@implementation XYSTopicModel

+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2"
             };
}

-(CGFloat)topicCellHeight
{
    if (!_topicCellHeight) {
        
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4*XYSTopicCellMargin, MAXFLOAT);
        
        //attributes
        NSMutableDictionary *attr = [NSMutableDictionary dictionary];
        attr[NSFontAttributeName] = [UIFont systemFontOfSize:14.0];
        
       CGFloat textHeight = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.height;
        _topicCellHeight = XYSTopicCellTextY + XYSTopicCellMargin + textHeight +2* XYSTopicCellMargin + XYSTopicCellBottomBarH;
        
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
        }
    
    }
    return _topicCellHeight;
}
@end
