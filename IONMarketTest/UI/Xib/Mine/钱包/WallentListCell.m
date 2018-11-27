//
//  WallentListCell.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/20.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "WallentListCell.h"

@implementation WallentListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 68;
}

+ (instancetype)getWallentListCell {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click {
    
    WalletListModel *dataM = (WalletListModel *)model;
    self.orderID.text = [NSString stringWithFormat:@"订单: %@", dataM.no];
    self.dateLab.text = [self getDateString:dataM.createDate];
    self.countLab.text = dataM.money;
}

- (NSString *)getDateString:(NSString *)string {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[string integerValue]/1000.0];
    return [formatter stringFromDate:date];
}


@end
