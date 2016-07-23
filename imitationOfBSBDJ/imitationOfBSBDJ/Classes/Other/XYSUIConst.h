//
//  XYSUIConst.h
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/10.
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
/** 精华-顶部标题的高度 */
UIKIT_EXTERN CGFloat const XYSTitilesViewH ;
/** 精华-顶部标题的Y */
UIKIT_EXTERN CGFloat const XYSTitilesViewY ;

/** 精华-cell-间距 */
UIKIT_EXTERN CGFloat const XYSTopicCellMargin ;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const XYSTopicCellTextY ;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const XYSTopicCellBottomBarH ;

/**最大图片长度*/
UIKIT_EXTERN CGFloat const XYSMaxPictureHeight ;
/**超过最大图片长度后显示的长度*/
UIKIT_EXTERN CGFloat const XYSClipPictureHeight ;

/** XMGUser模型-性别属性值 */
UIKIT_EXTERN NSString * const XYSUserSexMale;
UIKIT_EXTERN NSString * const XYSUserSexFemale ;
/**tabbar 点击通知 */
UIKIT_EXTERN NSString * const XYSTabBarDidSelectNotification;

/** 发表-标签-间距 */
UIKIT_EXTERN CGFloat const XYSTagMargin ;