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
    [self.setDefault setImage:IMG(@"select_0") forState:UIControlStateNormal];
    [self.setDefault setImage:IMG(@"select_1") forState:UIControlStateSelected];
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
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    if (button.selected) {
        [button setImage:IMG(@"select_1") forState:UIControlStateNormal];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:self];
        if (self.delegate && [self.delegate respondsToSelector:@selector(radioSelectedWithIndexPath:)]) {
            [self.delegate radioSelectedWithIndexPath:indexPath];
        }
        
    } else {
        [button setImage:IMG(@"select_0") forState:UIControlStateNormal];
    }
}

+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 120;
}


+ (instancetype)getTicketInfoCell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click {
    BaseModel *dataM = (BaseModel *)model;
    self.setDefault.selected = dataM.isSelectedCard;
    
}

@end
