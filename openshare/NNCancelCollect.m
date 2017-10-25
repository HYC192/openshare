//
//  NNCanCelCollect.m
//  OpenShare
//
//  Created by mac on 2017/10/25.
//

#import "NNCancelCollect.h"

@implementation NNCancelCollect
//点击事件类型
+ (UIActivityCategory)activityCategory {
    return UIActivityCategoryAction;
}

- (UIImage *)activityImage {
    return [NSBundle nn_getImageWithName:@"icon_share_cancelcollect"];
}

- (NSString *)activityTitle {
    return @"取消收藏";
}
@end
