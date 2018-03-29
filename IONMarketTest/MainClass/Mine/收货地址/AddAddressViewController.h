//
//  AddAddressViewController.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/21.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    Mode_Editor,
    Mode_Set,
} View_Mode;

@interface AddAddressViewController : BaseViewController
@property (nonatomic, strong) AddressModel *addressModel;
@property (nonatomic, assign) View_Mode mode;

@end
