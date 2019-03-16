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
    return 72;
}

+ (instancetype)getShopCarNewListCell {
    return [[[NSBundle mainBundle] loadNibNamed:@"ShopCarNewListCell" owner:nil options:nil] firstObject];
}

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click {
    self.clikerBlock = click;
    ShopCar *dataM = (ShopCar *)model;
    self.selectBtn.selected = dataM.isSelectedCard;
    self.xinghaoLab.text = dataM.erjimulu;
    if ([dataM.type isEqualToString:@"整只"]) {
        self.typeImgv.image = IMG(@"order_整板");
    } else if ([dataM.type isEqualToString:@"快速"]) {
        self.typeImgv.image = IMG(@"order_速切");
    } else {
        self.typeImgv.image = IMG(@"order_优切");
    }
    if (dataM.height.length) {
        self.chicunLab.text = [NSString stringWithFormat:@"%@x%@x%@",dataM.height, dataM.width, dataM.length];
    } else {
        self.chicunLab.text = [NSString stringWithFormat:@"%@x%@",dataM.width, dataM.length];
    }
    self.jiageLab.text = [NSString stringWithFormat:@"%@元", [NSString getStringAfterTwo:dataM.money]];
    self.shuliangLab.text = [NSString stringWithFormat:@"%@件", dataM.productNum];
}

@end
