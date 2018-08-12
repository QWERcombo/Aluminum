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
    return 90;
}

+ (instancetype)getOrderDetailCell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (void)loadData:(NSObject *)model delegate:(UIViewController *)delegate andCliker:(ClikBlock)click {
    ShopCar *dataM = (ShopCar *)model;

    self.typeLab.text = dataM.erjimulu;
    self.zhongleiLab.text = [NSString stringWithFormat:@"%@/%@", dataM.zhonglei,dataM.type];
    self.priceLab.text = [NSString stringWithFormat:@"总价：%@元", [NSString pointTailTwo:dataM.money]];
    if ([dataM.height floatValue]>0) {
        self.chicunLab.text = [NSString stringWithFormat:@"规格：%@x%@x%@", dataM.length, dataM.width, dataM.height];
    } else {
        self.chicunLab.text = [NSString stringWithFormat:@"规格：%@x%@", dataM.length, dataM.width];
    }
    
    self.shuliangLab.text = [NSString stringWithFormat:@"数量：%@",dataM.productNum];
    self.contentView.backgroundColor = [UIColor redColor];
}


@end
