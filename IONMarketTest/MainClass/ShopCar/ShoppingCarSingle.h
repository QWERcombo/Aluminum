//
//  ShoppingCarSingle.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/5/7.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    weixinPayMode_order,
    weixinPayMode_wallet,
} weixinPayMode;

typedef enum : NSUInteger {
    aliPayMode_order,
    aliPayMode_wallet,
} aliPayMode;


//typedef enum : NSUInteger {
//    payMode_weixin,
//    payMode_ali,
//    payMode_baitiao,
//    payMode_wallet,
//} payMode;
typedef void(^getAmountTotalfeeBlock)(NSString *amout, NSString *totalfee);

typedef void(^paySuccessBlock)(void);

@interface ShoppingCarSingle : NSObject


@property (nonatomic, copy) getAmountTotalfeeBlock amoutBlock; //角标
@property (nonatomic, assign) weixinPayMode payMode;
@property (nonatomic, copy) paySuccessBlock payBlock;


+ (ShoppingCarSingle *)sharedShoppingCarSingle;

//微信支付
- (void)beginPayUserWeixiWithOrderId:(NSString *)orderId andTotalfee:(NSString *)totalfee userPayMode:(weixinPayMode)mode paySuccessBlock:(paySuccessBlock)paySuccessBlock;

//钱包支付
- (void)beginPayUserWalletWithOrderId:(NSString *)orderId andTotalfee:(NSString *)totalfee paySuccessBlock:(paySuccessBlock)paySuccessBlock;

//白条支付
- (void)beginPayUserWhiteBarWithOrderId:(NSString *)orderId andTotalfee:(NSString *)totalfee paySuccessBlock:(paySuccessBlock)paySuccessBlock;

//获取购物车数量和总价
- (void)getServerShopCarAmountAndTotalfee:(getAmountTotalfeeBlock)block;

//支付宝支付
- (void)beginPayUserAliPayWithOrderId:(NSString *)orderId andTotalfee:(NSString *)totalfee userPayMode:(aliPayMode)mode paySuccessBlock:(paySuccessBlock)paySuccessBlock;

@end
