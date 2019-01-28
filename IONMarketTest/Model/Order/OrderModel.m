//
//  OrderModel.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/4/2.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"phone": @"currentAddress.phone"
                                                                  }];
}

@end
