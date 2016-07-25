//
//  XYSTagTextField.h
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/24.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYSTagTextField : UITextField

/** 删除操作 */
@property (nonatomic,copy)void(^deleteBlock)(void);
@end
