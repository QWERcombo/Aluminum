//
//  WalletListModel.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/5/22.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseModel.h"

@interface WalletListModel : BaseModel

@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *no;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *createDate;

@property (nonatomic, strong) NSString *withDrawTime;
@property (nonatomic, strong) NSString *bankNo;
@property (nonatomic, strong) NSString *bank;
@property (nonatomic, strong) NSString *bankName;
@property (nonatomic, strong) NSString *shenheyijian;

@end
