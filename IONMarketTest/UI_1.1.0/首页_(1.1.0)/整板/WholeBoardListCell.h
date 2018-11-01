//
//  WholeBoardListCell.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/10/19.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface WholeBoardListCell : BaseCell

@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet UILabel *guigeLabel;
@property (weak, nonatomic) IBOutlet UILabel *changjiaLabel;
@property (weak, nonatomic) IBOutlet UILabel *danjiaLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *kucunLabel;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet HYStepper *stepper;

@end

NS_ASSUME_NONNULL_END
