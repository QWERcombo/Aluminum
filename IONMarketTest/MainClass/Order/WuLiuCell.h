//
//  WuLiuCell.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/8/20.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseCell.h"

@interface WuLiuCell : BaseCell
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLab;


+ (instancetype)WuLiuCell;
- (void)loadData:(NSObject *)model name:(NSString *)name andCliker:(ClikBlock)click;
@end
