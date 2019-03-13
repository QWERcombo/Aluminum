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

typedef NS_ENUM(NSUInteger, ChangeType) {
    ChangeType_None,
    ChangeType_PayPsd,
    ChangeType_LogPsd,
    ChangeType_WxBind, //绑定微信关联手机号
};

@interface SettingPayPsdVC : UITableViewController

@property (nonatomic, weak) id<SettingPayPsdVCDelegate> delegate;
@property (nonatomic, assign) ChangeType changeType;

@property (nonatomic, copy) NSString *openId;
@property (nonatomic, copy) NSString *wxName;
@property (nonatomic, copy) NSString *headImgUrl;

@end

NS_ASSUME_NONNULL_END
