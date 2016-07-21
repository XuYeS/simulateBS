//
//  XYSPlaceholderTextView.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/21.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSPlaceholderTextView.h"
@interface XYSPlaceholderTextView()
@property (nonatomic,strong)UILabel *placeholderLabel;

@end
@implementation XYSPlaceholderTextView

#pragma mark - lazy
-(UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc]init];
        _placeholderLabel.numberOfLines = 0;
        _placeholderLabel.xys_x = 4;
        _placeholderLabel.xys_y = 7;
    }
    return _placeholderLabel;
}
#pragma mark - init
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupPlaceholderLabel];
    }
    
    return self;
}

-(void)awakeFromNib
{
    [self setupPlaceholderLabel];
}
/**
 *  初始化占位文字
 */
-(void)setupPlaceholderLabel;
{

    //默认文字
    self.placeholderColor = [UIColor grayColor];
    //默认字体大小

    self.font = [UIFont systemFontOfSize:16];
    
    [self addSubview:self.placeholderLabel];
    //监听文本事件
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changePlaceholder) name:UITextViewTextDidChangeNotification object:nil];

}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
#pragma mark - observer
/**
 *  监听TextView的文字改变
 */
-(void)changePlaceholder
{
   self.placeholderLabel.hidden = self.hasText;
}
/**
 *  更新占位文字Label的变化
 */
-(void)updatePlaceholderLabelSize
{
    self.placeholderLabel.xys_width = self.bounds.size.width;
    CGSize maxSize = CGSizeMake(self.bounds.size.width - 2*self.placeholderLabel.xys_x, MAXFLOAT);
    
    CGFloat labelH = [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size.height;
    self.placeholderLabel.xys_height = labelH;
}

#pragma mark - setter
-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder=placeholder;
    self.placeholderLabel.text = placeholder;
    
    [self updatePlaceholderLabelSize];
}



-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
}

-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    [self updatePlaceholderLabelSize];
}

-(void)setText:(NSString *)text
{
    [super setText:text];
    
    [self changePlaceholder];
}

-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self changePlaceholder];
}



@end
