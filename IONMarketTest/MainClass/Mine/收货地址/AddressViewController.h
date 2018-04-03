//
//  AddressViewController.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/14.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseViewController.h"

@interface AddressViewController : BaseViewController

@property (nonatomic, copy) void(^SelectAddressBlock)(AddressModel *address);

@end
