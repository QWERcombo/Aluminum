//
//  TicketModel.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/27.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseModel.h"

@interface TicketModel : BaseModel

@property (nonatomic, strong) NSString *createDate;

@property (nonatomic, strong) NSString *deleted;

@property (nonatomic, strong) NSString *id;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *picture;

@property (nonatomic, strong) NSString *fatherId;

@end