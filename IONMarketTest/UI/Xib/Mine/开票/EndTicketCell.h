//
//  EndTicketCell.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/21.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseCell.h"

@interface EndTicketCell : BaseCell



@property (nonatomic, copy) ClikBlock click;

+ (instancetype)getEndTicketCell;

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click;
@end
