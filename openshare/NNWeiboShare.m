//
//  NNWeiboShare.m
//  NNShareKit_Example
//
//  Created by mac on 2017/10/10.
//  Copyright © 2017年 HYC192. All rights reserved.
//

#import "NNWeiboShare.h"

@implementation NNWeiboShare
- (UIImage *)activityImage
{
    return [NSBundle nn_getImageWithName:@"icon_share_weibo"];
}

- (NSString *)activityTitle
{
    return @"微博";
}
@end
