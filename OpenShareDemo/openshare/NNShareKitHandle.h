//
//  NNShareKitHandle.h
//  openshare
//
//  Created by mac on 2017/10/20.
//  Copyright © 2017年 OpenShare http://openshare.gfzj.us/. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NNShareKit.h"

typedef void (^shareSuccessBlock)(OSMessage *message);
@interface NNShareKitHandle : NSObject
/**
 初始化分享数据

 @param message 数据
 @param actionType 分享类型
 @return 返回结果
 */
- (instancetype)initWithHandleMessage:(OSMessage *)message
                            type:(NNShareActionType)actionType;

- (void)showShareControl:(shareSuccessBlock)block;
@end
