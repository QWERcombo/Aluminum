//
//  TicketInfoCell.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/21.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "TicketInfoCell.h"

@implementation TicketInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.setDefault.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)delete:(id)sender {
}

- (IBAction)editor:(id)sender {
}

- (IBAction)setDefault:(id)sender {
}

+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 120;
}


+ (instancetype)getTicketInfoCell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click {
    
}

@end
