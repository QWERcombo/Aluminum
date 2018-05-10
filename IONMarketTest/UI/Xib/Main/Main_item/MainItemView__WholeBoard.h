//
//  MainItemView__WholeBoard.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/17.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainItemView__WholeBoard : UIView<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *countTF;
@property (weak, nonatomic) IBOutlet UILabel *zhongliangLab;
@property (weak, nonatomic) IBOutlet UILabel *shuliangLab;
@property (nonatomic, strong) WholeBoardModel *wholeModel;
@property (nonatomic, copy) ClikBlock click;
@property (nonatomic, assign) BOOL isGetOrderMoney;

- (void)loadData:(WholeBoardModel *)data andCliker:(ClikBlock)click;

@end
