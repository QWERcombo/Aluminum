//
//  WholeBoardModel.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/5/2.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "WholeBoardModel.h"

@implementation ProductCate

@end

@implementation WholeBoardModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"zhonglei": @"productCate.name",@"xinghao": @"lvxing.name"
                                                                  }];
}


@end
