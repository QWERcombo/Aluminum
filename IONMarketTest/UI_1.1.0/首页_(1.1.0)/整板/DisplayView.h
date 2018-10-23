//
//  DisplayView.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/10/23.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectedIndexPath)(NSString *title);

@interface DisplayView : UIView<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (nonatomic, copy) SelectedIndexPath selectedBlock;
@property (nonatomic, strong) NSMutableArray *dataSource;

+ (void)showDisplayViewWithDataSource:(NSArray *)dataSource selectedIndexPath:(SelectedIndexPath)selectedBlock;

@end

NS_ASSUME_NONNULL_END
