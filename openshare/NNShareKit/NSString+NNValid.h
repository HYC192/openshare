//
//  NSString+NNValit.h
//  NNShareKit_Example
//
//  Created by mac on 2017/10/10.
//  Copyright © 2017年 HYC192. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NNValid)
/**
 验证字符串是否为空

 @param text 输入字符串
 @return 返回结果
 */
+ (BOOL)nn_vaildEmptyStringWithoutSpace:(NSString *)text;
@end
