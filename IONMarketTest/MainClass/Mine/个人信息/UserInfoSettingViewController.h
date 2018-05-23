//
//  UserInfoSettingViewController.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/12.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    UpdateMode_name,
    UpdateMode_company,
    UpdateMode_role,
} UpdateMode;

@interface UserInfoSettingViewController : BaseViewController

@property (nonatomic, assign) UpdateMode updateMode;

@property (nonatomic, copy) void(^passValueBlock)(NSString *value);

@end
