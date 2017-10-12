//
//  NSString+NNImagePath.m
//  openshare
//
//  Created by mac on 2017/10/12.
//  Copyright © 2017年 OpenShare http://openshare.gfzj.us/. All rights reserved.
//

#import "NSString+NNImagePath.h"
#import "NNBaseShareKit.h"

@implementation NSString (NNImagePath)
+ (instancetype)nn_shareKitPath
{
    static NSString *shareKitPath = nil;
    if (shareKitPath == nil) {
        // 这里不使用mainBundle是为了适配pod 1.x和0.x
        shareKitPath = [[NSBundle bundleForClass:[NNBaseShareKit class]] resourcePath];
    }
    return shareKitPath;
}

+ (NSString *)getCompenentPath:(NSString *)imagePath{
    return [[self nn_shareKitPath] stringByAppendingPathComponent:imagePath];
}

+ (UIImage *)nn_getImageWithName:(NSString *)image
{
    UIImage *iconImage = nil;
    if (image && image.length > 0) {
        iconImage = [[UIImage imageWithContentsOfFile:[self getCompenentPath:image]]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return iconImage;
}
@end
