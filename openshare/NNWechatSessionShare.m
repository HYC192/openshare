//
//  NNWeichatShare.m
//  NNShareKit_Example
//
//  Created by mac on 2017/10/10.
//  Copyright © 2017年 HYC192. All rights reserved.
//

#import "NNWechatSessionShare.h"

@implementation NNWechatSessionShare
- (UIImage *)activityImage
{
    return [NSBundle nn_getImageWithName:@"icon_share_wechat"];
}

- (NSString *)activityTitle
{
    return @"微信";
}
@end
