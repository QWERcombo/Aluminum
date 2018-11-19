//
//  PublicFuntionTool.h
//  WHFinance
//
//  Created by wanhong on 2017/7/7.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <UMSocialCore/UMSocialCore.h>

typedef NS_ENUM(NSUInteger, GetOrderType) {
    GetOrderType_ZhengBan,  //整板
    GetOrderType_LingQie,   //零切
    GetOrderType_YuanBang,  //圆棒
    GetOrderType_XingCai,   //型材
    GetOrderType_GuanCai,   //管材
};

typedef NS_ENUM(NSUInteger, UseType) {
    UseType_OrderMoney,     //获取价格
    UseType_AddShopCar,     //加入购物车
    UseType_BuyNow,         //直接购买
    UseType_DanJia,         //获取单价
};


@class ShopCar, MainItemTypeModel;
@interface PublicFuntionTool : NSObject

typedef void (^ReloadDataBlock)(void);

//判断是否登录 没登录的跳登录页
typedef void (^HadLoginBlock)(void);

//获取价格成功的回调
typedef void (^GetOrderMoneySuccessBlock)(NSDictionary *dataDic);

//直接购买拼装参数
typedef void (^GetBuyNowSuccessBlock)(ShopCar *shopCar);

//加入购物车成功回调
typedef void (^GetAddCarSuccessBlock)(void);



typedef enum : NSInteger {
    WHShowEmptyMode_noData,//无数据
    WHShowEmptyMode_noNetWork,//无网络
} WHShowEmptyViewMode;

@property (nonatomic, copy) ClikBlock clikBlock;
@property (nonatomic, copy) HadLoginBlock loginBlock;

AS_SINGLETON(PublicFuntionTool);

//发送验证码
//- (void)getSmsCodeByPhoneString:(NSString *)phone;
//调用分享
//- (void)uMengShareWithObject:(UMSocialPlatformType)dataType andBaseController:(BaseViewController *)controller;

//获取星期几
- (NSString *) getweekDayStringWithDate;

//图片转base64字符串
- (NSString *)getBase64StringFrom:(UIImage *)image;


//用户退出登录
- (void)userLoginOut;

//获取app名称
- (NSString *)getAppName;
//获取app版本号
- (NSString *)getAppVersion;

//根据版本号判断是否审核
- (void)checkAppId;
- (void)appStorecheck;

//数据排空（null）
- (id)noEmptyWithObject:(id)object;

//获取当前日期的一些信息
- (NSDateComponents *)getInfomationFromNowDate;

//返回自定义空视图
- (LYEmptyView *)getEmptyViewWithType:(WHShowEmptyViewMode)mode withHintText:(NSString *)titleStr andDetailStr:(NSString *)detailStr withReloadAction:(ReloadDataBlock)reload;

//某些操作需要登录状态
- (void)isHadLogin:(HadLoginBlock)loginBlock;



//下单通用接口(价格 购买 加购物车)
- (void)placeOrderCommonInterfaceWithUseType:(UseType)useType moneyWithOrderType:(GetOrderType)orderType chang:(NSString *)chang kuan:(NSString *)kuan hou:(NSString *)hou amount:(NSString *)amount type:(NSString *)type erjimulu:(MainItemTypeModel *)erjimulu orderMoney:(NSString *)orderMoney successBlock:(GetOrderMoneySuccessBlock)successBlock buyNowSuccessBlock:(GetBuyNowSuccessBlock)buyNowSuccessBlock addCarSuccessBlock:(GetAddCarSuccessBlock)addCarSuccessBlock;




@end
