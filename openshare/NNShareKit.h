//
//  NNShareKit.h
//  NNShareKit
//
//  Created by mac on 2017/10/10.
//  Copyright © 2017年 HYC192. All rights reserved.
//

#ifndef nn_weakify
#if DEBUG
#if __has_feature(objc_arc)
#define nn_weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define nn_weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define nn_weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define nn_weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef nn_strongify
#if DEBUG
#if __has_feature(objc_arc)
#define nn_strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define nn_strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define nn_strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define nn_strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

#import "NNBaseShareKit.h"
#import "NNShareContentController.h"
#import "NNShareMessageObject.h"
#import "OpenShareHeader.h"
#import "NSString+NNValid.h"
