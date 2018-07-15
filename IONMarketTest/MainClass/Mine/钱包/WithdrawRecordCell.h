//
//  WithdrawRecordCell.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/7/15.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WithdrawRecordCell : BaseCell

@property (weak, nonatomic) IBOutlet UILabel *shenqingshijian;
@property (weak, nonatomic) IBOutlet UILabel *tixianjine;
@property (weak, nonatomic) IBOutlet UILabel *tixiankahao;
@property (weak, nonatomic) IBOutlet UILabel *kaihurenxingming;
@property (weak, nonatomic) IBOutlet UILabel *kaihuhangmingcheng;
@property (weak, nonatomic) IBOutlet UILabel *shenhezhuangtai;
@property (weak, nonatomic) IBOutlet UILabel *shenheyijian;


+ (instancetype)getWithdrawRecordCell;

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click;

@end
