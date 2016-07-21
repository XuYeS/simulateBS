//
//  XYSPostViewController.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/21.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSPostViewController.h"
#import "XYSPlaceholderTextView.h"

@interface XYSPostViewController ()
@property (nonatomic,weak) XYSPlaceholderTextView *placeholderView;
@end

@implementation XYSPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigation];
    [self setupPalceholderTextView];

}
-(void)setupNavigation
{
    self.title = @"发段子";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(back)];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [self.navigationController.navigationBar layoutIfNeeded];
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changePostButton) name:UITextViewTextDidChangeNotification object:nil];
}

-(void)setupPalceholderTextView
{
    XYSPlaceholderTextView *ptv = [[XYSPlaceholderTextView alloc]initWithFrame:self.view.bounds];
    ptv.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    ptv.placeholderColor = [UIColor grayColor];
    self.placeholderView = ptv;
    

    
    [self.view addSubview:self.placeholderView];
    
}
-(void)changePostButton
{
    self.navigationItem.rightBarButtonItem.enabled = self.placeholderView.hasText;
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)post
{
    XYSLogFuc;
}

@end
