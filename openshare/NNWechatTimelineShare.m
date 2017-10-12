//
//  NNWechatTimelineShare.m
//  NNShareKit_Example
//
//  Created by mac on 2017/10/10.
//  Copyright © 2017年 HYC192. All rights reserved.
//

#import "NNWechatTimelineShare.h"

@implementation NNWechatTimelineShare
- (UIImage *)activityImage
{
    return [NSBundle nn_getImageWithName:@"icon_share_wctimeline@2x"];
}

- (NSString *)activityTitle
{
    return @"微信朋友圈";
}
@end
