//
//  NNShareContentController.m
//  NNShareKit_Example
//
//  Created by mac on 2017/10/10.
//  Copyright © 2017年 HYC192. All rights reserved.
//

#import "NNShareContentController.h"
#import "NSString+NNValid.h"
#import "NNShareMessageObject.h"

#import "NNWechatSessionShare.h"
#import "NNWechatTimelineShare.h"
#import "NNWeiboShare.h"
#import "NNTencentQQShare.h"
#import "NNTencentSpaceShare.h"
#import "NNChatShare.h"

#import "NNSavePhoto.h"
#import "NNCopyLink.h"
#import "NNCollectShare.h"
#import "NNCancelCollect.h"
#import "NNReportShare.h"
#import "NNRefreshShare.h"
#import "NNDeleteShare.h"

#import "NNShareKit.h"
#import "OpenShare.h"

#define YC_IS_IOS9_OR_GREATER ([[NSProcessInfo processInfo] operatingSystemVersion].majorVersion >= 9)
#define YC_IS_IOS11_OR_GREATER ([[NSProcessInfo processInfo] operatingSystemVersion].majorVersion >= 11)
#define redict_url @"https://app.nainnain99.com"
@interface NNShareContentController ()
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSMutableArray *typeArr;
@property (nonatomic, strong) OSMessage *shareMessage;
@end

@implementation NNShareContentController

- (instancetype)initWithObject:(NNShareMessageObject *)shareMessageObj
                          type:(NNShowShareType)type delegate:(nullable id<NNShareKitDelegate>)delegate shareContentType:(NNShareContentType)shareType{
    self = [super initWithActivityItems:[shareMessageObj shareMessageObjectWithActivityItems] applicationActivities:[self getActivityArray:[shareMessageObj shareMessageObjectWithActivitys] type:type]];
    if (self) {
        _type = type;
        _shareType = shareType;
        _delegate = delegate;
        _content = shareMessageObj.content;
        [self _initItemsLayout];
        [self _initShareContent:shareMessageObj];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Accessor
- (void)setShowAirDrop:(BOOL)showAirDrop{
    _showAirDrop = showAirDrop;
    if (!_showAirDrop) {
        [self.typeArr addObject:UIActivityTypeAirDrop];
        //隐藏airdrop
        [self extendItemsWithRefresh];
    }
}

- (NSMutableArray *)typeArr{
    if (_typeArr == nil) {
        _typeArr = [[NSMutableArray alloc] init];
    }
    return _typeArr;
}

- (NSArray *)getActivityArray:(NSArray *)others type:(NNShowShareType)type{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    //是否安装微信
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"wechat://"]]) {
        NNWechatSessionShare *wechat = [[NNWechatSessionShare alloc] init];
        wechat.performActivityBlock = ^{
            [self clickedShareAction:NNShareActionTypeWeChatSession];
        };
        [arr addObject:wechat];
        
        NNWechatTimelineShare *wechatTime = [[NNWechatTimelineShare alloc] init];
        wechatTime.performActivityBlock = ^{
            [self clickedShareAction:NNShareActionTypeWeChatTimeline];
        };
        [arr addObject:wechatTime];
    }
    
    //是否安装QQ
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
        NNTencentQQShare *tencentQQ = [[NNTencentQQShare alloc] init];
        tencentQQ.performActivityBlock = ^{
            [self clickedShareAction:NNShareActionTypeTencentQQ];
        };
        [arr addObject:tencentQQ];
        
        NNTencentSpaceShare *tencentSpace = [[NNTencentSpaceShare alloc] init];
        tencentSpace.performActivityBlock = ^{
            [self clickedShareAction:NNShareActionTypeTencentQzone];
        };
        [arr addObject:tencentSpace];
    }
    
    //是否安装新浪微博
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"Sinaweibo://"]]) {
        NNWeiboShare *sinaWibo = [[NNWeiboShare alloc] init];
        [arr addObject:sinaWibo];
        sinaWibo.performActivityBlock = ^{
            [self clickedShareAction:NNShareActionTypeSinaWeibo];
        };
    }
    
    //添加留言室分享Action
    NNChatShare *chatShare = [[NNChatShare alloc] init];
    chatShare.performActivityBlock = ^{
        [self clickedShareAction:NNShareActionTypeNNLetterChat];
    };
    [arr addObject:chatShare];
    
    //保存到手机Action
    NNSavePhoto *savePhoto = [[NNSavePhoto alloc] init];
    savePhoto.performActivityBlock = ^{
        [self clickedShareAction:NNShareActionTypeSavePhoto];
    };
    
    //复制链接Action
    NNCopyLink *copyLink = [[NNCopyLink alloc] init];
    copyLink.performActivityBlock = ^{
        [self clickedShareAction:NNShareActionTypeCopyLine];
    };
    
    //收藏
    NNCollectShare *collect = [[NNCollectShare alloc] init];
    collect.performActivityBlock = ^{
        [self clickedShareAction:NNShareActionTypeCollect];
    };
    
    //取消收藏
    NNCancelCollect *cancelCollect = [[NNCancelCollect alloc] init];
    cancelCollect.performActivityBlock = ^{
        [self clickedShareAction:NNShareActionTypeCancelCollect];
    };
    
    //举报
    NNReportShare *report = [[NNReportShare alloc] init];
    report.performActivityBlock = ^{
        [self clickedShareAction:NNShareActionTypeReport];
    };
    
    //刷新
    NNRefreshShare *refresh = [[NNRefreshShare alloc] init];
    refresh.performActivityBlock = ^{
        [self clickedShareAction:NNShareActionTypeRefresh];
    };
    
    //删除
    NNDeleteShare *delete = [[NNDeleteShare alloc] init];
    delete.performActivityBlock = ^{
        [self clickedShareAction:NNShareActionTypeDelete];
    };
    
    [arr addObject:copyLink];
    [arr addObject:report];
    [arr addObject:refresh];
    
    switch (type) {
        case NNShowShareTypeWithoutChatRoom:
        {
            [arr removeObject:chatShare];
        }
            break;
            
        case NNShowShareTypeWithCollect:
        {
            [arr removeObject:copyLink];
            [arr removeObject:report];
            [arr removeObject:refresh];
            
            [arr addObject:collect];
            [arr addObject:copyLink];
            [arr addObject:report];
            [arr addObject:refresh];
        }
            break;
            
            //取消收藏
        case NNShowShareTypeCancelCollect:
        {
            [arr removeObject:copyLink];
            [arr removeObject:report];
            [arr removeObject:refresh];
            
            [arr addObject:cancelCollect];
            [arr addObject:copyLink];
            [arr addObject:report];
            [arr addObject:refresh];
        }
            break;
            
        case NNShowShareTypeWithoutRefresh:
        {
            [arr removeObject:refresh];
        }
            break;
            
        case (NNShowShareTypeWithCollect | NNShowShareTypeWithDelete):
        {
            
            [arr removeObject:copyLink];
            [arr removeObject:report];
            [arr removeObject:refresh];
            
            [arr addObject:collect];
            [arr addObject:copyLink];
            [arr addObject:refresh];
            [arr addObject:delete];
        }
            break;
            
        case(NNShowShareTypeCancelCollect | NNShowShareTypeWithDelete):
        {
            [arr removeObject:copyLink];
            [arr removeObject:report];
            [arr removeObject:refresh];
            
            [arr addObject:cancelCollect];
            [arr addObject:copyLink];
            [arr addObject:refresh];
            [arr addObject:delete];
        }
            break;
            
        case NNShowShareTypeWithoutReport:
        {
            [arr removeObject:report];
        }
            break;
            
        case NNShowShareTypeWithSavephoto:{
            [arr removeObject:copyLink];
            [arr removeObject:report];
            [arr removeObject:refresh];
            
            [arr addObject:savePhoto];
        }
            break;
            
        case NNShowShareTypeDefault:
        default:
        {
            
        }
            break;
    }
    
    if (others && others.count > 0) {
        [arr addObjectsFromArray:others];
    }
    
    return arr;
}

#pragma mark - Action
//分享到留言室
- (void)clickedShareAction:(NNShareActionType)actionType{
    if ([self.delegate respondsToSelector:@selector(nn_shareMessageAction:shareMessage:)]) {
        [self.delegate nn_shareMessageAction:actionType shareMessage:self.shareMessage];
    }
}

#pragma mark ------------------- Privacy ----------------------
- (void)_initItemsLayout{
    NSArray *arr = nil;
    if (@available(iOS 11.0, *)) {
        arr = @[UIActivityTypePrint,
                UIActivityTypeCopyToPasteboard,
                UIActivityTypeAssignToContact,
                UIActivityTypeMessage,
                UIActivityTypeSaveToCameraRoll,
                UIActivityTypePostToTwitter,
                UIActivityTypeMail,
                UIActivityTypePostToVimeo,
                UIActivityTypePostToFlickr,
                UIActivityTypePostToFacebook,
                UIActivityTypeAddToReadingList,
                UIActivityTypePostToWeibo,
                UIActivityTypePostToTencentWeibo,
                UIActivityTypeMarkupAsPDF,
                ];
    }
    else if(YC_IS_IOS9_OR_GREATER)
    {
        arr = @[UIActivityTypePrint,
                UIActivityTypeCopyToPasteboard,
                UIActivityTypeAssignToContact,
                UIActivityTypeMessage,
                UIActivityTypeSaveToCameraRoll,
                UIActivityTypePostToTwitter,
                UIActivityTypeMail,
                UIActivityTypePostToVimeo,
                UIActivityTypePostToFlickr,
                UIActivityTypePostToFacebook,
                UIActivityTypeAddToReadingList,
                UIActivityTypePostToWeibo,
                UIActivityTypePostToTencentWeibo,
                UIActivityTypeOpenInIBooks,
                ];
    }
    else
    {
        arr = @[UIActivityTypePrint,
                UIActivityTypeCopyToPasteboard,
                UIActivityTypeAssignToContact,
                UIActivityTypeMessage,
                UIActivityTypeSaveToCameraRoll,
                UIActivityTypePostToTwitter,
                UIActivityTypeMail,
                UIActivityTypePostToVimeo,
                UIActivityTypePostToFlickr,
                UIActivityTypePostToFacebook,
                UIActivityTypeAddToReadingList,
                UIActivityTypePostToWeibo,
                UIActivityTypePostToTencentWeibo,
                ];
    }
    
    [self.typeArr addObjectsFromArray:arr];
    //刷新多余控件
    [self extendItemsWithRefresh];
    
}

///移除不需要的item
- (void)extendItemsWithRefresh{
    if (self.typeArr && self.typeArr.count > 0) {
        self.excludedActivityTypes = self.typeArr;
    }
}

//获取分享数据
- (void)_initShareContent:(NNShareMessageObject *)obj{
    _shareMessage = [[OSMessage alloc] init];
    _shareMessage.title = @"念享";
    if (![NSString nn_vaildEmptyStringWithoutSpace:obj.title]) {
        _shareMessage.title = obj.title;
    }
    switch (self.shareType) {
            //分享图片
        case NNShareContentTypePhoto:
        {
            if (obj.image) {
                _shareMessage.image = obj.image;
            }
            else
            {
                _shareMessage.image = [NSBundle nn_getImageWithName:@"share_default_image"];
            }
        }
            break;
            //分享链接
        case NNShareContentTypeURL:
        {
            NSString *url = obj.url.absoluteString;
            
            if (![NSString nn_vaildEmptyStringWithoutSpace:url]) {
                _shareMessage.link = url;
            }
            else
            {
                _shareMessage.link = redict_url;
            }
            
            
            if (![NSString nn_vaildEmptyStringWithoutSpace:obj.content]) {
                _shareMessage.desc = obj.content;
            }
            
            if (obj.image) {
                _shareMessage.image = obj.image;
            }
            else
            {
                _shareMessage.image = [NSBundle nn_getImageWithName:@"share_default_image"];
                _shareMessage.thumbnail = [NSBundle nn_getImageWithName:@"share_default_image"];
            }
        }
            break;
            
            //分享文字
        case NNShareContentTypeText:
        default:
        {
            if (![NSString nn_vaildEmptyStringWithoutSpace:obj.content]) {
                _shareMessage.desc = obj.content;
            }
        }
            break;
    }
    
    if (![NSString nn_vaildEmptyStringWithoutSpace:obj.extInfo]) {
        _shareMessage.extInfo = obj.extInfo;
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
