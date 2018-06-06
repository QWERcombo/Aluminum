//
//  ApplyTicketViewController.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/21.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    TicketMode_Add,
    TicketMode_Change,
} TicketMode;


@interface ApplyTicketViewController : BaseViewController
@property (nonatomic, strong) NSString *mode;
@property (nonatomic, strong) BillTicketModel *billModel;

@property (nonatomic, assign) TicketMode ticketMode;

@end
