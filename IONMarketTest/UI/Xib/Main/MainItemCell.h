//
//  MainItemCell.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/9.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseCell.h"

@interface MainItemCell : BaseCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *describLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftData;
@property (weak, nonatomic) IBOutlet UILabel *rightData;



- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click;

@end
