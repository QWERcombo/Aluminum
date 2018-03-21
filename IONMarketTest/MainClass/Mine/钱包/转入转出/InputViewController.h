//
//  InputViewController.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/21.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    Mode_Input,
    Mode_Output,
} Mode_Way;

@interface InputViewController : BaseViewController

@property (nonatomic, assign) Mode_Way mode_way;

@end
