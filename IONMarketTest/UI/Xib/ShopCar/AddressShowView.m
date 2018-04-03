//
//  AddressShowView.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/4/3.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "AddressShowView.h"

@implementation AddressShowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"AddressShowView" owner:nil options:nil] firstObject];
        
        self.frame = frame;
    }
    return self;
}

- (IBAction)selectClicker:(UIButton *)sender {
    if (self.clikerBlock) {
        self.clikerBlock(@"0");
    }
}



- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click {
    self.clikerBlock = click;
    AddressModel *dataM = (AddressModel *)model;
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", dataM.name, dataM.phone];
    self.cityLabel.text = [NSString stringWithFormat:@"%@ %@ %@", dataM.sheng, dataM.shi, dataM.qu];
    self.addressDLabel.text = [NSString stringWithFormat:@"%@", dataM.detailAddress];
    
}

@end
