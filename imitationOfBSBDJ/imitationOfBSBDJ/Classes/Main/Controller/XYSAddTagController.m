//
//  XYSAddTagController.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/23.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSAddTagController.h"
#import "XYSTagTextField.h"
#import "XYSTagButton.h"
#import <SVProgressHUD.h>
@interface XYSAddTagController ()<UITextFieldDelegate>
/**背景*/
@property (nonatomic,weak)UIView *contentView;
/**输入框*/
@property (nonatomic,weak)XYSTagTextField *textField;
/**添加按钮*/
@property (nonatomic,weak)UIButton *addButton;
/**标签按钮*/
@property (nonatomic,strong)NSMutableArray *listOfTagBtns;
@end

@implementation XYSAddTagController
#pragma mark -lazy
-(UIButton *)addButton
{
    if (!_addButton) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.xys_width = self.contentView.xys_width;
        btn.xys_height = 25;
        btn.xys_x = 0;
        btn.xys_y = CGRectGetMaxY(self.textField.frame);
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setImage:[UIImage imageNamed:@"tagicon"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.backgroundColor = XYSBackGroundColor;
        [btn addTarget:self action:@selector(addTag) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        
        _addButton = btn;
    }
    return _addButton;
}

-(NSMutableArray *)listOfTagBtns
{
    if (!_listOfTagBtns) {
        _listOfTagBtns = [NSMutableArray array];
    }
    
    return _listOfTagBtns;
}


#pragma mark -init
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavigation];
    [self setupContentView];
    [self setupTextField];
    [self setupTags];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textField becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.textField resignFirstResponder];
}
-(void)setupNavigation
{
    self.navigationItem.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(addTagDone)];

}
-(void)setupContentView
{
    UIView *contentView = [[UIView alloc]init];
    contentView.xys_x = XYSTagMargin;
    contentView.xys_y = 64+XYSTagMargin;
    contentView.xys_width = screenWidth - 2*contentView.xys_x;
    contentView.xys_height = screenHeight;
    
    [self.view addSubview:contentView];
    self.contentView = contentView;
}
-(void)setupTextField
{
    __weak __typeof(self) weakSelf = self;
    
    XYSTagTextField *textField = [[XYSTagTextField alloc]init];
    textField.delegate = self;
    //添加删除点击block
    [textField setDeleteBlock:^{
        XYSTagButton *lastBtn = [weakSelf.listOfTagBtns lastObject];
        
        [weakSelf cancelTag:lastBtn];
    }];
    
    [textField addTarget:self action:@selector(textEditingChange) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:textField];
    self.textField = textField;
}
- (void)setupTags
{
    for (NSString *tag in self.inputTags) {
        self.textField.text = tag;
        [self addTag];
    }
}
#pragma mark -主要方法
/**
 *  监听textField文字改变
 */
-(void)textEditingChange
{
    if (self.textField.hasText) {
        self.addButton.hidden = NO;
        [self.addButton setTitle:[NSString stringWithFormat:@"添加标签：%@",self.textField.text] forState:UIControlStateNormal];
        [self inputCommaAddTag];
    }else{
        self.addButton.hidden =YES;
    }
}
/**
 *  按下逗号添加标签
 */
-(void)inputCommaAddTag
{
    NSUInteger textLength = self.textField.text.length;
    NSString * lastCharacter = [self.textField.text substringFromIndex:textLength-1];
    
    if (([lastCharacter isEqualToString:@","]||[lastCharacter isEqualToString:@"，"]) && textLength >1) {
        self.textField.text = [self.textField.text substringToIndex:textLength - 1];
        [self addTag];
    }
    
}

/**
 *  更新标签的布局
 */
-(void)updateTagsFrame
{
    //修改标签的frame
    for (int i = 0; i<self.listOfTagBtns.count;i++) {
        XYSTagButton *tagbtn = self.listOfTagBtns[i];
        if (i==0) {//第一个
            tagbtn.xys_x = 0;
            tagbtn.xys_y = 0;
        }else{//后面的几个
            XYSTagButton *lastBtn = self.listOfTagBtns[i-1];
            if ((CGRectGetMaxX(lastBtn.frame) + XYSTagMargin + tagbtn.xys_width)>=self.contentView.xys_width) {//换行
                tagbtn.xys_x = 0;
                tagbtn.xys_y = CGRectGetMaxY(lastBtn.frame)+ XYSTagMargin;
            }else{//不换行
                tagbtn.xys_x = lastBtn.xys_x + lastBtn.xys_width + XYSTagMargin ;
                tagbtn.xys_y = lastBtn.xys_y;
            }
        }
    }
    //修改textField和addButton
    XYSTagButton *lastBtn = [self.listOfTagBtns lastObject];
    if ((CGRectGetMaxX(lastBtn.frame) + XYSTagMargin +100)>=self.contentView.xys_width) {//换行
        self.textField.xys_x = 0;
        self.textField.xys_y = CGRectGetMaxY(lastBtn.frame)+ XYSTagMargin;
    }else{//不换行
        self.textField.xys_x = lastBtn.xys_x + lastBtn.xys_width + XYSTagMargin;
        self.textField.xys_y = lastBtn.xys_y;
    }
    self.addButton.xys_y = CGRectGetMaxY(self.textField.frame) + XYSTagMargin;
}
#pragma mark -buttonClick
/**
 *  按下添加按钮标签
 */
-(void)addTag
{
    if (self.listOfTagBtns.count == 5) {
        [SVProgressHUD setMinimumDismissTimeInterval:1];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD showErrorWithStatus:@"最多添加5个标签"];
        return;
    }
    
    XYSTagButton *tagBtn = [XYSTagButton buttonWithType:UIButtonTypeCustom];
    [tagBtn setTitle:self.textField.text forState:UIControlStateNormal];
    [tagBtn addTarget:self action:@selector(cancelTag:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:tagBtn];
    [self.listOfTagBtns addObject:tagBtn];
    
    [self cleanupTextField];
    [self updateTagsFrame];
    
}
/**
 *  清除一个标签
 */
-(void)cancelTag:(UIButton*)btn
{
    [btn removeFromSuperview];
    [self.listOfTagBtns removeObject:btn];
    [UIView animateWithDuration:0.25 animations:^{
        [self updateTagsFrame];
    }];
}
/**
 *  清空TextField
 */
-(void)cleanupTextField
{
    self.textField.text = @"";
    self.addButton.hidden = YES;
}
/**
 *  点击“完成”传递数据到上一个控制器
 */
-(void)addTagDone{
    
    NSArray *tagTextArray = [self.listOfTagBtns valueForKey:@"currentTitle"];
    !self.sendTagBlock ? : self.sendTagBlock(tagTextArray);
    [self.navigationController popViewControllerAnimated:YES];
    
}
#pragma mark -<UITextFieldDelegate>
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.textField.hasText) {
         [self addTag];
    }
    return YES;
}




@end
