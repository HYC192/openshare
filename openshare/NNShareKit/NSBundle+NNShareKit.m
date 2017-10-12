//
//  NSBundle+NNShareKit.m
//  NNShareKit_Example
//
//  Created by mac on 2017/10/11.
//  Copyright © 2017年 HYC192. All rights reserved.
//

#import "NSBundle+NNShareKit.h"
#import "NNBaseShareKit.h"

@implementation NSBundle (NNShareKit)
+ (instancetype)nn_shareKitBundle
{
    static NSBundle *shareKitBundle = nil;
    if (shareKitBundle == nil) {
        // 这里不使用mainBundle是为了适配pod 1.x和0.x
        shareKitBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[NNBaseShareKit class]] pathForResource:@"NNShareKit" ofType:@"bundle"]];
    }
    return shareKitBundle;
}

+ (UIImage *)nn_getImageWithName:(NSString *)image
{
    UIImage *iconImage = nil;
    if (image && image.length > 0) {
        iconImage = [[UIImage imageWithContentsOfFile:[[self nn_shareKitBundle] pathForResource:image ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return iconImage;
}


@end
