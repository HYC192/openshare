//
//  NNShareMessageObject.m
//  NNShareKit_Example
//
//  Created by mac on 2017/10/10.
//  Copyright © 2017年 HYC192. All rights reserved.
//

#import "NNShareMessageObject.h"
#import "NSString+NNValid.h"


@implementation NNShareMessageObject
- (NSArray *)shareMessageObjectWithActivityItems{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    if (![NSString nn_vaildEmptyStringWithoutSpace:self.title]) {
        [items addObject:self.title];
    }
    
    if (self.image) {
        [items addObject:self.image];
    }
    
    if (self.url) {
        [items addObject:self.url];
    }
    return items;
}

- (NSArray *)shareMessageObjectWithActivitys{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    if (self.otherActivitys && self.otherActivitys.count > 0) {
        [arr addObjectsFromArray:self.otherActivitys];
    }
    return arr;
}
@end
