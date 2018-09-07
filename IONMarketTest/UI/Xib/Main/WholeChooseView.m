//
//  WholeChooseView.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/6/7.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "WholeChooseView.h"

@implementation WholeChooseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"WholeChooseView" owner:self options:nil] firstObject];
        self.dataDic = [NSMutableDictionary dictionary];
        self.frame = frame;
        [self.zhengbanBtn setTitleColor:[UIColor mianColor:2] forState:UIControlStateNormal];
        self.lastSelected = 100;
        
        for (UIView *sub in self.contentView.subviews) {
            if ([sub isKindOfClass:[CustomButton class]]) {
                CustomButton *button = (CustomButton*)sub;
                [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            }
        }
    }
    return self;
}


- (IBAction)buttonClicker:(CustomButton *)sender {
    
    UIButton *lastButton = [self viewWithTag:self.lastSelected];
    
    if (self.lastSelected>=100) {
        [lastButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    [sender setTitleColor:[UIColor mianColor:2] forState:UIControlStateNormal];
    self.zhonglei = sender.currentTitle;
    
    self.lastSelected = sender.tag;
}

- (IBAction)doneClicker:(UIButton *)sender {
    [self hide];
    if (self.delegate && [self.delegate respondsToSelector:@selector(refreshDataWithInfo:)]) {
        if (self.houduTF.text.length) {
            [self.dataDic setValue:self.houduTF.text forKey:@"houdu"];
        }
        if (self.zhijingTF.text.length) {
            [self.dataDic setValue:self.zhijingTF.text forKey:@"zhijing"];
        }
        if (self.zhonglei.length) {
            [self.dataDic setValue:self.zhonglei forKey:@"zhonglei"];
        }
        [self.delegate refreshDataWithInfo:self.dataDic];
    }
}

+ (void)show:(UIViewController *)delegateVC {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;

    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    transition.type = kCATransitionPush;

    transition.subtype = kCATransitionFromRight;

    
    WholeChooseView *choose = [[WholeChooseView alloc] initWithFrame:delegateVC.view.bounds];
    
    choose.delegate = delegateVC;
    transition.delegate = choose;
    
    [choose.layer addAnimation:transition forKey:nil];
    [delegateVC.view addSubview:choose];
    
}

- (IBAction)removeClicker:(UIButton *)sender {
    [self hide];
}

- (void)hide {
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3f;
    
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    transition.type = kCATransitionPush;
    
    transition.subtype = kCATransitionFromLeft;
    
    transition.delegate = self;
    
    [self.layer addAnimation:transition forKey:nil];
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
}



@end
