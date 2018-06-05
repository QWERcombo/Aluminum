//
//  InputViewController.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/21.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    Mode_Input,     //钱包充值
    Mode_Output,    //白条还款
} Mode_Way;

@interface InputViewController : BaseViewController

@property (nonatomic, assign) Mode_Way mode_way;

@end
