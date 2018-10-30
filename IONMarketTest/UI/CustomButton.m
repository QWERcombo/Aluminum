//
//  CustomButton.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/6/8.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "CustomButton.h"

static const NSTimeInterval defaultDuration = 3.0f;
//记录按钮是否忽略按钮点击事件，默认第一次执行事件
static BOOL _isIgnoreEvent = NO;

/**
 设置执行按钮事件状态
 */
static void resetState (){
    
    _isIgnoreEvent = NO;
    
}

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
    
    self.layer.borderColor = [UIColor Grey_WordColor].CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 2;
    self.layer.masksToBounds = YES;
    [self setTitleColor:[UIColor Grey_WordColor] forState:UIControlStateNormal];
    
}

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    //1.按钮点击间隔事件
    _time = _time = (0) ? defaultDuration :_time;
    //2.是否忽略按钮点击事件
    if (_isIgnoreEvent) {
        //        2.1忽略按钮点击事件
        //        2.1忽略此事件
        return;
    }else if (_time >0){
        //不要忽略按钮的点击事件
        //后续在事件间隔内直接忽略掉按钮事件
        _isIgnoreEvent = YES;
        //间隔事件后  执行按钮事件
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            resetState();
        });
        //发送按钮点击消息
        [super sendAction:action to:target forEvent:event];
    }
}



@end
