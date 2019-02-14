//
//  ConditionDisplayView.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2019/2/14.
//  Copyright © 2019年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ConditionDisplayViewDelegate <NSObject>

- (void)didSelectedSubConditionIndex:(NSInteger)index;

@end

typedef void(^SelectedIndexPath)(NSString *title);
@interface ConditionDisplayView : UIView <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *allButton;

@property (nonatomic, copy) NSMutableArray *dataSource;
@property (nonatomic, copy) SelectedIndexPath selectedBlock;
@property (nonatomic, weak) id<ConditionDisplayViewDelegate> delegate;
@property (nonatomic, copy) NSString *parameter;


+ (void)showConditionDisplayViewWithTitle:(NSString *)title parameter:(NSString *)parameter selectedBlock:(SelectedIndexPath)selectedBlock;
+ (void)hideConditionDisplayView;

@end

NS_ASSUME_NONNULL_END
