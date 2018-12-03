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

@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSArray<OrderListDetailModel *> *detail;
@property (nonatomic, copy) NSString *no;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *totalMoney;
@property (nonatomic, copy) NSString *wuliufei;

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
