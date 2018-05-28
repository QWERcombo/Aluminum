//
//  OrderListItemView.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/5/27.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListItemView : UIView
@property (weak, nonatomic) IBOutlet UILabel *zhongleiLab;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (strong, nonatomic) IBOutlet UIView *showView;

- (void)loadData:(NSObject *)dataSource;

@end
