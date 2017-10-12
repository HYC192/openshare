//
//  NNShareContentController.h
//  NNShareKit_Example
//
//  Created by mac on 2017/10/10.
//  Copyright © 2017年 HYC192. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NNShareMessageObject;
@interface NNShareContentController : UIActivityViewController
/**
 初始化

 @param shareMessageObj 消息体
 @return 实例化
 */
- (instancetype)initWithObject:(NNShareMessageObject *)shareMessageObj;
/**
 是否显示Airdrop
 */
@property (nonatomic, getter=isShowAirDrop) BOOL showAirDrop;
@end
