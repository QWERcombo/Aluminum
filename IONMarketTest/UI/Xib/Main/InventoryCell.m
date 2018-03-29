//
//  InventoryCell.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/19.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "InventoryCell.h"

@implementation InventoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

+ (instancetype)getInventoryCell {
    return [[[NSBundle mainBundle] loadNibNamed:@"InventoryCell" owner:nil options:nil] firstObject];
}

+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 110;
}

- (void)loadData:(NSObject *)data andCliker:(ClikBlock)click {
    
    
    
}

@end
