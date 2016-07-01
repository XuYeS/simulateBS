//
//  XYSRightRecommendUserModel.h
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/6/30.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYSRightRecommendUserModel : NSObject
/**用户名 */
@property (nonatomic,strong)NSString* screen_name ;
/**fans */
@property (nonatomic,assign)NSInteger fans_count ;
/**头像 */
@property (nonatomic,strong)NSString* header ;
@end
