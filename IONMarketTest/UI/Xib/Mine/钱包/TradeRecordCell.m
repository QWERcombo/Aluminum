//
//  TradeRecordCell.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/6/3.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "TradeRecordCell.h"

@implementation TradeRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 55;
}

+ (instancetype)getTradeRecordCell {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (void)loadData:(NSObject *)model delegate:(NSString *)delegate andCliker:(ClikBlock)click {
    
    WalletListModel *dataM = (WalletListModel *)model;
    
//    NSString *string = (NSString *)dele
    if ([delegate isEqualToString:@"2"]) {
        self.moneyLab.text = [NSString stringWithFormat:@"消费金额: %@", dataM.money];
    } else {
        self.moneyLab.text = [NSString stringWithFormat:@"还款金额: %@", dataM.money];
    }
    
    self.dateLab.text = [self getDateString:dataM.createDate];
}

- (NSString *)getDateString:(NSString *)string {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[string integerValue]/1000.0];
    return [formatter stringFromDate:date];
}

@end
