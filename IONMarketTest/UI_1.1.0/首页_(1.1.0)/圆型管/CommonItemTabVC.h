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
//更新价格
- (void)refreshBottomTotalPrice:(NSString *)total;
//直接购买跳转
- (void)goToBuyNow:(ShopCar *)shopCar;
//刷新购物车数量
- (void)refreshBottomShopCarNumber;


@end

@interface CommonItemTabVC : UITableViewController

@property (nonatomic, weak) id<CommonItemTabVCDelegate> delegate;
@property (nonatomic, assign) ShowType showType;
@property (nonatomic, strong) MainItemTypeModel *erjimulu_id;
@property (nonatomic, copy) NSString *zhuangTai;//状态

//重置信息
- (void)refreshInfoToReset;
//下单相关操作
- (void)placeOrder:(UseType)useType;

@end

NS_ASSUME_NONNULL_END
