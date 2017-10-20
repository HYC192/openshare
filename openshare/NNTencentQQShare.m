//
//  NNTencentQQShare.m
//  openshare
//
//  Created by mac on 2017/10/13.
//  Copyright © 2017年 OpenShare http://openshare.gfzj.us/. All rights reserved.
//

#import "NNTencentQQShare.h"

@implementation NNTencentQQShare
- (UIImage *)activityImage
{
    return [NSBundle nn_getImageWithName:@"icon_share_qq"];
}

- (NSString *)activityTitle
{
    return @"QQ";
}
@end
