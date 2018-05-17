//
//  UIViewController+CommonFunction.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/5/17.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CommonFunction)

typedef void (^onCameraUsable)(void);
//获取相机权限
- (void)userCamera:(onCameraUsable)onCameraUsable;

typedef void (^onAlbumUsable)(void);
//获取相册权限
- (void)userAlbum:(onAlbumUsable)onAlbumUsable;


@end
