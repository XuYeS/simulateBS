//
//  XYSTopicCell.h
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/8.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYSTopicModel;
@interface XYSTopicCell : UITableViewCell

/**topic模型 */
@property (nonatomic,strong)XYSTopicModel *topicModel ;
/** 点击block */
@property (nonatomic,copy)void (^commentTap)(void) ;

+(instancetype)cell;


@end
