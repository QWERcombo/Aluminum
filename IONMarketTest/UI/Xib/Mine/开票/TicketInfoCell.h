//
//  TicketInfoCell.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/21.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseCell.h"

@interface TicketInfoCell : BaseCell

@property (weak, nonatomic) IBOutlet UILabel *bankName;
@property (weak, nonatomic) IBOutlet UILabel *comparyName;
@property (weak, nonatomic) IBOutlet UILabel *comparyID;
@property (weak, nonatomic) IBOutlet UIButton *setDefault;

@property (nonatomic, copy) ClikBlock click;

+ (instancetype)getTicketInfoCell;

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click;

@end
