//
//  NNCopyLink.m
//  NNShareKit_Example
//
//  Created by mac on 2017/10/10.
//  Copyright © 2017年 HYC192. All rights reserved.
//

#import "NNCopyLink.h"

@implementation NNCopyLink
//点击事件类型
+ (UIActivityCategory)activityCategory {
    return UIActivityCategoryAction;
}

- (UIImage *)activityImage {
    return [UIImage imageNamed:@"icon_share_copylink@2x"];
}

- (NSString *)activityTitle {
    return @"复制链接";
}
@end
