//
//  TicketCell.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/21.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "TicketCell.h"

@implementation TicketCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)moreAction:(UIButton *)sender {
    if (self.click) {
        self.click(@"0");
    }
}

- (IBAction)orderBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        if (self.click) {
            self.click(@"1");
        }
    } else {
        if (self.click) {
            self.click(@"-1");
        }
    }
}


+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 122;
}

+ (instancetype)getTicketCell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click {
    self.click = click;
    OrderModel *dataM = (OrderModel *)model;
    
    self.expressPrice.text = [NSString stringWithFormat:@"%@ 元", dataM.wuliufei];
    self.ticketPrice.text = [NSString stringWithFormat:@"%@ 元", dataM.money];
    self.orderID.text = [NSString stringWithFormat:@"订单编号: %@", dataM.no];
    self.orderBtn.selected = dataM.isSelectedCard;
    
}

@end
