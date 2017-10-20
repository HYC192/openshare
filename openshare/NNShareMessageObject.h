//
//  NNShareMessageObject.h
//  NNShareKit_Example
//
//  Created by mac on 2017/10/10.
//  Copyright © 2017年 HYC192. All rights reserved.
//

#import "NNBaseMessages.h"

typedef NS_ENUM(NSInteger, NNShareContentType) {
    ///分享文字
    NNShareContentTypeText = 0,
    ///分享图片
    NNShareContentTypePhoto,
    ///分享链接
    NNShareContentTypeURL,
};

@interface NNShareMessageObject : NNBaseMessages
/**
 获取自定义分享平台

 @return 返回结果
 */
- (NSArray *)shareMessageObjectWithActivitys;

/**
 获取分享数据

 @return 返回Item数据
 */
- (NSArray *)shareMessageObjectWithActivityItems;
@end
