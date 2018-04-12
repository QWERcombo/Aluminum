//
//  ShopCarListCell.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/4/3.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "ShopCarListCell.h"

@implementation ShopCarListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 100;
}

+ (instancetype)getShopCarListCell {
    return [[[NSBundle mainBundle] loadNibNamed:@"ShopCarListCell" owner:nil options:nil] firstObject];
}

- (IBAction)selectBtn:(UIButton *)sender {
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


- (IBAction)moreClicker:(UIButton *)sender {
    if (self.clikerBlock) {
        self.clikerBlock(@"0");
    }
}



- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click {
    self.clikerBlock = click;
    ShopCar *dataM = (ShopCar *)model;
    
    [self.selectButton setTitle:dataM.zhonglei forState:UIControlStateNormal];
    self.leftLabel.text = [NSString stringWithFormat:@"%@x%@x%@\n(mm)*%@", dataM.length, dataM.width, dataM.height, dataM.productNum];
    self.centerLabel.text = @"";
    self.rightLabel.text = [NSString stringWithFormat:@"%@ 元", [NSString pointTailTwo:dataM.money]];
    self.typeLabel.text = dataM.type;
    self.selectButton.selected = dataM.isSelectedCard;
}


@end
