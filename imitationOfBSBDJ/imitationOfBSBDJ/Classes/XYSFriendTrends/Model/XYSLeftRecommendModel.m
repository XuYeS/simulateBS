//
//  XYSLeftRecommendModel.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/6/30.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSLeftRecommendModel.h"

@implementation XYSLeftRecommendModel
//MJExtension 中模型中的属性名和字典中的key不相同使用该方法进行调换！
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id",
             @"Count" : @"count",
             };
}
@end
