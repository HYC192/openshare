//
//  NNShareViewController.m
//  openshare
//
//  Created by mac on 2017/10/12.
//  Copyright © 2017年 OpenShare http://openshare.gfzj.us/. All rights reserved.
//

#import "NNShareViewController.h"
#import "NNShareKitHandle.h"

@interface NNShareViewController ()<NNShareKitDelegate>

@end

@implementation NNShareViewController
#pragma mark - Lifecycle
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
//分享控件
- (void)didShareAction{
    NSString *textToShare = @"分享的文字";
    NSString *content = @"内容";
    UIImage *image = [UIImage imageNamed:@"share"];
    NSURL *urlToShare = [NSURL URLWithString:@"http://app.niannian99.com"];
    
    NNShareMessageObject *obj = [[NNShareMessageObject alloc] initWithTitle:textToShare
                                                                    content:content
                                                                      image:image
                                                                        url:urlToShare
                                    extInfo:nil otherActivitys:nil];

    NNShareContentController *shareController = [[NNShareContentController alloc] initWithObject:obj
                                                                                            type:NNShowShareTypeDefault

                                                   delegate:self                            shareContentType:NNShareContentTypeURL];

    
    
    [self presentViewController:shareController animated:YES completion:nil];

}

#pragma mark - NNShareKitDelegate
- (void)nn_shareMessageAction:(NNShareActionType)actionType shareMessage:(OSMessage * _Nullable)message {
    NNShareKitHandle *handle = [[NNShareKitHandle alloc] initWithHandleMessage:message type:actionType];
    [handle showShareControl:^(OSMessage *message) {
        
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
