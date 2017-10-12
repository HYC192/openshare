//
//  NNShareContentController.m
//  NNShareKit_Example
//
//  Created by mac on 2017/10/10.
//  Copyright © 2017年 HYC192. All rights reserved.
//

#import "NNShareContentController.h"
#import "NNShareMessageObject.h"

#define YC_IS_IOS9_OR_GREATER ([[NSProcessInfo processInfo] operatingSystemVersion].majorVersion >= 9)
#define YC_IS_IOS11_OR_GREATER ([[NSProcessInfo processInfo] operatingSystemVersion].majorVersion >= 11)
@interface NNShareContentController ()
@property (nonatomic, strong) NSMutableArray *typeArr;
@end

@implementation NNShareContentController
- (instancetype)initWithObject:(NNShareMessageObject *)shareMessageObj{
    self = [super initWithActivityItems:[shareMessageObj shareMessageObjectWithActivityItems] applicationActivities:[shareMessageObj shareMessageObjectWithActivitys]];
    if (self) {
        [self _initItemsLayout];
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

#pragma mark ------------------- Privacy ----------------------
- (void)_initItemsLayout{
    NSArray *arr = @[UIActivityTypePrint,
                     UIActivityTypeCopyToPasteboard,
                     UIActivityTypeAssignToContact,
                     UIActivityTypeMessage,
                     UIActivityTypeSaveToCameraRoll,
                     UIActivityTypePostToTwitter,
                     UIActivityTypeMail,
                     UIActivityTypePostToFlickr,
                     UIActivityTypePostToFacebook,
                     UIActivityTypeAddToReadingList,
                     UIActivityTypePostToWeibo,
                     UIActivityTypePostToTencentWeibo,
#ifdef __IPHONE_11_0
                         UIActivityTypeOpenInIBooks,
#elif __IPHONE_9_0
                         UIActivityTypeMarkupAsPDF
#endif
                     ];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
