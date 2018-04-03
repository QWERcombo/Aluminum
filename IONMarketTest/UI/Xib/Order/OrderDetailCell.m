//
//  OrderDetailCell.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/17.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "OrderDetailCell.h"

@implementation OrderDetailCell

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

+ (instancetype)getOrderDetailCell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (void)loadData:(NSObject *)model delegate:(UIViewController *)delegate andCliker:(ClikBlock)click {
    ShopCar *dataM = (ShopCar *)model;
//    if ([delegate isKindOfClass:[]]) {
//
//    } else {
//
//    }
    self.nameLabel.text = dataM.type;
    self.countLabel.text = [NSString stringWithFormat:@"%@x%@x%@(mm)\n *%@", dataM.length, dataM.width, dataM.height, dataM.productNum];
    self.priceLabel.text = [NSString stringWithFormat:@"%@元", dataM.money];
    
}


@end
