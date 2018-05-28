//
//  ChoosePayWayView.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/5/15.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "ChoosePayWayView.h"

@implementation ChoosePayWayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *blackView = [[UIView alloc] initWithFrame:self.bounds];
        
        blackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        
        [self addSubview:blackView];
        
        UITapGestureRecognizer *removeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeTap:)];
        [self addGestureRecognizer:removeTap];
        
        self.showView = [[[NSBundle mainBundle] loadNibNamed:@"ChoosePayWayView" owner:self options:nil] firstObject];
        
        self.showView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIGHT, 210);
        
        [self addSubview:self.showView];
        
    }
    return self;
}

- (IBAction)buttonClicker:(UIButton *)sender {
    if (self.passValue) {
        self.passValue(sender.currentTitle);
        [self hide];
    }
}


- (void)removeTap:(UITapGestureRecognizer *)sender {
    
    [self hide];
    
}

- (void)hide {
    [UIView animateWithDuration:.3 animations:^{
        self.showView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIGHT, 210);
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

+ (void)showSelfWithBlock:(passValueBlock)passBlock {
    
    ChoosePayWayView *choose = [[ChoosePayWayView alloc] initWithFrame:MY_WINDOW.bounds];
    
    choose.passValue = passBlock;
    
    [UIView animateWithDuration:.3 animations:^{
        
        choose.showView.frame = CGRectMake(0, SCREEN_HEIGHT-210, SCREEN_WIGHT, 210);
        
    } completion:^(BOOL finished) {
        
    }];
    
    [MY_WINDOW addSubview:choose];
}


@end
