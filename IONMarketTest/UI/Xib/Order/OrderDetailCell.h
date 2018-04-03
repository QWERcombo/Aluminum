//
//  OrderDetailCell.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/17.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseCell.h"

@interface OrderDetailCell : BaseCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;



+ (instancetype)getOrderDetailCell;

- (void)loadData:(NSObject *)model delegate:(UIViewController *)delegate andCliker:(ClikBlock)click;

@end
