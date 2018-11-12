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
//更新价格
- (void)refreshBottomTotalPrice:(NSString *)total;
//直接购买跳转
- (void)goToBuyNow:(ShopCar *)shopCar;
//刷新购物车数量
- (void)refreshBottomShopCarNumber;


@end

@interface ZeroCutTabVC : UITableViewController

@property (nonatomic, weak) id<ZeroCutTabVCDelegate> delegate;
@property (nonatomic, strong) MainItemTypeModel *erjimulu_id;

//重置信息
- (void)refreshInfoToReset;
//下单相关操作
- (void)placeOrder:(UseType)useType;


@end

NS_ASSUME_NONNULL_END
