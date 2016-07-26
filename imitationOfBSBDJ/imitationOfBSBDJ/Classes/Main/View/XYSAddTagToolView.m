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
/** 上部View*/
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak,nonatomic)UIButton *addButton;
/** 存放所有的标签label */
@property (nonatomic, strong) NSMutableArray *tagLabels;

@end
@implementation XYSAddTagToolView
#pragma mark - lazy

- (NSMutableArray *)tagLabels
{
    if (!_tagLabels) {
        _tagLabels = [NSMutableArray array];
    }
    return _tagLabels;
}

#pragma mark -init
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
    self.addButton = addTagBtn;
    NSArray *initArry = @[@"搞笑",@"吐槽"];
    [self createTagLabels:initArry];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self updateTagsFrame];
}

#pragma mark -主要方法
-(void)updateViewFrame
{
    CGFloat oldTopViewH = self.xys_height;
    self.xys_height = CGRectGetMaxY(self.addButton.frame)+45;
    self.xys_y -= self.xys_height - oldTopViewH;
}
-(void)addTag
{
    //a modal 出来的控制器b  a.presentedViewController = b  b.presentingViewController = a;
    UINavigationController *nc = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController.presentedViewController;
   
    XYSAddTagController *atc = [[XYSAddTagController alloc]init];
    //block回传参数
    __weak __typeof(self) weakSelf = self;
    [atc setSendTagBlock:^(NSArray *tagTextArray) {
        
        [weakSelf createTagLabels:tagTextArray];
    }];
    atc.inputTags = [self.tagLabels valueForKey:@"text"];
    [nc pushViewController:atc animated:YES];
    
}

/**
 * 创建标签
 */
- (void)createTagLabels:(NSArray *)tags
{
    [self.tagLabels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagLabels removeAllObjects];
    
    for (int i = 0; i<tags.count; i++) {
        UILabel *tagLabel = [[UILabel alloc] init];
        [self.tagLabels addObject:tagLabel];
        tagLabel.backgroundColor = XYSTagColor;
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.text = tags[i];
        tagLabel.font = [UIFont systemFontOfSize:14];
        // 应该要先设置文字和字体后，再进行计算
        [tagLabel sizeToFit];
        tagLabel.xys_width += 2 * XYSTagMargin;
        tagLabel.xys_height = 25;
        tagLabel.textColor = [UIColor whiteColor];
        tagLabel.clipsToBounds = YES;
        tagLabel.layer.cornerRadius = 5;
        [self.topView addSubview:tagLabel];
        
        }
    [self setNeedsLayout];
}
-(void)updateTagsFrame
{
    for (int i = 0; i<self.tagLabels.count; i++) {
        UILabel *tagLabel = self.tagLabels[i];
        
        // 设置位置
        if (i == 0) { // 最前面的标签
            tagLabel.xys_x = 0;
            tagLabel.xys_y = 0;
        } else { // 其他标签
            UILabel *lastTagLabel = self.tagLabels[i - 1];
            // 计算当前行左边的宽度
            CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + XYSTagMargin;
            // 计算当前行右边的宽度
            CGFloat rightWidth = self.topView.xys_width - leftWidth;
            if (rightWidth >= tagLabel.xys_width) { // 按钮显示在当前行
                tagLabel.xys_y = lastTagLabel.xys_y;
                tagLabel.xys_x = leftWidth;
            } else { // 按钮显示在下一行
                tagLabel.xys_x = 0;
                tagLabel.xys_y = CGRectGetMaxY(lastTagLabel.frame) + XYSTagMargin;
            }
        }
    }
    
    // 最后一个标签
    UILabel *lastTagLabel = [self.tagLabels lastObject];
    CGFloat leftWidth = CGRectGetMaxX(lastTagLabel.frame) + XYSTagMargin;
    
    // 更新textField的frame
    if (self.topView.xys_width - leftWidth >= self.addButton.xys_width) {
        self.addButton.xys_y = lastTagLabel.xys_y;
        self.addButton.xys_x = leftWidth;
    } else {
        self.addButton.xys_x = 0;
        self.addButton.xys_y = CGRectGetMaxY(lastTagLabel.frame) + XYSTagMargin;
    }
    
    [self updateViewFrame];
}


@end
