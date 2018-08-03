//
//  ShopCarNewListCell.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/5/14.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "ShopCarNewListCell.h"

@implementation ShopCarNewListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectClicker:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        if (self.clikerBlock) {
            self.clikerBlock(@"1");
        }
    } else {
        if (self.clikerBlock) {
            self.clikerBlock(@"-1");
        }
    }
    
}



+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 100;
}

+ (instancetype)getShopCarNewListCell {
    return [[[NSBundle mainBundle] loadNibNamed:@"ShopCarNewListCell" owner:nil options:nil] firstObject];
}

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click {
    self.clikerBlock = click;
    ShopCar *dataM = (ShopCar *)model;
    self.selectBtn.selected = dataM.isSelectedCard;
    self.xinghaoLab.text = dataM.erjimulu;
    self.typeLab.text = [NSString stringWithFormat:@"%@/%@",  dataM.zhonglei, dataM.type];
    if (dataM.height.length) {
        self.chicunLab.text = [NSString stringWithFormat:@"尺寸：%@x%@x%@",dataM.length, dataM.width, dataM.height];
    } else {
        self.chicunLab.text = [NSString stringWithFormat:@"尺寸：%@x%@",dataM.length, dataM.width];
    }
    self.jiageLab.text = [NSString stringWithFormat:@"价格：%@元", dataM.money];
    self.shuliangLab.text = [NSString stringWithFormat:@"数量：%@", dataM.productNum];
}

@end
