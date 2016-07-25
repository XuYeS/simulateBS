//
//  XYSAddTagController.h
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/23.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYSAddTagController : UIViewController

/** 完成后数据传递的block */
@property (nonatomic,copy)void (^sendTagBlock) (NSArray *tagsArray);

/**传入的标签 */
@property (nonatomic,strong)NSMutableArray *inputTags ;
@end
