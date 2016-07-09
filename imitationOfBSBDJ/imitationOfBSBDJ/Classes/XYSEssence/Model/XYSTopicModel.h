//
//  XYSTopicModel.h
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/8.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYSTopicModel : NSObject
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;
@end
