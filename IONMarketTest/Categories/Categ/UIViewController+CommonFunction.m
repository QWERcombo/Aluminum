//
//  UIViewController+CommonFunction.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/5/17.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "UIViewController+CommonFunction.h"
#import <Photos/Photos.h>

@implementation UIViewController (CommonFunction)

- (void)userCamera:(onCameraUsable)onCameraUsable {
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        // 用户是否允许摄像头使用
        NSString * mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        // 不允许弹出提示框
        if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Notice" message:@"Please allow camera access for this application." preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *done = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                
            }];
            [alert addAction:done];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            
        }else{
            // 这里是摄像头可以使用的处理逻辑
            onCameraUsable();
        }
    } else {
        // 硬件问题提示
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Notice" message:@"Ops, there is something wrong with your camera." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *done = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:done];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }
    
}

- (void)userAlbum:(onAlbumUsable)onAlbumUsable {
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        //        PHAuthorizationStatus photoStatus = [PHPhotoLibrary authorizationStatus];
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            
            if (status == PHAuthorizationStatusAuthorized) {
                // 这里是摄像头可以使用的处理逻辑
                onAlbumUsable();
                
            } else {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Notice" message:@"Please allow PhotoLibrary access for this application." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *done = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                    
                }];
                [alert addAction:done];
                [self presentViewController:alert animated:YES completion:^{
                    
                }];
                
            }
            
        }];
        
    }
    
}

//获取手机当前显示的ViewController
+ (UIViewController*)currentViewController{
    
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    
    while (1) {
        
        if ([vc isKindOfClass:[UITabBarController class]]) {
            
            vc = ((UITabBarController*)vc).selectedViewController;
            
        }
        
        
        if ([vc isKindOfClass:[UINavigationController class]]) {
            
            vc = ((UINavigationController*)vc).visibleViewController;
            
        }
        
        
        if (vc.presentedViewController) {
            
            vc = vc.presentedViewController;
            
        }else{
            
            break;
            
        }
        
    }
    
    return vc;
}


//iOS获取顶层的控制器
- (UIViewController *)appRootViewController
{
    
    UIViewController *RootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *topVC = RootVC;
    
    while (topVC.presentedViewController) {
        
        topVC = topVC.presentedViewController;
        
    }
    
    return topVC;
    
}

@end
