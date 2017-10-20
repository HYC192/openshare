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
    [arr addObject:savePhoto];
    
    //复制链接Action
    NNCopyLink *copyLink = [[NNCopyLink alloc] init];
    copyLink.performActivityBlock = ^{
        [self clickedShareAction:NNShareActionTypeCopyLine];
    };
    [arr addObject:copyLink];
    
    //收藏
    NNCollectShare *collect = [[NNCollectShare alloc] init];
    collect.performActivityBlock = ^{
        [self clickedShareAction:NNShareActionTypeCollect];
    };
    [arr addObject:collect];
    
    //举报
    NNReportShare *report = [[NNReportShare alloc] init];
    report.performActivityBlock = ^{
        [self clickedShareAction:NNShareActionTypeReport];
    };
    [arr addObject:report];
    
    //刷新
    NNRefreshShare *refresh = [[NNRefreshShare alloc] init];
    refresh.performActivityBlock = ^{
        [self clickedShareAction:NNShareActionTypeRefresh];
    };
    [arr addObject:refresh];
    
    switch (type) {
        case NNShowShareTypeWithoutChatRoom:
        {
            [arr removeObject:chatShare];
        }
            break;
            
        case NNShowShareTypeWithoutCollect:
        {
            [arr removeObject:collect];
        }
            break;
            
        case NNShowShareTypeWithoutRefresh:
        {
            [arr removeObject:refresh];
        }
            break;
            
        case NNShowShareTypeWithDelete:
        {
            //删除
            NNDeleteShare *delete = [[NNDeleteShare alloc] init];
            delete.performActivityBlock = ^{
                [self clickedShareAction:NNShareActionTypeDelete];
            };
            [arr addObject:delete];
        }
            break;
            
            //取消收藏
        case NNShowShareTypeCancelCollect:
        {
            NSInteger index = [arr indexOfObject:collect];
            [arr removeObject:collect];
            
            NNCollectShare *replace = [[NNCollectShare alloc] initWithTitle:@"取消收藏" image:[NSBundle nn_getImageWithName:@"icon_share_cancelcollect"] url:nil];
            replace.performActivityBlock = ^{
                [self clickedShareAction:NNShareActionTypeCollect];
            };
            [arr insertObject:replace atIndex:index];
        }
            break;
            
        case(NNShowShareTypeWithoutCollect | NNShowShareTypeWithoutChatRoom):
        {
            [arr removeObject:chatShare];
            [arr removeObject:collect];
        }
            break;
            
        case NNShowShareTypeDefault:
        default:
        {
            [arr removeObject:collect];
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
            _shareMessage.title = @"念享";
            if (![NSString nn_vaildEmptyStringWithoutSpace:obj.title]) {
                _shareMessage.title = obj.title;
            }
            
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
            _shareMessage.title = @"念享";
            if (![NSString nn_vaildEmptyStringWithoutSpace:obj.title]) {
                _shareMessage.title = obj.title;
            }
            
            if (![NSString nn_vaildEmptyStringWithoutSpace:obj.content]) {
                _shareMessage.desc = obj.content;
            }
        }
            break;
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
