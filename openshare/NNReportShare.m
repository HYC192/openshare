//
//  NNReportShare.m
//  openshare
//
//  Created by mac on 2017/10/13.
//  Copyright © 2017年 OpenShare http://openshare.gfzj.us/. All rights reserved.
//

#import "NNReportShare.h"

@implementation NNReportShare
//点击事件类型
+ (UIActivityCategory)activityCategory {
    return UIActivityCategoryAction;
}

- (UIImage *)activityImage {
    return [NSBundle nn_getImageWithName:@"icon_share_jubao"];
}

- (NSString *)activityTitle {
    return @"举报";
}
@end
