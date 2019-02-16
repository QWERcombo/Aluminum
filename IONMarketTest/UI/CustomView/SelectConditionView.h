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

@end

@interface SelectConditionView : UIView

@property (nonatomic,weak) id<SelectConditionViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray;
- (void)reset;
- (void)changeTitle:(NSString *)title index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
