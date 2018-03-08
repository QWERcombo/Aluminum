//
//  PublicFuntionTool.h
//  WHFinance
//
//  Created by wanhong on 2017/7/7.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <UMSocialCore/UMSocialCore.h>

@interface PublicFuntionTool : NSObject

typedef void (^ReloadDataBlock)(void);

typedef enum : NSInteger {
    WHShowEmptyMode_noData,//无数据
    WHShowEmptyMode_noNetWork,//无网络
} WHShowEmptyViewMode;

@property (nonatomic, copy) ClikBlock clikBlock;


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

//根据版本号判断是否审核
- (void)checkAppId;
- (void)appStorecheck;

//数据排空（null）
- (id)noEmptyWithObject:(id)object;

//获取当前日期的一些信息
- (NSDateComponents *)getInfomationFromNowDate;

//返回自定义空视图
- (LYEmptyView *)getEmptyViewWithType:(WHShowEmptyViewMode)mode withReloadAction:(ReloadDataBlock)reload;


@end
