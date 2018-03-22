//
//  SmartServiceCell.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/22.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseCell.h"

@interface SmartServiceCell : BaseCell

@property (weak, nonatomic) IBOutlet UIImageView *leftImgv;
@property (weak, nonatomic) IBOutlet UILabel *topLab;
@property (weak, nonatomic) IBOutlet UILabel *downLab;


+ (instancetype)getSmartServiceCell;

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click;

@end
