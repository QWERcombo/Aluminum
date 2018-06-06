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
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

//删除
- (IBAction)delete:(id)sender {
    if (self.click) {
        self.click(@"0");
    }
}

//编辑
- (IBAction)editor:(id)sender {
    if (self.click) {
        self.click(@"1");
    }
}

- (IBAction)setDefault:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    if (button.selected) {
        [button setImage:IMG(@"select_1") forState:UIControlStateNormal];
    } else {
        [button setImage:IMG(@"select_0") forState:UIControlStateNormal];
    }
}

+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 170;
}


+ (instancetype)getTicketInfoCell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click {
    self.click = click;
    BillTicketModel *dataM = (BillTicketModel *)model;
    self.duigongzhanghu.text = dataM.duigongzhanghu;
    self.phoneLab.text = dataM.shoujihao;
    self.fapiaotaitou.text = dataM.kaipiaotaitou;
    self.shuihao.text = dataM.shuihao;
    
}

@end
