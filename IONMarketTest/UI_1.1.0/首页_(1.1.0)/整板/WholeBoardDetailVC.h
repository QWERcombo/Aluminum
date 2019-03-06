//
//  WholeBoardDetailVC.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/10/23.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectedValue)(NSInteger selectNumber);

@interface WholeBoardDetailVC : UIViewController

@property (nonatomic, strong) WholeBoardModel *wholeModel;
@property (nonatomic, assign) NSInteger selectCount;
@property (nonatomic, copy) SelectedValue selectValue;
@property (nonatomic, copy) NSString *zhuangTai;//状态
@end

NS_ASSUME_NONNULL_END
