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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [NSThread sleepForTimeInterval:2];
    
    [self settingEasyShowOptions];//配置菊花
    
    [self setupRootViewController];//设置根视图
    
    return YES;
}

- (void)setupRootViewController {
    
    [[UtilsData sharedInstance] loginPlan:nil success:^(UserData *user) {
        
        TBTabBarController *tabBar = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TBtabBar"];
        self.window.rootViewController = tabBar;

    } failure:^(UserData *user) {
    
        LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        self.window.rootViewController = login;
        
    }];

    
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
