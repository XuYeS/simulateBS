//
//  XYSTopCommentModel.h
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/16.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XYSUser;
@interface XYSTopCommentModel : NSObject
/** 评论ID */
@property (nonatomic,copy)NSString *commentId;
/**喜欢次数 */
@property (nonatomic,assign)NSInteger like_count ;
/** 音频文件的时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 评论的文字内容 */
@property (nonatomic, copy) NSString *content;
/** 用户 */
@property (nonatomic, strong) XYSUser *user;

/** 声音评论 */
@property (nonatomic,copy)NSString *voiceuri;
@end
