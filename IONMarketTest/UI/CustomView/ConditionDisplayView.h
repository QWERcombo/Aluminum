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

typedef void(^SselectedIndexPath)(id dataObject, BOOL isOver);
@interface ConditionDisplayView : UIView <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *allButton;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, copy) NSString *selectTitle;  //选中的子条件
@property (nonatomic, copy) NSString *showTitle;    //选中的主条件
@property (nonatomic, copy) SselectedIndexPath selectedBlock;
@property (nonatomic, weak) id<ConditionDisplayViewDelegate> delegate;
@property (nonatomic, copy) NSString *parameter;


+ (void)showConditionDisplayViewWithTitle:(NSString *)title parameter:(NSString *)parameter selectTitle:(NSString *)selectTitle selectedBlock:(SselectedIndexPath)selectedBlock;
+ (void)hideConditionDisplayView;

@end

NS_ASSUME_NONNULL_END
