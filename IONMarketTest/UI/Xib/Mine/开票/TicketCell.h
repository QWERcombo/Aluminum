//
//  TicketCell.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/21.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseCell.h"

@interface TicketCell : BaseCell

@property (weak, nonatomic) IBOutlet UILabel *ticketPrice;
@property (weak, nonatomic) IBOutlet UILabel *expressPrice;
@property (weak, nonatomic) IBOutlet UILabel *orderID;
@property (weak, nonatomic) IBOutlet UIButton *orderBtn;

@property (nonatomic, copy) ClikBlock click;

+ (instancetype)getTicketCell;

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click;
@end
