//
//  NSBundle+NNShareKit.h
//  NNShareKit_Example
//
//  Created by mac on 2017/10/11.
//  Copyright © 2017年 HYC192. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSBundle (NNShareKit)
+ (instancetype)nn_shareKitBundle;
+ (UIImage *)nn_getImageWithName:(NSString *)image;
@end
