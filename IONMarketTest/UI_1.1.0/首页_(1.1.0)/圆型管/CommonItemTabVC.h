//
//  CommonItemTabVC.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/11/4.
//  Copyright © 2018 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonItemVC.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CommonItemTabVCDelegate <NSObject>

@end

@interface CommonItemTabVC : UITableViewController

@property (nonatomic, weak) id<CommonItemTabVCDelegate> delegate;
@property (nonatomic, assign) ShowType showType;

//重置信息
- (void)refreshInfoToReset;

@end

NS_ASSUME_NONNULL_END
