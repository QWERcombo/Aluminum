//
//  MainItemCell.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/12.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseCell.h"

@interface MainItemCell : BaseCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabrl;

@property (weak, nonatomic) IBOutlet UILabel *descriLabel;

@property (weak, nonatomic) IBOutlet UILabel *leftCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *rightCountLabel;

+ (instancetype)MainItemCell;

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click;

@end
