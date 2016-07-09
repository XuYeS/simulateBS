//
//  XYSTopicController.h
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/6.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    XYSTopicTypeAll = 1,
    XYSTopicTypePicture = 10,
    XYSTopicTypeJoke = 29,
    XYSTopicTypeVoice = 31,
    XYSTopicTypeVideo = 41
    
}XYSTopicType;
@interface XYSTopicController : UITableViewController
/**topic类别*/
@property (assign,nonatomic)NSInteger type;
@end
