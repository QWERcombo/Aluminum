//
//  CommonItemVC.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/11/4.
//  Copyright © 2018 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ShowType) {
    ShowType_YuanBang,  //圆棒
    ShowType_XingCai,   //型材
    ShowType_GuanCai,   //管材
};

@interface CommonItemVC : UIViewController

@property (nonatomic, assign) ShowType showType;

@end

NS_ASSUME_NONNULL_END
