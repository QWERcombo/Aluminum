//
//  ShoppingCarSingle.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/5/7.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "ShoppingCarSingle.h"

@implementation ShoppingCarSingle

+ (ShoppingCarSingle *)sharedShoppingCarSingle {
    
    static ShoppingCarSingle *shoppingCarSingle = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shoppingCarSingle = [[self alloc] init];
        shoppingCarSingle.shopCarDataSource = [NSMutableArray array];
    });
    
    return shoppingCarSingle;
}









@end
