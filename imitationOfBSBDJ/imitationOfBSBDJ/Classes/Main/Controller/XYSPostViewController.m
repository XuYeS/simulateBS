//
//  XYSPostViewController.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/21.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSPostViewController.h"
#import "XYSPlaceholderTextView.h"
#import "XYSLoginRegisterController.h"
#import "XYSAddTagToolView.h"
@interface XYSPostViewController ()
@property (nonatomic,weak) XYSPlaceholderTextView *placeholderView;
@property (nonatomic,weak) XYSAddTagToolView *addTagTool;
@end

@implementation XYSPostViewController

#pragma mark -init
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigation];
    [self setupPalceholderTextView];
    [self setupAddTagToolView];

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.placeholderView becomeFirstResponder];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.placeholderView resignFirstResponder];
}
/**
 *  初始化导航控制器
 */
-(void)setupNavigation
{
    self.title = @"发段子";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(back)];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [self.navigationController.navigationBar layoutIfNeeded];
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changePostButton) name:UITextViewTextDidChangeNotification object:nil];
}
/**
 *  初始化占位文字
 */
-(void)setupPalceholderTextView
{
    XYSPlaceholderTextView *ptv = [[XYSPlaceholderTextView alloc]initWithFrame:self.view.bounds];
    ptv.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里，接受千万网友膜拜吧！发布违反国家法律内容的，我们将依法提交给有关部门处理。";
    ptv.placeholderColor = [UIColor grayColor];
    self.placeholderView = ptv;
    

    
    [self.view addSubview:self.placeholderView];
    
}
/**
 *  初始化添加标签工具
 */
-(void)setupAddTagToolView
{
    XYSAddTagToolView *addTagTool = [XYSAddTagToolView tagTool];
    addTagTool.xys_width = self.view.xys_width;
    addTagTool.xys_y = self.view.xys_height - addTagTool.xys_height ;
    [self.view addSubview:addTagTool];
    self.addTagTool = addTagTool;
    
    //监听键盘弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

/**
*  键盘弹出后处理函数
*
*  @param note 键盘弹出过程中的具体信息
*/
-(void) keyboardWillChangeFrame:(NSNotification *)note
{
    CGRect KeyboardEndFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 动画
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.addTagTool.transform = CGAffineTransformMakeTranslation(0,  KeyboardEndFrame.origin.y - screenHeight);

    }];
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
    XYSLoginRegisterController *loginRigister = [[XYSLoginRegisterController alloc]init];
    loginRigister.isLogin = YES;
    [self.navigationController presentViewController:loginRigister animated:YES completion:nil];
}

@end
