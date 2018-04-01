//
//  AddressModel.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/29.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseModel.h"

@interface AddressModel : BaseModel

@property (nonatomic, strong) NSString *detailAddress;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *moren;// 0非默认  1默认
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *sheng;
@property (nonatomic, strong) NSString *shi;
@property (nonatomic, strong) NSString *qu;
@end
