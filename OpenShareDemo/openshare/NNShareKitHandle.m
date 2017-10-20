//
//  NNShareKitHandle.m
//  openshare
//
//  Created by mac on 2017/10/20.
//  Copyright © 2017年 OpenShare http://openshare.gfzj.us/. All rights reserved.
//

#import "NNShareKitHandle.h"

@interface NNShareKitHandle ()
@property (nonatomic, strong) OSMessage *message;
@property (nonatomic, assign) NNShareActionType type;
@property (nonatomic, copy) shareSuccessBlock block;
@end

@implementation NNShareKitHandle
- (instancetype)initWithHandleMessage:(OSMessage *)message type:(NNShareActionType)actionType{
    self = [super init];
    if (self) {
        _message = message;
        _type = actionType;
    }
    return self;
}

#pragma mark ------------------- Public ----------------------
- (void)showShareControl:(shareSuccessBlock)block{
    _block = block;
    [self shareMessageAction:self.type shareMessage:self.message];
}

- (void)shareMessageAction:(NNShareActionType)actionType shareMessage:(OSMessage * _Nullable)content {
    NSLog(@"---------------");
    switch (actionType) {
            //分享到微信好友
        case NNShareActionTypeWeChatSession:
        {
            [OpenShare shareToWeixinSession:content Success:^(OSMessage *message) {
                NSLog(@"微信分享到会话成功：\n%@",message);
                if (self.block) {
                    self.block(message);
                }
            } Fail:^(OSMessage *message, NSError *error) {
                NSLog(@"微信分享到会话失败：\n%@\n%@",error,message);
                if (self.block) {
                    self.block(nil);
                }
            }];
        }
            break;
            
            //分享到微信朋友圈
        case NNShareActionTypeWeChatTimeline:
        {
            [OpenShare shareToWeixinTimeline:content Success:^(OSMessage *message) {
                NSLog(@"微信分享到朋友圈成功：\n%@",message);
                if (self.block) {
                    self.block(message);
                }
            } Fail:^(OSMessage *message, NSError *error) {
                NSLog(@"微信分享到朋友圈失败：\n%@\n%@",error,message);
                if (self.block) {
                    self.block(nil);
                }
            }];
        }
            break;
            
            //分享到腾讯qq
        case NNShareActionTypeTencentQQ:
        {
            [OpenShare shareToQQFriends:content Success:^(OSMessage *message) {
                NSLog(@"分享到QQ好友成功:%@",message);
                if (self.block) {
                    self.block(message);
                }
            } Fail:^(OSMessage *message, NSError *error) {
                NSLog(@"分享到QQ好友失败:%@\n%@",message,error);
                if (self.block) {
                    self.block(message);
                }
            }];
        }
            break;
            
            //分享到QQ空间
        case NNShareActionTypeTencentQzone:
        {
            [OpenShare shareToQQZone:content Success:^(OSMessage *message) {
                NSLog(@"分享到QQ好友成功:%@",message);
                if (self.block) {
                    self.block(message);
                }
            } Fail:^(OSMessage *message, NSError *error) {
                NSLog(@"分享到QQ好友失败:%@\n%@",message,error);
                if (self.block) {
                    self.block(nil);
                }
            }];
        }
            break;
            
            //分享到新浪微博
        case NNShareActionTypeSinaWeibo:
        {
            [OpenShare shareToWeibo:content Success:^(OSMessage *message) {
                NSLog(@"分享到sina微博成功:\%@",message);
                if (self.block) {
                    self.block(message);
                }
            } Fail:^(OSMessage *message, NSError *error) {
                NSLog(@"分享到sina微博失败:\%@\n%@",message,error);
                if (self.block) {
                    self.block(nil);
                }
            }];
        }
            break;
            
            //收藏或者取消收藏
        case NNShareActionTypeCollect:
        {
            
        }
            break;
            
            //复制
        case NNShareActionTypeCopyLine:
        {
            
        }
            break;
            
            //刷新
        case NNShareActionTypeRefresh:
        {
            
        }
            break;
            
            //举报
        case NNShareActionTypeReport:
        {
            
        }
            break;
            
            //下载图片
        case NNShareActionTypeSavePhoto:
        {
            
        }
            break;
            
            //删除
        case NNShareActionTypeDelete:
        {
            
        }
            break;
            
            //分享
        case NNShareActionTypeDefault:
        {
            
        }
            break;
            
        default:
            break;
    }
}

@end
