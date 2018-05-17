//
//  OrderDetailCell.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/17.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseCell.h"

@interface OrderDetailCell : BaseCell

@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UILabel *zhongleiLab;
@property (weak, nonatomic) IBOutlet UILabel *chicunLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *shuliangLab;


+ (instancetype)getOrderDetailCell;

- (void)loadData:(NSObject *)model delegate:(UIViewController *)delegate andCliker:(ClikBlock)click;

@end
