//
//  SubMarktListCell.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/10/28.
//  Copyright © 2018 赵越. All rights reserved.
//

#import "BaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface SubMarktListCell : BaseCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *jiageLabel;
@property (weak, nonatomic) IBOutlet UILabel *junjiaLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhangdieLabel;

@end

NS_ASSUME_NONNULL_END
