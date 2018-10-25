//
//  ConfirmOrderCell.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/10/2.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConfirmOrderCell : BaseCell

@property (weak, nonatomic) IBOutlet UILabel *xinghaoLab;
@property (weak, nonatomic) IBOutlet UILabel *guigeLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UIImageView *typeImg;



+ (instancetype)getConfirmOrderCell;
- (void)loadData:(NSObject *)model;
@end

NS_ASSUME_NONNULL_END
