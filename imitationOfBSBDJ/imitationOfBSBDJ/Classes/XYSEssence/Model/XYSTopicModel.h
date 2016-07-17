//
//  XYSTopicModel.h
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/8.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYSTopicModel : NSObject
/**ID */
@property (nonatomic,copy)NSString *ID ;
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
/**最热评论 */
@property (nonatomic,strong)NSArray *top_cmt ;

//--------图片
/**图片视频声音的高度 */
@property (nonatomic,assign)CGFloat height;
/** 图片视频声音的宽度 */
@property (nonatomic,assign)CGFloat width;

//--------声音
/**声音时间 */
@property (nonatomic,assign)NSInteger voicetime ;
/**播放次数 */
@property (nonatomic,assign)NSInteger playfcount ;

//--------视频
/**视频时间 */
@property (nonatomic,assign)NSInteger videotime ;

//--------辅助属性
/**内容的高度 */
@property (nonatomic,assign,readonly)CGFloat topicCellHeight ;
/**图片的frame */
@property (nonatomic,assign,readonly)CGRect pictureViewFrame ;
/**是否是大图片 */
@property (nonatomic,assign,getter=isBigPicture)BOOL BigPicture ;
/**图片下载进度 */
@property (nonatomic,assign)CGFloat progressPerc ;


/**声音帖子的frame */
@property (nonatomic,assign,readonly)CGRect voiceViewFrame ;
/**视频帖子的frame */
@property (nonatomic,assign,readonly)CGRect videoViewFrame ;
@end
