//
//  NSString+NNImagePath.h
//  openshare
//
//  Created by mac on 2017/10/12.
//  Copyright © 2017年 OpenShare http://openshare.gfzj.us/. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (NNImagePath)
+ (instancetype)nn_shareKitPath;
+ (UIImage *)nn_getImageWithName:(NSString *)image;
@end
