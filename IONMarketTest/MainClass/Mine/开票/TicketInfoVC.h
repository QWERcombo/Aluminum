//
//  TicketInfoVC.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/6/6.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TicketInfoVC : UITableViewController

@property (nonatomic, copy) void(^PassBillModel)(BillTicketModel *billModel);

@end
