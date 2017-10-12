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
@synthesize image = _image;
@synthesize url = _url;
@synthesize type = _type;

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image url:(NSURL *)url activitys:(NSArray<UIActivity *> *)activitys shareContentType:(NNShareContentType)type{
    self = [super init];
    if (self) {
        _title = title;
        _image = image;
        _url = url;
        _type = type;
        _activitys = activitys;
    }
    return self;
}
@end
