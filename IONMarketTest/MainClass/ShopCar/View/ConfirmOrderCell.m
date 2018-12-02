//
//  ConfirmOrderCell.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/10/2.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "ConfirmOrderCell.h"

@implementation ConfirmOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 72;
}

+ (instancetype)getConfirmOrderCell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}


- (void)loadData:(NSObject *)model {
    
    if ([model isKindOfClass:[ShopCar class]]) {
        ShopCar *dataM = (ShopCar *)model;
        
        self.moneyLab.text = [NSString stringWithFormat:@"%@元", [NSString getStringAfterTwo:dataM.money]];
        if ([dataM.height floatValue]>0) {
            if ([dataM.zhonglei isEqualToString:@"整板"]) {
                self.guigeLab.text = [NSString stringWithFormat:@"%@x%@x%@",dataM.height, dataM.width, dataM.length];
            } else {
                self.guigeLab.text = [NSString stringWithFormat:@"%@x%@x%@",dataM.length, dataM.width, dataM.height];
            }
        } else {
            self.guigeLab.text = [NSString stringWithFormat:@"规格：%@x%@", dataM.length, dataM.width];
        }
        self.countLab.text = [NSString stringWithFormat:@"共%@件",dataM.productNum];
        self.xinghaoLab.text = dataM.erjimulu;
        
        if ([dataM.type isEqualToString:@"整只"]) {
            self.typeImg.image = IMG(@"order_整板");
        } else if ([dataM.type isEqualToString:@"快速"]) {
            self.typeImg.image = IMG(@"order_速切");
        } else {
            self.typeImg.image = IMG(@"order_优切");
        }
    } else if ([model isKindOfClass:[OrderListDetailModel class]]) {
        
        OrderListDetailModel *dataM = (OrderListDetailModel *)model;
        self.moneyLab.text = [NSString stringWithFormat:@"%@元", [NSString getStringAfterTwo:dataM.money]];
        if ([dataM.height floatValue]>0) {
            if ([dataM.zhonglei isEqualToString:@"整板"]) {
                self.guigeLab.text = [NSString stringWithFormat:@"%@x%@x%@",dataM.height, dataM.width, dataM.length];
            } else {
                self.guigeLab.text = [NSString stringWithFormat:@"%@x%@x%@",dataM.length, dataM.width, dataM.height];
            }
        } else {
            self.guigeLab.text = [NSString stringWithFormat:@"规格：%@x%@", dataM.length, dataM.width];
        }
        self.countLab.text = [NSString stringWithFormat:@"共%@件",dataM.productNum];
        self.xinghaoLab.text = dataM.erjimulu;
        
        if ([dataM.type isEqualToString:@"整只"]) {
            self.typeImg.image = IMG(@"order_整板");
        } else if ([dataM.type isEqualToString:@"快速"]) {
            self.typeImg.image = IMG(@"order_速切");
        } else {
            self.typeImg.image = IMG(@"order_优切");
        }
    } else {
        
    }
    
    
    
}

@end
