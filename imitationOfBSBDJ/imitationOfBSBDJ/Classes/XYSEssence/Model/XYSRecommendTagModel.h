//
//  XYSRecommendTagModel.h
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/3.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYSRecommendTagModel : NSObject

/**头像图片 */
@property (nonatomic,strong)NSString* image_list ;
/**theme_name */
@property (nonatomic,strong)NSString* theme_name ;
/**关注人数 */
@property (nonatomic,copy)NSString* sub_number ;
@end
