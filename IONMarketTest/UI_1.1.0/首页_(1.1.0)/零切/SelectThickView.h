//
//  SelectThickView.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/10/23.
//  Copyright © 2018 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectThickBlock)(NSString *selectIndexString);

typedef NS_ENUM(NSUInteger, SelectShowType) {
    SelectShowType_LingQie,     //零切
    SelectShowType_YuanBang,    //圆棒
    SelectShowType_GuanCai,     //管材
    SelectShowType_XingCai,     //型材
};

@interface SelectThickView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoHeight;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIButton *left_btn;
@property (weak, nonatomic) IBOutlet UILabel *left_label;
@property (weak, nonatomic) IBOutlet UIButton *right_btn;
@property (weak, nonatomic) IBOutlet UILabel *right_label;


@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, copy) SelectThickBlock selectBlock;
@property (nonatomic, assign) SelectShowType selectShowType;
@property (nonatomic, assign) BOOL isSelectLeft;//默认选中左边YES
@property (nonatomic, assign) NSInteger leftIndex;//选中的左索引
@property (nonatomic, assign) NSInteger rightIndex;//选中的右索引


+ (void)showSelectThickViewWithSelectShowType:(SelectShowType)selectType dataSource:(NSArray *)dataArr selectBlock:(SelectThickBlock)selectBlock;

@end

NS_ASSUME_NONNULL_END
