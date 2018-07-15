//
//  WithdrawRecordCell.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/7/15.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "WithdrawRecordCell.h"

@implementation WithdrawRecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 150;
}

+ (instancetype)getWithdrawRecordCell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click {
    
    WalletListModel *dataM = (WalletListModel *)model;
    self.shenqingshijian.text = [self getDateString:dataM.withDrawTime];
    self.tixianjine.text = [NSString stringWithFormat:@"%@元", dataM.money];
    self.tixiankahao.text = dataM.bankNo;
    self.kaihurenxingming.text = dataM.bankName;
    self.kaihuhangmingcheng.text = dataM.bank;
    self.shenhezhuangtai.text = dataM.status;
    self.shenheyijian.text = dataM.shenheyijian;
}

- (NSString *)getDateString:(NSString *)string {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[string integerValue]/1000.0];
    return [formatter stringFromDate:date];
}

@end
