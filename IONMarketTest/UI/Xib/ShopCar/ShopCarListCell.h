//
//  ShopCarListCell.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/4/3.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseCell.h"

@interface ShopCarListCell : BaseCell

@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *centerLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (nonatomic, copy) ClikBlock clikerBlock;

+ (instancetype)getShopCarListCell;

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click;

@end
