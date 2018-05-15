//
//  OrderListCell.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/17.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "OrderListCell.h"
#import "CALayer+Addition.h"
@implementation OrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.statusButton.titleEdgeInsets = UIEdgeInsetsMake(0, -self.statusButton.imageView.width, 0, self.statusButton.imageView.width);
    self.statusButton.imageEdgeInsets = UIEdgeInsetsMake(0, self.statusButton.titleLabel.width, 0, -self.statusButton.titleLabel.width);
    
    self.caizhiBtn.layer.borderWidth = 1;
    self.caizhiBtn.layer.borderColor = [UIColor mianColor:2].CGColor;
    self.caizhiBtn.layer.cornerRadius = 5;
    self.caizhiBtn.layer.masksToBounds = YES;
    self.quxiaoBtn.layer.borderWidth = 1;
    self.quxiaoBtn.layer.borderColor = [UIColor mianColor:2].CGColor;
    self.quxiaoBtn.layer.cornerRadius = 5;
    self.quxiaoBtn.layer.masksToBounds = YES;
    self.zhifuBtn.layer.borderWidth = 1;
    self.zhifuBtn.layer.borderColor = [UIColor mianColor:2].CGColor;
    self.zhifuBtn.layer.cornerRadius = 5;
    self.zhifuBtn.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 145;
}

+ (instancetype)OrderListCell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (IBAction)statusAction:(id)sender {
    if (_clikerBlock) {
        
    }
    _clikerBlock(((UIButton *)sender).currentTitle);
}

- (IBAction)buyAction:(id)sender {
    if (_clikerBlock) {
        _clikerBlock(((UIButton *)sender).currentTitle);
    }
}

- (IBAction)serviceAction:(id)sender {
    if (_clikerBlock) {
        _clikerBlock(((UIButton *)sender).currentTitle);
    }
}

- (IBAction)downloadAction:(id)sender {
    if (_clikerBlock) {
        _clikerBlock(((UIButton *)sender).currentTitle);
    }
}
- (IBAction)cancelAction:(UIButton *)sender {
    if (_clikerBlock) {
        _clikerBlock(((UIButton *)sender).currentTitle);
    }
}


- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click {
    _clikerBlock = click;
    OrderModel *dataM = (OrderModel *)model;
    
    self.orderIDLabel.text = [NSString stringWithFormat:@"订单编号: %@", dataM.no];
    if ([dataM.status integerValue] == 0) {
        [self.statusButton setTitle:@"待付款" forState:UIControlStateNormal];
    } else {
        [self.statusButton setTitle:@"已付款" forState:UIControlStateNormal];
    }
    self.productPrice.text = [NSString stringWithFormat:@"产品: %@元", dataM.money];
    self.expressPrice.text = [NSString stringWithFormat:@"物流费: %@元", dataM.wuliufei];
    
    self.zhengbanLabel.text = [NSString stringWithFormat:@"%@(%@)*%@", dataM.zhonglei, dataM.type, dataM.productNum];
    self.totalPrice.text = [NSString stringWithFormat:@"%@元", dataM.money];
    
}

@end
