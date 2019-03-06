//
//  ShopCar.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/27.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseModel.h"

@interface ShopCar : BaseModel

@property (nonatomic, copy) NSString *createDate;

@property (nonatomic, copy) NSString *deleted;

@property (nonatomic, copy) NSString *height;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *length;

@property (nonatomic, copy) NSString *money;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *productNum;

@property (nonatomic, copy) NSString *width;

@property (nonatomic, copy) NSString *userPhone;

@property (nonatomic, copy) NSString *erjimulu;

@property (nonatomic, copy) NSString *zhonglei;
@property (nonatomic, copy) NSString *ziti;//自提
@property (nonatomic, copy) NSString *logisticsNo;//快递单号
@property (nonatomic, copy) NSString *logisticsName;//快递名称
@property (nonatomic, copy) NSString *zongzhongliang;//重量
@property (nonatomic, copy) NSString *zhuangtai;//状态

@end
