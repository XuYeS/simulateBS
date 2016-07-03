//
//  XYSLoginRegisterController.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/3.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSLoginRegisterController.h"

@interface XYSLoginRegisterController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;
@property (weak, nonatomic) IBOutlet UIView *longinView;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;


@end

@implementation XYSLoginRegisterController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.longinView layoutIfNeeded];
    if (self.isLogin) {
        self.registerButton.selected = NO;
        self.leftMargin.constant = 0;
    }
    else{
        self.registerButton.selected = YES;
        self.leftMargin.constant -= [UIScreen mainScreen].bounds.size.width;
    }
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginOrRegister:(UIButton*)sender {
    
    if (self.longinView.xys_x == 0) {
        sender.selected = YES;
        self.leftMargin.constant -= self.longinView.xys_width;
    }else{
        sender.selected = NO;
        self.leftMargin.constant = 0;
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
