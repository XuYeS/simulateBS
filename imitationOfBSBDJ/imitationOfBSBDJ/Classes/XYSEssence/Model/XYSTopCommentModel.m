//
//  XYSTopCommentModel.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/16.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSTopCommentModel.h"

@implementation XYSTopCommentModel
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{
             @"commentId":@"id",
             };
}
@end
