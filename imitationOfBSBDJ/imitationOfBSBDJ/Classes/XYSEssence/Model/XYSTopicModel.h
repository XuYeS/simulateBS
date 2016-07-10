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
/** 小图片的URL */
@property (nonatomic, copy) NSString *small_image;
/** 中图片的URL */
@property (nonatomic, copy) NSString *middle_image;
/** 大图片的URL */
@property (nonatomic, copy) NSString *large_image;
/** 帖子的类型 */
@property (nonatomic, assign) XYSTopicType type;
/**图片视频声音的高度 */
@property (nonatomic,assign)CGFloat height;
/** 图片视频声音的宽度 */
@property (nonatomic,assign)CGFloat width;

//辅助属性
/**内容的高度 */
@property (nonatomic,assign,readonly)CGFloat topicCellHeight ;
/**图片的frame */
@property (nonatomic,assign,readonly)CGRect pictureViewFrame ;
/**是否是大图片 */
@property (nonatomic,assign,getter=isBigPicture)BOOL BigPicture ;
@end
