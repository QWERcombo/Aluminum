//
//  AddBankCardView.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/21.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddBankCardView : UIView

@property (weak, nonatomic) IBOutlet UITextField *holderTF;

@property (weak, nonatomic) IBOutlet UITextField *cardIDTF;

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

@property (nonatomic, copy) ClikBlock click;

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click;

@end
