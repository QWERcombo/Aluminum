//
//  ShopCarNewListCell.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/5/14.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCarNewListCell : BaseCell

@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UILabel *xinghaoLab;
@property (weak, nonatomic) IBOutlet UILabel *chicunLab;
@property (weak, nonatomic) IBOutlet UILabel *jiageLab;
@property (weak, nonatomic) IBOutlet UILabel *shuliangLab;
@property (weak, nonatomic) IBOutlet UIImageView *typeImgv;


@property (nonatomic, copy) ClikBlock clikerBlock;

+ (instancetype)getShopCarNewListCell;

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click;

@end
