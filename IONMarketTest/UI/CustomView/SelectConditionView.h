//
//  SelectConditionView.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2019/2/13.
//  Copyright © 2019年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SelectConditionViewDelegate <NSObject>

- (void)didSelectedConditionIndex:(NSInteger)index conditionTitle:(NSString *)title;

@optional
- (void)resetTitleInfomationWithIndex:(NSInteger)index;

@end

@interface SelectConditionView : UIView

@property (nonatomic,weak) id<SelectConditionViewDelegate> delegate;


- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray;
- (void)reset;//重置
- (void)changeTitle:(NSString *)title index:(NSInteger)index;//修改标题
- (void)resetTitleWithIndex:(NSInteger)index;//重置小于选中的标题

@end

NS_ASSUME_NONNULL_END
