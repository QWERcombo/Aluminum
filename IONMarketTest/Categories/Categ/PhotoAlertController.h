//
//  PhotoAlertController.h
//  YYJobs
//
//  Created by 瓜豆2018 on 2018/4/19.
//  Copyright © 2018年 guadou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReturnPickerImage)(UIImage *pickerImage);

@interface PhotoAlertController : UIAlertController

@property (nonatomic, assign) BOOL isAllowEdit;

@property (nonatomic, copy) ReturnPickerImage pickerImageBlock;

+(instancetype)initPhotoAlertControllerOnRebackImageBlock:(ReturnPickerImage)pickerImageBlock andRootViewController:(UIViewController *)rootViewController;

@end
