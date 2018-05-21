//
//  PriceModel.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/5/21.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseModel.h"

@interface PriceModel : BaseModel

@property (nonatomic, copy) NSString *averagePrice;

@property (nonatomic, copy) NSString *createDate;

@property (nonatomic, copy) NSString *deleted;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *priceChange;

@property (nonatomic, copy) NSString *priceRange;

@property (nonatomic, copy) NSString *riqi;

@property (nonatomic, copy) NSString *source;

@property (nonatomic, copy) NSString *unit;

@end
