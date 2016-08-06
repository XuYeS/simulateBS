//
//  XYSTopicPictureView.h
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/10.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYSTopicModel;
@interface XYSTopicPictureView : UIView
/**模型 */
@property (nonatomic,strong)XYSTopicModel *topicModel ;


+(instancetype)pictureView;
@end
