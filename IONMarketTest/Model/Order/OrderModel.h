//
//  OrderModel.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/4/2.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseModel.h"

@interface OrderModel : BaseModel

@property (nonatomic, strong) NSString *userPhone;

@property (nonatomic, strong) NSString *width;

@property (nonatomic, strong) NSString *zhonglei;

@property (nonatomic, strong) NSString *wuliufei;

@property (nonatomic, strong) NSString *erjimulu;

@property (nonatomic, strong) NSString *height;

@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) NSString *kaipiaoStatus;

@property (nonatomic, strong) NSString *length;

@property (nonatomic, strong) NSString *money;

@property (nonatomic, strong) NSString *status; //0未支付   1已支付

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSString *productNum;

@property (nonatomic, strong) NSString *no;

@property (nonatomic, strong) NSString *createDate;

@property (nonatomic, strong) NSDictionary *currentAddress;

@property (nonatomic, strong) NSString *paymethod;

@property (nonatomic, strong) NSString *payTime;

@property (nonatomic, strong) NSString *address;

@end
