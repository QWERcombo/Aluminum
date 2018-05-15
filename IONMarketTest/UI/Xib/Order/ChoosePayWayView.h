//
//  ChoosePayWayView.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/5/15.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^passValueBlock)(NSString *value);

@interface ChoosePayWayView : UIView

@property (nonatomic, strong) UIView *showView;

@property (nonatomic, copy) passValueBlock passValue;

+ (void)showSelfWithBlock:(passValueBlock)passBlock;
@end
