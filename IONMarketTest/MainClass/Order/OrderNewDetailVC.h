//
//  OrderNewDetailVC.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/5/15.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, OrderDetailType) {
    OrderDetailType_WillPay,    //代付款
    OrderDetailType_Ziti,       //自提
    OrderDetailType_WillSend,   //未发货
    OrderDetailType_Sended      //已发货
};

@interface OrderNewDetailVC : UITableViewController
@property (nonatomic, strong) NSString *orderid;
@property (nonatomic, strong) OrderListModel *listModel;
@property (nonatomic, assign) OrderDetailType orderDetailType;
@end
