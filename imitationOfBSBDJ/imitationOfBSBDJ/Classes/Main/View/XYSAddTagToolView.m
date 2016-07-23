//
//  XYSAddTagToolView.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/23.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSAddTagToolView.h"
#import "XYSAddTagController.h"
@interface XYSAddTagToolView()
@property (weak, nonatomic) IBOutlet UIView *topView;

@end
@implementation XYSAddTagToolView

+(instancetype)tagTool
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}

-(void)awakeFromNib
{
    UIButton *addTagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addTagBtn setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    addTagBtn.xys_size = addTagBtn.currentImage.size;
    [addTagBtn addTarget:self action:@selector(addTag) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:addTagBtn];
}

-(void)addTag
{
    //a modal 出来的控制器b  a.presentedViewController = b  b.presentingViewController = a;
    UINavigationController *nc = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController.presentedViewController;
    
    XYSAddTagController *atc = [[XYSAddTagController alloc]init];
    
    [nc pushViewController:atc animated:YES];
    
}
@end
