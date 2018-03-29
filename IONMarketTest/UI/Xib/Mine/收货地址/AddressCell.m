//
//  AddressCell.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/21.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "AddressCell.h"

@implementation AddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.defalut.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)editor:(id)sender {
    if (self.click) {
        self.click(@"0");
    }
}

- (IBAction)delete:(id)sender {
    if (self.click) {
        self.click(@"1");
    }
}

- (IBAction)setDefault:(id)sender {
    if (self.click) {
        self.click(@"2");
    }
}

+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 140;
}

+ (instancetype)getAddressCell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click {
    self.click = click;
    AddressModel *dataM = (AddressModel *)model;
    self.phoneLab.text = [NSString stringWithFormat:@"%@  %@", dataM.name, dataM.phone];
//    self.cityLab.text = @"";
    self.detaiLab.text = dataM.address;
    self.defalut.selected = [dataM.moren intValue];
}

@end
