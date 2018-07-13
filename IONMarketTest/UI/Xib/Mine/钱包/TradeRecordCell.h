//
//  TradeRecordCell.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/6/3.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseCell.h"

@interface TradeRecordCell : BaseCell

@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;


+ (instancetype)getTradeRecordCell;

- (void)loadData:(NSObject *)model delegate:(NSString *)delegate andCliker:(ClikBlock)click;

@end
