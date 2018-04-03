//
//  AddressShowView.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/4/3.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressShowView : UIView

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressDLabel;

@property (nonatomic, copy) ClikBlock clikerBlock;

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click;

@end
