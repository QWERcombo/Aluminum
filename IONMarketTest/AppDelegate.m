//
//  AppDelegate.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/2/25.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TBTabBarController.h"
#import <UMShare/UMShare.h>
#import <WXApi.h>
#import <AlipaySDK/AlipaySDK.h>
#import "ZYNetworkAccessibity.h"

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [NSThread sleepForTimeInterval:1];
    
    [self settingEasyShowOptions];//配置菊花
    
//    [self setupRootViewController];//设置根视图
    
    [self configUSharePlatforms];//配置友盟
    
    [WXApi registerApp:WeixiPayAppkey];
    
    [self checkNetWork];
    
    return YES;
}

- (void)checkNetWork {
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:ZYNetworkAccessibityChangedNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChanged:) name:ZYNetworkAccessibityChangedNotification object:nil];
    [ZYNetworkAccessibity start];
    [ZYNetworkAccessibity setAlertEnable:YES];
}

//- (void)networkChanged:(NSNotification *)notification {
//
//    ZYNetworkAccessibleState state = ZYNetworkAccessibity.currentState;
//
//    if (state == ZYNetworkRestricted) {
//        NSLog(@"网络权限被关闭");
//    }
//}

- (void)setupRootViewController {
    
//    [[UtilsData sharedInstance] loginPlan:nil success:^(UserData *user) {
//
//        if ([[UserData currentUser].isCheck integerValue]==0) {
//            TBTabBarController *tabBar = [TBTabBarController new];
//            [tabBar setupchildVc:nil];
//            self.window.rootViewController = tabBar;
//        } else {
            TBTabBarController *tabBar = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TBtabBar"];
            self.window.rootViewController = tabBar;
//        }
//
//    } failure:^(UserData *user) {
//        LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
//        TBNavigationController *navi = [[TBNavigationController alloc] initWithRootViewController:login];
//        self.window.rootViewController = navi;
//
//    }];

    
}


//配置指示样式
- (void)settingEasyShowOptions {
    
    EasyShowOptions *options = [EasyShowOptions sharedEasyShowOptions];
    //在展示消息的时候，界面上是否可以事件。默认为YES，如果你想在展示消息的时候不让用户有手势交互，可设为NO
    options.textSuperViewReceiveEvent = NO ;
    //显示/隐藏的动画形式。有无动画，渐变，抖动，三种样式。
    options.textAnimationType = TextAnimationTypeFade;
    //提示框所在的位置。有上，中，下，状态栏上，导航条上，五种选择。
    options.textStatusType = ShowTextStatusTypeMidden;
    //文字大小
    options.textTitleFount = FONT_ArialMT(18);
    //文字颜色
    options.textTitleColor = [UIColor whiteColor];
    //背景颜色
    options.textBackGroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    //阴影颜色。(为clearcolor的时候不显示阴影)
    options.textShadowColor = [UIColor mianColor:1];
    //在显示加载框的时候，superview能否接收事件。
    options.lodingSuperViewReceiveEvent = NO;
    //是否将加载框显示到window上面
    options.lodingShowOnWindow = YES;
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    
        // 其他如支付等SDK的回调
        if ([url.host isEqualToString:@"safepay"]) {
            
            // 支付跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
                
                if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                    
//                    [[NSNotificationCenter defaultCenter] postNotificationName:WEIXIN_PAY_TO_WALLET object:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:WEIXIN_PAY_TO_ORDER object:nil];
                    
                }
            }];
            
            // 授权跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
                // 解析 auth code
                NSString *result = resultDic[@"result"];
                NSString *authCode = nil;
                if (result.length>0) {
                    NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                    for (NSString *subResult in resultArr) {
                        if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                            authCode = [subResult substringFromIndex:10];
                            break;
                        }
                    }
                }
                NSLog(@"授权结果 authCode = %@", authCode?:@"");
            }];
            
        }else if ([url.host isEqualToString:@"pay"]) {
            // 处理微信的支付结果
            [WXApi handleOpenURL:url delegate:self];
        }
        
        
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                
//                [[NSNotificationCenter defaultCenter] postNotificationName:WEIXIN_PAY_TO_WALLET object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:WEIXIN_PAY_TO_ORDER object:nil];
                
            }
            
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
        
    }else if ([url.host isEqualToString:@"pay"]) {
        // 处理微信的支付结果
        [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}



#pragma mark WXPay
- (void)onResp:(BaseResp*)resp
{
    //启动微信支付的response
    NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case 0:
                payResoult = @"支付结果：成功！";
                
                //微信钱包充值
//                [[NSNotificationCenter defaultCenter] postNotificationName:WEIXIN_PAY_TO_WALLET object:nil];
                [[NSNotificationCenter defaultCenter] postNotificationName:WEIXIN_PAY_TO_ORDER object:nil];
                
                break;
            case -1:
                payResoult = @"支付结果：失败！";
                break;
            case -2:
                payResoult = @"用户已经退出支付！";
                break;
            default:
                payResoult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                break;
        }
    }
//    NSLog(@"-------+++++%@", payResoult);
}




- (void)configUSharePlatforms
{
    
    [[UMSocialManager defaultManager] openLog:YES];
    [[UMSocialManager defaultManager] setUmSocialAppkey:UmengAppkey];
    
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WeixiPayAppkey appSecret:WeixiPayAppsecret redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppkey/*设置QQ平台的appID*/  appSecret:QQAppkeySecret redirectURL:@"http://mobile.umeng.com/social"];
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"IONMarketTest"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}




@end
