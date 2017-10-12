//
//  NNSavePhoto.m
//  NNShareKit_Example
//
//  Created by mac on 2017/10/10.
//  Copyright © 2017年 HYC192. All rights reserved.
//

#import "NNSavePhoto.h"

@implementation NNSavePhoto
//点击事件类型
+ (UIActivityCategory)activityCategory {
    return UIActivityCategoryAction;
}

- (UIImage *)activityImage {
    return [NSString nn_getImageWithName:@"icon_share_copylink@2x"];
}

- (NSString *)activityTitle {
    return @"保存到相册";
}
@end
