//
//  WallentListCell.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/20.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseCell.h"

@interface WallentListCell : BaseCell

@property (weak, nonatomic) IBOutlet UILabel *orderID;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;


+ (instancetype)getWallentListCell;

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click;
@end
