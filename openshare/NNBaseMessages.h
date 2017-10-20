//
//  NNBaseMessages.h
//  openshare
//
//  Created by mac on 2017/10/12.
//  Copyright © 2017年 OpenShare http://openshare.gfzj.us/. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NNBaseMessages : NSObject
/**
 标题
 */
@property (strong, readonly, nonatomic) NSString *title;

/**
 内容
 */
@property (strong, readonly, nonatomic) NSString *content;

/**
 图标
 */
@property (strong, readonly, nonatomic) UIImage *image;

/**
 链接地址
 */
@property (nonatomic, strong, readonly) NSURL *url;

@property (nonatomic, strong) NSArray<UIActivity *> *otherActivitys;

/**
 初始化图标数据
 
 @param title 名称标题
 @param content 内容
 @param image 图标
 @param url 链接地址
 @param showType 显示功能类型
 @param otherActivitys 添加其他自定义类型
 @param type 分享类型
 @return 创建成功
 */
- (instancetype)initWithTitle:(NSString *)title
                      content:(NSString *)content
                        image:(UIImage *)image
                          url:(NSURL *)url
               otherActivitys:(NSArray<UIActivity *> *)otherActivitys;

@end
