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


- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) {
        self.showButton.backgroundColor = [[UIColor mianColor:2] colorWithAlphaComponent:0.1];
        self.showButton.layer.borderColor = [UIColor mianColor:2].CGColor;
        self.showButton.layer.borderWidth = 1;
        [self.showButton setTitleColor:[UIColor mianColor:2] forState:UIControlStateNormal];
    } else {
        self.showButton.layer.borderColor = nil;
        self.showButton.layer.borderWidth = 0;
        self.showButton.backgroundColor = [UIColor mianColor:1];
        [self.showButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}


- (void)setButtonTitle:(NSString *)title {
    
    [self.showButton setTitle:title forState:UIControlStateNormal];
    
    
}


@end
