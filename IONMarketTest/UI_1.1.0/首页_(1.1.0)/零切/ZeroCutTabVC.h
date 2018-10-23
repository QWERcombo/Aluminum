//
//  ZeroCutTabVC.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/10/23.
//  Copyright © 2018 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ZeroCutTabVCDelegate <NSObject>



@end

@interface ZeroCutTabVC : UITableViewController

@property (nonatomic, weak) id<ZeroCutTabVCDelegate> delegate;



- (void)refreshInfoToReset;

@end

NS_ASSUME_NONNULL_END
