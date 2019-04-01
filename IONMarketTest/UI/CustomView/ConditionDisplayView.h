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

//- (void)didSelectedSubConditionIndex:(NSInteger)index;

@optional
//选择牌号的时候没有选择状态则默认选中第一条（仅限零切）
- (void)changePaiHaoWhenZhuangTaiIsNoneToGetShow:(NSString *)zhuangtai;

@end

typedef void(^SselectedIndexPath)(id dataObject, BOOL isOver);
@interface ConditionDisplayView : UIView <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *allButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;
@property (weak, nonatomic) IBOutlet UIView *hideView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *moreTitleArr;//更多情况下的title数组
@property (nonatomic, strong) NSMutableArray *selectArray;
@property (nonatomic, copy) NSString *selectTitle;  //选中的子条件
@property (nonatomic, copy) NSString *showTitle;    //选中的主条件
@property (nonatomic, copy) SselectedIndexPath selectedBlock;
@property (nonatomic, weak) id<ConditionDisplayViewDelegate> delegate;
@property (nonatomic, copy) NSString *parameter;

@property (nonatomic, copy) NSString *zhonglei; //品类
@property (nonatomic, copy) NSString *paihao;   //牌号
@property (nonatomic, copy) NSString *houdu;    //厚度
@property (nonatomic, copy) NSString *zhuangtai;//状态


+ (void)showConditionDisplayViewWithTitle:(NSString *)title
                                parameter:(NSString *)parameter
                              selectTitle:(NSString *)selectTitle
                                 zhonglei:(NSString *)zhonglei
                                   paihao:(NSString *)paihao
                                zhuangtai:(NSString *)zhuangtai
                                    houdu:(NSString *)houdu
                            selectedBlock:(SselectedIndexPath)selectedBlock;

+ (void)hideConditionDisplayView;

@end

NS_ASSUME_NONNULL_END
