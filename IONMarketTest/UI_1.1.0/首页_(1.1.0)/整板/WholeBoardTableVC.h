//
//  WholeBoardTableVC.h
//  IONMarketTest
//
//  Created by 赵越 on 2019/1/17.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WholeBoardTableVC : UITableViewController

@property (nonatomic, strong) WholeBoardModel *wholeModel;
@property (nonatomic, assign) NSInteger selectCount;
//@property (nonatomic, copy) SelectedValue selectValue;

@property (weak, nonatomic) IBOutlet HYStepper *stepper;

@end

NS_ASSUME_NONNULL_END
