//
//  QuotationDetailCell.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/15.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "QuotationDetailCell.h"

@implementation QuotationDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 40;
}

+ (instancetype)getQuotationDetailCell {
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
    
}

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click {
    PriceModel *dataM = (PriceModel *)model;
    if ([[dataM.priceChange substringToIndex:1] isEqualToString:@"-"]) {
        self.priceLabel.textColor = [UIColor colorWithHexString:@"#D97078"];
    } else {
        self.priceLabel.textColor = [UIColor colorWithHexString:@"#A0DAA8"];
    }
    self.countLabel.text = dataM.averagePrice;
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd";
    self.dateLabel.text = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[dataM.riqi integerValue]/1000]];
}

@end
