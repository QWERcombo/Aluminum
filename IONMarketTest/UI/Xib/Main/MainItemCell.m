//
//  MainItemCell.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/12.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "MainItemCell.h"

@implementation MainItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)MainItemCell {
    return [[[NSBundle mainBundle] loadNibNamed:@"MainItemCell" owner:nil options:nil] firstObject];
}

@end
