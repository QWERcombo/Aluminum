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
    return 120;
}

+ (instancetype)getOrderDetailCell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (void)loadData:(NSObject *)model delegate:(UIViewController *)delegate andCliker:(ClikBlock)click {
    ShopCar *dataM = (ShopCar *)model;

    self.typeLab.text = dataM.type;
    self.zhongleiLab.text = dataM.zhonglei;
    self.priceLab.text = [NSString stringWithFormat:@"总价：%@元", [NSString pointTailTwo:dataM.money]];
    self.chicunLab.text = [NSString stringWithFormat:@"规格：%@x%@x%@", dataM.length, dataM.width, dataM.height];
    self.shuliangLab.text = [NSString stringWithFormat:@"数量：%@",dataM.productNum];
    
}


@end
