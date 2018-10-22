//
//  WholeBoardTapView.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/10/19.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "WholeBoardTapView.h"

@implementation WholeBoardTapView

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
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"WholeBoardTapView" owner:self options:nil] firstObject];
        self.showLine.backgroundColor = [UIColor whiteColor];
        self.frame = frame;
    }
    return self;
}

- (void)selectedStatus:(BOOL)status {
    
    [self.showButton setSelected:status];
    self.showLine.backgroundColor = status?[UIColor mianColor:2]:[UIColor whiteColor];
    
}

- (IBAction)tapClicker:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(setSelected:)]) {
        [self.delegate setSelected:sender];
    }
}

@end
