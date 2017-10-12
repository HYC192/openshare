//
//  NNBaseMessages.h
//  openshare
//
//  Created by mac on 2017/10/12.
//  Copyright © 2017年 OpenShare http://openshare.gfzj.us/. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NNShareContentType) {
    NNShareContentTypeText = 0, //分享文字
    NNShareContentTypePhoto, //分享图片
    NNShareContentTypeURL, //分享链接
};
@interface NNBaseMessages : NSObject
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
 分享类型
 */
@property (nonatomic, assign, readonly) NNShareContentType type;

@property (nonatomic, strong) NSArray<UIActivity *> *activitys;

/**
 初始化图标数据
 
 @param title 名称标题
 @param image 图标
 @param url 链接地址
 @param type 分享类型
 @param activitys 自定义类型
 @return 创建成功
 */
- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                          url:(NSURL *)url
                    activitys:(NSArray<UIActivity *> *)activitys
             shareContentType:(NNShareContentType)type;

@end
