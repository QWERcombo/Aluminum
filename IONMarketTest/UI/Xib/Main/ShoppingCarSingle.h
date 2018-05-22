//
//  ShoppingCarSingle.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/5/7.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCarSingle : NSObject

@property (nonatomic, strong) NSMutableArray *shopCarDataSource; //数据
@property (nonatomic, copy) NSNumber *totalPrice; //总价
@property (nonatomic, assign) NSInteger totalbadge; //角标

+ (ShoppingCarSingle *)sharedShoppingCarSingle;

//微信支付
- (void)beginPayUserWeixiWithOrderId:(NSString *)orderId andTotalfee:(NSString *)totalfee;



@end
