//
//  BankCardCell.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/21.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseCell.h"

@interface BankCardCell : BaseCell

@property (weak, nonatomic) IBOutlet UILabel *bankID;
@property (weak, nonatomic) IBOutlet UILabel *bankName;
@property (weak, nonatomic) IBOutlet UILabel *bankType;
@property (weak, nonatomic) IBOutlet UIImageView *bankImgv;


+ (instancetype)getBankCardCell;

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click;

@end
