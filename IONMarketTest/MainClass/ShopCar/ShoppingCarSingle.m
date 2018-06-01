//
//  ShoppingCarSingle.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/5/7.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "ShoppingCarSingle.h"
#import <WXApi.h>
#import <AlipaySDK/AlipaySDK.h>
#import "UtilsData.h"

@implementation ShoppingCarSingle

+ (ShoppingCarSingle *)sharedShoppingCarSingle {
    
    static ShoppingCarSingle *shoppingCarSingle = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shoppingCarSingle = [[self alloc] init];
//        shoppingCarSingle.shopCarDataSource = [NSMutableArray array];
    });
    
    return shoppingCarSingle;
}


- (void)beginPayUserWeixiWithOrderId:(NSString *)orderId andTotalfee:(NSString *)totalfee userPayMode:(weixinPayMode)mode {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if (mode == weixinPayMode_order) {
        
        [dict setValue:orderId forKey:@"no"];
//        [dict setValue:totalfee forKey:@"totalfee"]; //不能带小数点
        [dict setValue:@"1" forKey:@"totalfee"];
        
        [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_WeixinPay andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
            
            [self weixinPay:resultDic];
            
        } failure:^(NSString *error, NSInteger code) {
            
        }];
        
    }
    if (mode == weixinPayMode_wallet) {
        
        [dict setValue:[UserData currentUser].id forKey:@"userId"];
        //    [dict setValue:totalfee forKey:@"totalfee"]; //不能带小数点
        [dict setValue:@"1" forKey:@"totalfee"];
        
        [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_wxChongzhi andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
            
            [self weixinPay:resultDic];
            
        } failure:^(NSString *error, NSInteger code) {
            
        }];
        
    }
   
}


- (void)weixinPay:(NSDictionary *)resultDic {
    
    if ([WXApi isWXAppInstalled]) {
        
        NSString *appid = [NSString stringWithFormat:@"%@", resultDic[@"appid"]];
        NSString *partnerid = [NSString stringWithFormat:@"%@", resultDic[@"partnerId"]];
        NSString *prepayid = [NSString stringWithFormat:@"%@", resultDic[@"prepayId"]];
        NSString *package = [NSString stringWithFormat:@"%@", resultDic[@"package"]];
        NSString *noncestr = [NSString stringWithFormat:@"%@", resultDic[@"nonce_str"]];
        NSString *timestamp = [NSString stringWithFormat:@"%@", resultDic[@"timestamp"]];
        NSString *sign = [NSString stringWithFormat:@"%@", resultDic[@"sign"]];
        
        //需要创建这个支付对象
        PayReq *req   = [[PayReq alloc] init];
        //由用户微信号和AppID组成的唯一标识，用于校验微信用户
        req.openID = appid;
        // 商家id，在注册的时候给的
        req.partnerId = partnerid;
        // 预支付订单这个是后台跟微信服务器交互后，微信服务器传给你们服务器的，你们服务器再传给你
        req.prepayId  = prepayid;
        // 根据财付通文档填写的数据和签名
        req.package  = package;
        // 随机编码，为了防止重复的，在后台生成
        req.nonceStr  = noncestr;
        // 这个是时间戳，也是在后台生成的，为了验证支付的
        NSString * stamp = timestamp;
        req.timeStamp = stamp.intValue;
        // 这个签名也是后台做的
        req.sign = sign;
        //发送请求到微信，等待微信返回onResp
        [WXApi sendReq:req];
        
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还没有安装微信！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *done = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[WXApi getWXAppInstallUrl]]];
        }];
        [alert addAction:done];
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alert animated:YES completion:^{
            
        }];
    }
    
}

- (void)beginPayUserWalletWithOrderId:(NSString *)orderId andTotalfee:(NSString *)totalfee  {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[UserData currentUser].id forKey:@"userId"];
    [dict setValue:totalfee forKey:@"totalfee"]; //不能带小数点
    [dict setValue:orderId forKey:@"no"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_qianbaoPay andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}

- (void)beginPayUserWhiteBarWithOrderId:(NSString *)orderId andTotalfee:(NSString *)totalfee {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[UserData currentUser].id forKey:@"userId"];
    [dict setValue:totalfee forKey:@"totalfee"]; //不能带小数点
    [dict setValue:orderId forKey:@"no"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_baitiaoPay andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}


- (void)getServerShopCarAmountAndTotalfee:(getAmountTotalfeeBlock)block {
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setValue:[UserData currentUser].id forKey:@"userId"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dataDic imageArray:nil WithType:Interface_countGouwucheByUser andCookie:nil showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
        
        NSArray *array = resultDic[@"result"];
        NSDictionary *dict = [array firstObject];
        NSString *count = [NSString stringWithFormat:@"%@", dict[@"count"]];
        NSString *totalMoney = [NSString stringWithFormat:@"%@", dict[@"totalMoney"]];
        
        NSString *showCount = @"";
        NSString *showMoney = @"0元";
        if ([count integerValue] > 0) {
            showCount = count;
        }
        if ([totalMoney floatValue] >0) {
            showMoney = [NSString stringWithFormat:@"%@元", totalMoney];
        }
        
        if (block) {
            block(showCount,showMoney);
        }
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}

- (void)beginPayUserAliPayWithOrderId:(NSString *)orderId andTotalfee:(NSString *)totalfee userPayMode:(aliPayMode)mode {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if (mode == aliPayMode_order) {
        [dict setValue:orderId forKey:@"no"];
        [dict setValue:totalfee forKey:@"totalfee"];
        
        [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_aliAppOrderPay andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
            
            
            
            [self aliPayWithOrderJson:@""];
            
        } failure:^(NSString *error, NSInteger code) {
            
        }];
        
        
    }
    
    
    if (mode == aliPayMode_wallet) {
        
    }
}

- (void)aliPayWithOrderJson:(NSString *)orderJson {
    
    NSString *appScheme = @"LeQie";
    
    [[AlipaySDK defaultService] payOrder:orderJson fromScheme:appScheme callback:^(NSDictionary *resultDic) {
        NSLog(@"---%@", resultDic);
        
        
        
        
    }];
    
    
}


@end
