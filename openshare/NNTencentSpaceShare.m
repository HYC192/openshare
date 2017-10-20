//
//  NNTencentSpaceShare.m
//  openshare
//
//  Created by mac on 2017/10/13.
//  Copyright © 2017年 OpenShare http://openshare.gfzj.us/. All rights reserved.
//

#import "NNTencentSpaceShare.h"

@implementation NNTencentSpaceShare
- (UIImage *)activityImage
{
    return [NSBundle nn_getImageWithName:@"icon_share_qzone"];
}

- (NSString *)activityTitle
{
    return @"QQ空间";
}
@end
