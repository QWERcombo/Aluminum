//
//  EndTicketCell.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/21.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseCell.h"

@interface EndTicketCell : BaseCell

@property (weak, nonatomic) IBOutlet UILabel *ticketID;
@property (weak, nonatomic) IBOutlet UIButton *statusButton;
@property (weak, nonatomic) IBOutlet UILabel *ticketPrice;
@property (weak, nonatomic) IBOutlet UILabel *expressPrice;
@property (weak, nonatomic) IBOutlet UILabel *makePrice;


@property (nonatomic, copy) ClikBlock click;

+ (instancetype)getEndTicketCell;

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click;
@end
