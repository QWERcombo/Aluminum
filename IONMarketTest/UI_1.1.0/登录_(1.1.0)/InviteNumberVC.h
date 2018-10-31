//
//  InviteNumberVC.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/10/18.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ShowType) {
    ShowType_Invite,    //推荐人
    ShowType_SetPsd,    //短信登录退出设置登陆密码
};

typedef void(^CallBackBlock)(void);

@interface InviteNumberVC : UITableViewController

@property (nonatomic, assign) ShowType showType;
@property (nonatomic, copy) CallBackBlock callBlock;

@end

NS_ASSUME_NONNULL_END
