//
//  ConfirmOrderVC.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/5/16.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    FromVCType_Buy,
    FromVCType_ShopCar,
} FromVCType;

@interface ConfirmOrderVC : UIViewController
@property (nonatomic, strong) NSArray *carArr;
@property (nonatomic, assign) FromVCType fromtype;
@end
