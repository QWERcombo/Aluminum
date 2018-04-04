//
//  EndTicketCell.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/21.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "EndTicketCell.h"

@implementation EndTicketCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.statusButton.titleEdgeInsets = UIEdgeInsetsMake(0, -self.statusButton.imageView.width, 0, self.statusButton.imageView.width);
    self.statusButton.imageEdgeInsets = UIEdgeInsetsMake(0, self.statusButton.titleLabel.width, 0, -self.statusButton.titleLabel.width);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)statusAc:(id)sender {
    self.click(@"2-2");
}



+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 120;
}

+ (instancetype)getEndTicketCell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click {
    self.click = click;
    
    OrderModel *dataM = (OrderModel *)model;
    self.ticketPrice.text = [NSString stringWithFormat:@"%@ 元", dataM.money];
    self.expressPrice.text = [NSString stringWithFormat:@"%@ 元", dataM.wuliufei];
//    self.ticketID.text = [NSString stringWithFormat:@""];
    
}

@end
