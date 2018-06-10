//
//  CustomButton.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/6/8.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCommon];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initCommon];
}

- (void)initCommon {
    
    self.layer.borderColor = [UIColor mianColor:2].CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
}




@end
