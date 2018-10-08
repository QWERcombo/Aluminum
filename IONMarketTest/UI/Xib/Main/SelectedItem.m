//
//  SelectedItem.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/10.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "SelectedItem.h"

@implementation SelectedItem

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
        [self addSubview:[[NSBundle mainBundle] loadNibNamed:@"SelectedItem" owner:self options:nil].firstObject];
    }
    
    UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(item_action:)];
    [self addGestureRecognizer:tapAction];
    return self;
}

- (void)item_action:(UITapGestureRecognizer *)sender {
    CGFloat margin = (SCREEN_WIGHT-(40*4)-20)/5;
    CGFloat width = self.item_imgv.size.width;
    CGPoint point = [sender locationInView:self.superview];
    NSInteger index = point.x/(width+margin);
//    NSLog(@"---%@", NSStringFromCGPoint([sender locationInView:self.superview]));
    if (point.y>(65+10)) {
        _click(SINT(index+4));
    } else {
        _click(SINT(index));
    }
    
}

- (void)loadData:(NSObject *)data andCliker:(ClikBlock)click {
    _click = click;
    
}

@end
