//
//  OrderListModel.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/5/25.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseModel.h"

@class OrderListDetailModel;
@interface OrderListModel : BaseModel

@property (nonatomic, strong) NSString *createDate;

@property (nonatomic, strong) NSArray<OrderListDetailModel *> *detail;

@property (nonatomic, strong) NSString *no;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *totalMoney;

@property (nonatomic, strong) NSString *wuliufei;

@end

@interface OrderListDetailModel : BaseModel

@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *productNum;
@property (nonatomic, strong) NSString *zhonglei;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *length;
@property (nonatomic, strong) NSString *width;
@property (nonatomic, strong) NSString *erjimulu;
@property (nonatomic, strong) NSString *type;

@end
