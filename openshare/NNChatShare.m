//
//  NNChatShare.m
//  NNShareKit_Example
//
//  Created by mac on 2017/10/10.
//  Copyright © 2017年 HYC192. All rights reserved.
//

#import "NNChatShare.h"

@implementation NNChatShare
- (UIImage *)activityImage
{
    return [NSBundle nn_getImageWithName:@"icon_share_nnchat"];
}

- (NSString *)activityTitle
{
    return @"留言室";
}
@end
