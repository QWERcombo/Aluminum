//
//  ConditionDisplayCell.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2019/2/14.
//  Copyright © 2019年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConditionDisplayCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *showButton;


- (void)setButtonTitle:(NSString *)title selectTitle:(NSString *)selectTitle dataObject:(id)dataObject;
@end

NS_ASSUME_NONNULL_END
