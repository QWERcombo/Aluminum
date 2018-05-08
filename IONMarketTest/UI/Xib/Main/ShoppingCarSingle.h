//
//  ShoppingCarSingle.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/5/7.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingCarSingle : NSObject

@property (nonatomic, strong) NSMutableArray *shopCarDataSource; //数据
@property (nonatomic, assign) float totalPrice; //总价

+ (ShoppingCarSingle *)sharedShoppingCarSingle;

@end