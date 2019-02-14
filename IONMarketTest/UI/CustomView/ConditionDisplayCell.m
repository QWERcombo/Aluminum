//
//  ConditionDisplayCell.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2019/2/14.
//  Copyright © 2019年 赵越. All rights reserved.
//

#import "ConditionDisplayCell.h"

@implementation ConditionDisplayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.showButton.layer.cornerRadius = 2;
    self.showButton.layer.masksToBounds = YES;
}


- (IBAction)buttonClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    
}

- (void)setButtonTitle:(NSString *)title {
    
    [self.showButton setTitle:title forState:UIControlStateNormal];
    
    
}


@end
