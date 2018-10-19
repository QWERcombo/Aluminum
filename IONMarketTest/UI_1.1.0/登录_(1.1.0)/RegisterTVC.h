//
//  RegisterTVC.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/10/16.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, FromVCType) {
    FromVCType_forget,
    FromVCType_regist,
};


@interface RegisterTVC : UITableViewController

@property (nonatomic, assign) FromVCType type;

@end

NS_ASSUME_NONNULL_END
