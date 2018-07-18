//
//  OrderListCell.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/17.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "OrderListCell.h"
#import "CALayer+Addition.h"
#import "OrderListItemView.h"

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
    
    NSString *count = (NSString *)model;
    return 106+[count integerValue]*40;
}

+ (instancetype)OrderListCell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
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

- (IBAction)cancelAction:(UIButton *)sender {
    if (_clikerBlock) {
        _clikerBlock(((UIButton *)sender).currentTitle);
    }
}


- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click {
    _clikerBlock = click;
    OrderListModel *dataM = (OrderListModel *)model;
    
    self.orderIDLabel.text = [NSString stringWithFormat:@"订单编号: %@", dataM.no];
    self.expressPrice.text = [NSString stringWithFormat:@"物流费: %@元", dataM.wuliufei];
    self.productPrice.text = [NSString stringWithFormat:@"产品费: %@", [NSString getStringAfterTwo:dataM.totalMoney]];
    
    switch ([dataM.status integerValue]) {
        case 0:
            [self.statusButton setTitle:@"待付款" forState:UIControlStateNormal];            
            break;
        case 1:
            [self.statusButton setTitle:@"待收货" forState:UIControlStateNormal];
            [self.zhifuBtn setTitle:@"  确认收货  " forState:UIControlStateNormal];
            [self.quxiaoBtn setTitle:@"  材质证明  " forState:UIControlStateNormal];
            self.caizhiBtn.hidden = YES;
            break;
        case 2:
            [self.statusButton setTitle:@"已完成" forState:UIControlStateNormal];
            [self.zhifuBtn setTitle:@"  材质证明  " forState:UIControlStateNormal];
            self.caizhiBtn.hidden = YES;
            self.quxiaoBtn.hidden = YES;
            
            break;
        default:
            break;
    }
    
    for (NSInteger i=0; i<dataM.detail.count; i++) {
        OrderListItemView *label = [[OrderListItemView alloc] initWithFrame:CGRectMake(0, 40*i, SCREEN_WIGHT, 40)];
        [label loadData:[dataM.detail objectAtIndex:i]];
        label.backgroundColor = [UIColor purpleColor];
        [self.itemView addSubview:label];
    }
    
}

@end
