//
//  NNShareViewController.m
//  openshare
//
//  Created by mac on 2017/10/12.
//  Copyright © 2017年 OpenShare http://openshare.gfzj.us/. All rights reserved.
//

#import "NNShareViewController.h"
//#import "NNShareKit.h"
#import "OpenShareHeader.h"

@interface NNShareViewController ()

@end

@implementation NNShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"分享界面";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *testBtn = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame)-50, 100, 100, 30)];
    [testBtn setTitle:@"分享控件" forState:UIControlStateNormal];
    [testBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    testBtn.backgroundColor = [UIColor grayColor];
    [testBtn addTarget:self action:@selector(didShareAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testBtn];
}

//分享控件
- (void)didShareAction{
//    NSString *textToShare = @"分享的文字";
//    UIImage *image = [UIImage imageNamed:@"share"];
//    NSURL *urlToShare = [NSURL URLWithString:@"http://app.niannian99.com"];
//    
//    NNShareMessageObject *obj = [[NNShareMessageObject alloc]
//                                 initWithTitle:textToShare
//                                 image:image
//                                 url:urlToShare
//                                 activitys:nil
//                                 shareContentType:NNShareContentTypeURL];
//    
//    NNShareContentController *shareController = [[NNShareContentController alloc] initWithObject:obj];
//    shareController.completionWithItemsHandler = ^(NSString *activityType, BOOL completed, NSArray *returnedItems, NSError *activityError) {
//        NSLog(@"type>==%@", activityType);
//    };
//    
//    [self presentViewController:shareController animated:YES completion:nil];

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
