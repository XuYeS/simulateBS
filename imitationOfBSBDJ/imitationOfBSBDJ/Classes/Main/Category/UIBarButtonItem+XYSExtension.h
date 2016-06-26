//
//  UIBarButtonItem+XYSExtension.h
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/6/26.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XYSExtension)
+(instancetype)itemWithImage:(NSString*)image selectedImage:(NSString*)selectedImage target:(id)target action:(SEL)action;
@end
