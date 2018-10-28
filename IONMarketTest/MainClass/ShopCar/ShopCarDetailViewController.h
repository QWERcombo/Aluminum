//
//  ShopCarDetailViewController.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/20.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSUInteger, OrderDetailType) {
    OrderDetailType_WillPay,    //代付款
    OrderDetailType_Payed,      //已付款
    OrderDetailType_Completed,  //完成
    OrderDetailType_Revoked     //过期
};



@interface ShopCarDetailViewController : BaseViewController
@property (nonatomic, strong) NSArray *shopCarArr;
@property (nonatomic, assign) OrderDetailType orderDetailType;
@end
