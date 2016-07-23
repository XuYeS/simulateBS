//
//  XYSAddTagController.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/23.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSAddTagController.h"

@interface XYSAddTagController ()
/**背景*/
@property (nonatomic,weak)UIView *contentView;
/**输入框*/
@property (nonatomic,weak)UITextField *textField;
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

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textField becomeFirstResponder];
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
    UITextField *textField = [[UITextField alloc]init];
    textField.xys_width = screenWidth;
    textField.xys_height = 25;
    textField.placeholder = @"多个标签用逗号或者换行隔开";
    textField.font = [UIFont systemFontOfSize:15];
    [textField addTarget:self action:@selector(textEditingChange) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:textField];
    self.textField = textField;
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
    }else{
        self.addButton.hidden =YES;
    }
}
/**
 *  按下添加按钮标签
 */
-(void)addTag
{
    
    UIButton *tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagBtn setBackgroundColor:XYSTagColor];
    tagBtn.clipsToBounds = YES;
    tagBtn.layer.cornerRadius = 5;
 
    
    [tagBtn setTitle:self.textField.text forState:UIControlStateNormal];
    tagBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    tagBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -2*XYSTagMargin, 0, 0);
    [tagBtn setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
    
    tagBtn.contentEdgeInsets = UIEdgeInsetsMake(XYSTagMargin, 2*XYSTagMargin, XYSTagMargin, XYSTagMargin);
    [tagBtn sizeToFit];
    
    [tagBtn addTarget:self action:@selector(cancelTag:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:tagBtn];
    [self.listOfTagBtns addObject:tagBtn];
    
    [self cleanupTextField];
    [self updateTagsFrame];
    

    
}
/**
 *  更新标签的布局
 */
-(void)updateTagsFrame
{
    //修改标签的frame
    for (int i = 0; i<self.listOfTagBtns.count;i++) {
        UIButton *tagbtn = self.listOfTagBtns[i];
        if (i==0) {//第一个
            tagbtn.xys_x = 0;
            tagbtn.xys_y = 0;
        }else{//后面的几个
            UIButton *lastBtn = self.listOfTagBtns[i-1];
            if ((lastBtn.xys_x + lastBtn.xys_width + XYSTagMargin + tagbtn.xys_width)>=self.contentView.xys_width) {//换行
                tagbtn.xys_x = 0;
                tagbtn.xys_y = CGRectGetMaxY(lastBtn.frame)+ XYSTagMargin;
            }else{//不换行
                tagbtn.xys_x = lastBtn.xys_x + lastBtn.xys_width + XYSTagMargin ;
                tagbtn.xys_y = lastBtn.xys_y;
            }
        }
    }
    //修改textField和addButton
    UIButton *lastBtn = [self.listOfTagBtns lastObject];
    if ((lastBtn.xys_x + lastBtn.xys_width + XYSTagMargin +100)>=self.contentView.xys_width) {//换行
        self.textField.xys_x = 0;
        self.textField.xys_y = CGRectGetMaxY(lastBtn.frame)+ XYSTagMargin;
    }else{//不换行
        self.textField.xys_x = lastBtn.xys_x + lastBtn.xys_width + XYSTagMargin;
        self.textField.xys_y = lastBtn.xys_y;
    }
    self.addButton.xys_y = CGRectGetMaxY(self.textField.frame) + XYSTagMargin;
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
-(void)addTagDone{
    
}




@end
