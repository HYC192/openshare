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
        shareKitBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[NNBaseShareKit class]] pathForResource:@"openshare" ofType:@"bundle"]];
    }
    return shareKitBundle;
}

+ (UIImage *)nn_getImageWithName:(NSString *)image
{
    UIImage *iconImage = nil;
    
    NSString *imagePath = [self getImagePathWithImageName:image];
    
    if (imagePath && imagePath.length > 0) {
        iconImage = [[UIImage imageWithContentsOfFile:imagePath] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return iconImage;
}

//删除尾部Coment
+ (NSString *)deleteLastPathWithString:(NSString *)path extension:(NSString *)ext{
    NSString *ret = path;
    if (ext && ext.length > 0) {
        
        ret = [ret stringByReplacingOccurrencesOfString:ext withString:@""];
    }
    
    if ([ret containsString:@"@2x"] || [ret containsString:@"@3x"]) {
        ret = [ret stringByReplacingOccurrencesOfString:@"@2x" withString:@""];
        ret = [ret stringByReplacingOccurrencesOfString:@"@3x" withString:@""];
    }
    
    return ret;
}

+ (BOOL)isExsitImagePath:(NSString *)imageName ext:(NSString *)ext{
    BOOL ret = NO;
    NSString *extension = @"png";
    if (ext && ext.length > 0) {
        extension = ext;
    }
    
    NSString *imagePath = [[self nn_shareKitBundle] pathForResource:imageName ofType:extension];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:imagePath]) {
        ret = YES;
    }
    else
    {
        ret = NO;
    }
    
    return ret;
}

+ (NSString *)getImagePathWithImageName:(NSString *)imageName{
    
    NSString *imgName = imageName;
    
    
    NSString *extension = nil;
    if ([imgName containsString:@".png"] || [imgName containsString:@".jpg"]) {
        NSString *extension = @".png";
        if ([imgName containsString:@".jpg"]) {
            extension = @".jpg";
        }
    }
    
    imgName = [self deleteLastPathWithString:imgName extension:extension];
    
    NSString *ext = @"png";
    if (extension && extension.length > 0) {
        ext = [extension stringByReplacingOccurrencesOfString:@"." withString:@""];
    }
    
    CGFloat sc = [UIScreen mainScreen].scale;
    NSLog(@"[UIScreen mainScreen].scale= %lf", sc);
    
    NSString *imgLastName = nil;
    NSString *imagePath = nil;
    if (sc > 2.0) {
        imgLastName = [imgName stringByAppendingString:@"@3x"];
        if ([self isExsitImagePath:imgLastName ext:ext]) {
            imagePath = [[self nn_shareKitBundle] pathForResource:imgLastName ofType:ext];
            return imagePath;
        }
        else
        {
            imgLastName = [imgName stringByAppendingString:@"@2x"];
            if ([self isExsitImagePath:imgLastName ext:ext]) {
                imagePath = [[self nn_shareKitBundle] pathForResource:imgLastName ofType:ext];
                return imagePath;
            }
            else
            {
                imgLastName = imgName;
                if ([self isExsitImagePath:imgLastName ext:ext]) {
                    imagePath = [[self nn_shareKitBundle] pathForResource:imgLastName ofType:ext];
                    return imagePath;
                }
            }
        }
    }
    else if(sc > 1.0)
    {
        imgLastName = [imgName stringByAppendingString:@"@2x"];
        if ([self isExsitImagePath:imgLastName ext:ext]) {
            imagePath = [[self nn_shareKitBundle] pathForResource:imgLastName ofType:ext];
            return imagePath;
        }
        else
        {
            imgLastName = [imgName stringByAppendingString:@"@3x"];
            if ([self isExsitImagePath:imgLastName ext:ext]) {
                imagePath = [[self nn_shareKitBundle] pathForResource:imgLastName ofType:ext];
                return imagePath;
            }
            else
            {
                imgLastName = imgName;
                if ([self isExsitImagePath:imgLastName ext:ext]) {
                    imagePath = [[self nn_shareKitBundle] pathForResource:imgLastName ofType:ext];
                    return imagePath;
                }
            }
        }
    }
    else
    {
        imgLastName = imgName;
        if ([self isExsitImagePath:imgLastName ext:ext]) {
            imagePath = [[self nn_shareKitBundle] pathForResource:imgLastName ofType:ext];
            return imagePath;
        }
    }
    return imagePath;
}

@end
