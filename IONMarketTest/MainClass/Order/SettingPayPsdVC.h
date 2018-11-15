//
//  SettingPayPsdVC.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/10/29.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SettingPayPsdVCDelegate <NSObject>

- (void)settingPayPsdFinish;

@end

@interface SettingPayPsdVC : UITableViewController

@property (nonatomic, weak) id<SettingPayPsdVCDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
