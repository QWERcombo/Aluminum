//
//  TradeListViewController.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/20.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    ListType_Record,    //消费记录
    ListType_Withdraw,  //提现记录
    ListType_huankuan,  //还款记录
} ListType;

@interface TradeListViewController : BaseViewController
@property (nonatomic, assign) ListType listType;
@end
