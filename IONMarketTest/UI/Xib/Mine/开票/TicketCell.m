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


- (IBAction)expressBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    
}

- (IBAction)moreAction:(UIButton *)sender {
    if (self.click) {
        self.click(@"0");
    }
}

- (IBAction)orderBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.makeBtn.selected = YES;
        self.expressBtn.selected = YES;
        self.ticketBtn.selected = YES;
    } else {
        self.makeBtn.selected = NO;
        self.expressBtn.selected = NO;
        self.ticketBtn.selected = NO;
    }
}

- (IBAction)ticketBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    
}

- (IBAction)makeBtnAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    
}


+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 160;
}

+ (instancetype)getTicketCell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click {
    self.click = click;
    
    
    
}

@end
