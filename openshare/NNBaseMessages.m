//
//  NNBaseMessages.m
//  openshare
//
//  Created by mac on 2017/10/12.
//  Copyright © 2017年 OpenShare http://openshare.gfzj.us/. All rights reserved.
//

#import "NNBaseMessages.h"

@implementation NNBaseMessages
@synthesize title = _title;
@synthesize content = _content;
@synthesize image = _image;
@synthesize url = _url;

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content image:(UIImage *)image url:(NSURL *)url otherActivitys:(NSArray<UIActivity *> *)otherActivitys{
    self = [super init];
    if (self) {
        _title = title;
        _content = content;
        _image = image;
        _url = url;
        _otherActivitys = otherActivitys;
    }
    return self;
}
@end
