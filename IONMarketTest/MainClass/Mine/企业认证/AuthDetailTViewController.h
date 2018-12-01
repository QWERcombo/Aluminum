//
//  AuthDetailTViewController.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/4/9.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AuthDetailTViewController : UITableViewController
@property (nonatomic, copy) void(^PassValueBlock)(NSString *inputStr);
@property (nonatomic, strong) NSString *contentStr;
@property (nonatomic, assign) NSInteger index;
@end
