//
//  NNShareMessageObject.m
//  NNShareKit_Example
//
//  Created by mac on 2017/10/10.
//  Copyright © 2017年 HYC192. All rights reserved.
//

#import "NNShareMessageObject.h"
#import "NSString+NNValid.h"
#import "NNChatShare.h"
#import "NNCopyLink.h"
#import "NNSavePhoto.h"
#import "NNWechatSessionShare.h"

@implementation NNShareMessageObject
- (NSArray *)shareMessageObjectWithActivityItems{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    switch (self.type) {
        case NNShareContentTypePhoto:
        {
            if (self.image) {
                [items addObject:self.image];
            }
        }
            break;
            
        case NNShareContentTypeURL:
        {
            if (![NSString nn_vaildEmptyStringWithoutSpace:self.title]) {
                [items addObject:self.title];
            }
            
            if (self.image) {
                [items addObject:self.image];
            }
            
            if (self.url) {
                [items addObject:self.url];
            }
        }
            break;
            
        case NNShareContentTypeText:
        default:
        {
            if (![NSString nn_vaildEmptyStringWithoutSpace:self.title]) {
                [items addObject:self.title];
                
                if (self.image) {
                    [items addObject:self.image];
                }
            }
        }
            break;
    }
    return items;
}

- (NSArray *)shareMessageObjectWithActivitys{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    //添加留言室分享Action
    NNChatShare *chatShare = [[NNChatShare alloc] init];
    __weak typeof(self) weakSelf = self;
    chatShare.performActivityBlock = ^{
        [weakSelf shareChatAction];
    };
    [arr addObject:chatShare];
    
    //复制链接Action
    NNCopyLink *copyLink = [[NNCopyLink alloc] init];
    copyLink.performActivityBlock = ^{
        [weakSelf copyAction];
    };
    [arr addObject:copyLink];
    
    //保存到手机Action
    NNSavePhoto *savePhoto = [[NNSavePhoto alloc] init];
//    [savePhoto setPerformActivityBlock:^{
//
//    }];
    savePhoto.performActivityBlock = ^{
        [weakSelf savePhotoAction];
    };
    [arr addObject:savePhoto];
    
    if (self.activitys && self.activitys.count > 0) {
        [arr addObjectsFromArray:self.activitys];
    }
    return arr;
}

#pragma mark - Action
//分享到留言室
- (void)shareChatAction{
    NSLog(@"留言室");
}

//复制链接
- (void)copyAction{
    
}

//保存到手机相册
- (void)savePhotoAction{
    
}
@end
