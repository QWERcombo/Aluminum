//
//  OrderListCell.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/17.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseCell.h"

@class CustomButton;
@interface OrderListCell : BaseCell

@property (nonatomic, copy) ClikBlock clikerBlock;
@property (weak, nonatomic) IBOutlet UILabel *orderIDLabel;
@property (weak, nonatomic) IBOutlet UIButton *statusButton;
@property (weak, nonatomic) IBOutlet UILabel *productPrice;
@property (weak, nonatomic) IBOutlet UILabel *processPrice;
@property (weak, nonatomic) IBOutlet UILabel *expressPrice;
@property (weak, nonatomic) IBOutlet UILabel *zhengbanLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet CustomButton *quxiaoBtn;
@property (weak, nonatomic) IBOutlet CustomButton *zhifuBtn;
@property (weak, nonatomic) IBOutlet UIView *itemView;
@property (weak, nonatomic) IBOutlet CustomButton *caizhiBtn;


+ (instancetype)OrderListCell;

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click;

@end
