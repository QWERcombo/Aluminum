//
//  WholeBoardVC.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/10/18.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, WholeBoardShowType) {
    WholeBoardShowType_Zhengban,        //整板
    WholeBoardShowType_BanChengPin,     //半成品
    WholeBoardShowType_YueBao,          //约包
};

@interface WholeBoardVC : UIViewController

@property (nonatomic, assign) WholeBoardShowType showTye;

@end

NS_ASSUME_NONNULL_END
