//
//  NNShareContentController.h
//  NNShareKit_Example
//
//  Created by mac on 2017/10/10.
//  Copyright © 2017年 HYC192. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNShareMessageObject.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, NNShowShareType) {
    ///默认界面类型
    NNShowShareTypeDefault = 0,
    ///无留言室界面类型
    NNShowShareTypeWithoutChatRoom = 1 << 0,
    ///无收藏界面类型
    NNShowShareTypeWithCollect  = 1 << 1,
    ///无刷新界面类型
    NNShowShareTypeWithoutRefresh  = 1 << 2,
    ///取消收藏界面类型
    NNShowShareTypeCancelCollect = 1 << 3,
    ///有删除界面类型
    NNShowShareTypeWithDelete = 1 << 4,
    ///无举报
    NNShowShareTypeWithoutReport = 1 << 5,
    //保存到手机相册
    NNShowShareTypeWithSavephoto = 1 << 6,
};

//点击分享类型
typedef NS_ENUM(NSInteger, NNShareActionType) {
    ///点击分享
    NNShareActionTypeDefault = 0,
    ///分享到微信
    NNShareActionTypeWeChatSession,
    ///分享到微信朋友圈
    NNShareActionTypeWeChatTimeline,
    ///分享到腾讯qq
    NNShareActionTypeTencentQQ,
    ///分享到腾讯qq空间
    NNShareActionTypeTencentQzone,
    ///分享到新浪微博
    NNShareActionTypeSinaWeibo,
    ///分享到念念留言室
    NNShareActionTypeNNLetterChat,
    
    ///点击复制链接
    NNShareActionTypeSavePhoto,
    ///点击复制链接
    NNShareActionTypeCopyLine,
    ///点击收藏
    NNShareActionTypeCollect,
    ///点击举报
    NNShareActionTypeReport,
    ///点击刷新
    NNShareActionTypeRefresh,
    ///点击删除
    NNShareActionTypeDelete,
    ///取消收藏
    NNShareActionTypeCancelCollect
};

@class NNShareMessageObject;
@class OSMessage;
@protocol NNShareKitDelegate <NSObject>
- (void)nn_shareMessageAction:(NNShareActionType)actionType shareMessage:(OSMessage *_Nullable)message;
@end

@interface NNShareContentController : UIActivityViewController
/**
 初始化
 
 @param shareMessageObj 消息体
 @param type 分享类型，有无特定界面
 @param delegate 代理方法
 @return 实例化
 */
- (instancetype)initWithObject:(NNShareMessageObject *)shareMessageObj
                          type:(NNShowShareType)type
                      delegate:(nullable id<NNShareKitDelegate>)delegate
              shareContentType:(NNShareContentType)shareType;
;

@property (nullable, nonatomic, assign) id <NNShareKitDelegate> delegate;

/**
 显示类型
 */
@property (nonatomic, assign, readonly) NNShowShareType type;

/**
 分享类型
 */
@property (nonatomic, assign, readonly) NNShareContentType shareType;

/**
 是否显示Airdrop
 */
@property (nonatomic, getter=isShowAirDrop) BOOL showAirDrop;
@end
NS_ASSUME_NONNULL_END


