//
//  TaoLiaoListCell.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2019/2/22.
//  Copyright © 2019年 赵越. All rights reserved.
//

#import "TaoLiaoListCell.h"

@implementation TaoLiaoListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.showView.layer.cornerRadius = 4;
    self.showView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
