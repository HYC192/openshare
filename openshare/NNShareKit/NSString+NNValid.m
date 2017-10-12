//
//  NSString+NNValit.m
//  NNShareKit_Example
//
//  Created by mac on 2017/10/10.
//  Copyright © 2017年 HYC192. All rights reserved.
//

#import "NSString+NNValid.h"

@implementation NSString (NNValid)
+ (BOOL)nn_vaildEmptyStringWithoutSpace:(NSString *)text{
    BOOL ret = NO;
    NSString *str = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (str==nil ||[@"null" isEqualToString:str] || [@"" isEqualToString:str] || [@" " isEqualToString:str] || [@"  " isEqualToString:str] || [@"<null>" isEqualToString:str] || [@"(null)" isEqualToString:str] || [[NSNull null] isEqual:str]||[@"\"null\"" isEqualToString:str] || str.length == 0) {
        ret = YES;
    }
    
    return ret;
}
@end
