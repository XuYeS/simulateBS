//
//  XYSLeftRecommendModel.h
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/6/30.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYSLeftRecommendModel : NSObject
@property (assign,nonatomic) NSInteger ID;
@property (strong,nonatomic) NSString * name;
@property (assign,nonatomic) NSInteger Count;


/**右侧拥有多少个推荐人 */
@property (nonatomic,strong)NSMutableArray* listOfRecommendUser ;

/**总页数 */
@property (nonatomic,assign)NSInteger total_page ;
/**当前页 */
@property (nonatomic,assign)NSInteger current_page ;
/**总推荐用户数 */
@property (nonatomic,assign)NSInteger totalRecommendUser ;
@end
