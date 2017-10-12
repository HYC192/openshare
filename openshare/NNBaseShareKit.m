//
//  NNBaseShareKit.m
//  NNShareKit_Example
//
//  Created by mac on 2017/10/10.
//  Copyright © 2017年 HYC192. All rights reserved.
//

#import "NNBaseShareKit.h"

@implementation NNBaseShareKit
@synthesize title = _title;
@synthesize image = _image;
@synthesize url = _url;

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image url:(NSURL *)url{
    self = [super init];
    if (self) {
        _title = title;
        _image = image;
        _url = url;
    }
    return self;
}

+ (UIActivityCategory)activityCategory
{
    return UIActivityCategoryShare;
}

- (NSString *)activityType
{
    return NSStringFromClass([self class]);
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    //    for (id activityItem in activityItems) {
    //        if ([activityItem isKindOfClass:[UIImage class]]) {
    //            return YES;
    //        }
    //        if ([activityItem isKindOfClass:[NSURL class]]) {
    //            return YES;
    //        }
    //    }
    //    return NO;
    return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    for (id activityItem in activityItems) {
        if ([activityItem isKindOfClass:[UIImage class]]) {
            _image = activityItem;
        }
        if ([activityItem isKindOfClass:[NSURL class]]) {
            _url = activityItem;
        }
        if ([activityItem isKindOfClass:[NSString class]]) {
            _title = activityItem;
        }
    }
}

- (void)performActivity {
    if (self.performActivityBlock) {
        self.performActivityBlock();
    }
    [self activityDidFinish:YES];
}
@end
