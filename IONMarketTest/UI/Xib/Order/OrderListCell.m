//
//  OrderListCell.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/17.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "OrderListCell.h"

@implementation OrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 185;
}


+ (instancetype)OrderListCell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (IBAction)statusAction:(id)sender {
    _clikerBlock(((UIButton *)sender).currentTitle);
    
}

- (IBAction)buyAction:(id)sender {
     _clikerBlock(((UIButton *)sender).currentTitle);
}

- (IBAction)serviceAction:(id)sender {
     _clikerBlock(((UIButton *)sender).currentTitle);
}

- (IBAction)downloadAction:(id)sender {
     _clikerBlock(((UIButton *)sender).currentTitle);
}


- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click {
    _clikerBlock = click;
    
    
}



@end
