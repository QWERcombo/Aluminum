//
//  SelectThickView.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/10/23.
//  Copyright © 2018 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectThickBlock)(NSInteger selectIndex);

@interface SelectThickView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, copy) SelectThickBlock selectBlock;

+ (void)showSelectThickViewWithDataSource:(NSArray *)dataArr selectBlock:(SelectThickBlock)selectBlock;

@end

NS_ASSUME_NONNULL_END
