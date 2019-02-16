//
//  WholeBoardListCell.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/10/19.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectedBlock)(void);

@interface WholeBoardListCell : BaseCell

@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet UILabel *guigeLabel;
@property (weak, nonatomic) IBOutlet UILabel *changjiaLabel;
@property (weak, nonatomic) IBOutlet UILabel *danjiaLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *kucunLabel;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet HYStepper *stepper;

@property (weak, nonatomic) IBOutlet UIButton *yueBtn;
@property (weak, nonatomic) IBOutlet UILabel *xinghaoLab;


@property (nonatomic, copy) SelectedBlock selectBlock;


- (void)showSelectedBlock:(SelectedBlock)selectBlock;
+ (instancetype)initCell:(UITableView *)tableView cellName:(NSString *)cellName type:(NSString *)type dataObject:(id)dataObject;
@end

NS_ASSUME_NONNULL_END
