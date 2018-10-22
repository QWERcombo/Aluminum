//
//  WholeBoardTapView.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/10/19.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WholeBoardTapViewDelegate <NSObject>

@required
- (void)setSelected:(UIButton *)selectedButton;

@end


@interface WholeBoardTapView : UIView
@property (weak, nonatomic) IBOutlet UIButton *showButton;
@property (weak, nonatomic) IBOutlet UIView *showLine;

@property (nonatomic, weak) id<WholeBoardTapViewDelegate> delegate;

- (void)selectedStatus:(BOOL)status;

@end

NS_ASSUME_NONNULL_END
