//
//  InventoryCell.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/19.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "InventoryCell.h"

@implementation InventoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

+ (instancetype)getInventoryCell {
    return [[[NSBundle mainBundle] loadNibNamed:@"InventoryCell" owner:nil options:nil] firstObject];
}

+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 110;
}

- (void)loadData:(WholeBoardModel *)data andCliker:(ClikBlock)click {
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", data.zhonglei, data.xinghao];
    self.typeLabel.text = [NSString stringWithFormat:@"规格: %@", data.guige];
    self.infoTypeLabel.text = data.canzhaozhishu;
    self.infoLabel.text = data.gongyibiaozhun;
    NSDateFormatter *datefor = [NSDateFormatter new];
    [datefor setDateFormat:@"yyyy-MM-dd"];
    self.dateLabel.text = [datefor stringFromDate:[NSDate dateWithTimeIntervalSince1970:[data.createDate integerValue]/1000]];
}

@end
