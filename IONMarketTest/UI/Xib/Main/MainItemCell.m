//
//  MainItemCell.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/12.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "MainItemCell.h"

@implementation MainItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 64;
}

+ (instancetype)MainItemCell {
    return [[[NSBundle mainBundle] loadNibNamed:@"MainItemCell" owner:nil options:nil] firstObject];
}

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click {
    
    PriceModel *dataM = (PriceModel *)model;
    
    if ([[dataM.priceChange substringToIndex:1] isEqualToString:@"-"]) {
        self.rightCountLabel.textColor = [UIColor colorWithHexString:@"#019800"];
        self.leftCountLabel.textColor = [UIColor colorWithHexString:@"#019800"];
    } else {
        self.rightCountLabel.textColor = [UIColor colorWithHexString:@"#FF0000"];
        self.leftCountLabel.textColor = [UIColor colorWithHexString:@"#FF0000"];
    }
    self.rightCountLabel.text = dataM.priceChange;
    self.leftCountLabel.text = dataM.averagePrice;
    self.nameLabrl.text = dataM.name;
    self.descriLabel.text = dataM.source;
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd";
    self.dateLab.text = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[dataM.riqi integerValue]/1000]];
}

@end
