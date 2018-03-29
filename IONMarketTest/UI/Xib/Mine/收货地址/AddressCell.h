//
//  AddressCell.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/21.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseCell.h"

@interface AddressCell : BaseCell

@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *cityLab;
@property (weak, nonatomic) IBOutlet UILabel *detaiLab;
@property (weak, nonatomic) IBOutlet UIButton *defalut;


@property (nonatomic, copy) ClikBlock click;

+ (instancetype)getAddressCell;

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click;

@end
