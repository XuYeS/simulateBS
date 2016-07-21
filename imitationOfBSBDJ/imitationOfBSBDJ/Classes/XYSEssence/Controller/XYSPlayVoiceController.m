//
//  XYSPlayVoiceController.m
//  imitationOfBSBDJ
//
//  Created by 徐烨晟 on 16/7/20.
//  Copyright © 2016年 徐烨晟. All rights reserved.
//

#import "XYSPlayVoiceController.h"
#import "XYSTopicModel.h"
@interface XYSPlayVoiceController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation XYSPlayVoiceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.webView.delegate = self;
//    if (self.topicModel.voiceuri) {
//        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.topicModel.voiceuri]]];
//    }else if (self.topicModel.videouri)
//    {
//        
//    }
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    
}
- (IBAction)back:(id)sender {
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabBarVc.selectedViewController;
    [nav popToViewController:self animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
