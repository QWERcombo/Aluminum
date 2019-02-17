//
//  TaoLiaoTabVC.h
//  IONMarketTest
//
//  Created by 赵越 on 2019/2/17.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TaoLiaoTabVCDelegate <NSObject>



@end

@interface TaoLiaoTabVC : UITableViewController

@property (nonatomic, weak) id<TaoLiaoTabVCDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
