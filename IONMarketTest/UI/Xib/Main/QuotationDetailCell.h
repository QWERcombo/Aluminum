//
//  QuotationDetailCell.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/15.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseCell.h"

@interface QuotationDetailCell : BaseCell

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;



+ (instancetype)getQuotationDetailCell;

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click;

@end
