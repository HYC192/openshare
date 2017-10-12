//
//  NNBaseShareKit.h
//  NNShareKit_Example
//
//  Created by mac on 2017/10/10.
//  Copyright © 2017年 HYC192. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+NNImagePath.h"

@interface NNBaseShareKit : UIActivity
/**
 标题
 */
@property (strong, readonly, nonatomic) NSString *title;
/**
 图标
 */
@property (strong, readonly, nonatomic) UIImage *image;

/**
 链接地址
 */
@property (nonatomic, strong, readonly) NSURL *url;

/**
 回调block
 */
@property (nonatomic, copy) void(^performActivityBlock)(void);

/**
 初始化图标数据

 @param title 名称标题
 @param image 图标
 @param url 链接地址
 @return 创建成功
 */
- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image url:(NSURL *)url;
@end
