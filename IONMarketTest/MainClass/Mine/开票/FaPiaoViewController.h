//
//  FaPiaoViewController.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/4/5.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseViewController.h"

@interface FaPiaoViewController : BaseViewController

@property (nonatomic, copy) void(^SelectModelBlock)(BillTicketModel *billM);

@end
