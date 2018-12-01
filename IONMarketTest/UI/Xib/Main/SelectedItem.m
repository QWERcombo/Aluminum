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
    
    self.frame = frame;
    
    return self;
}

- (void)item_action:(UITapGestureRecognizer *)sender {
    if (_click) {
        _click(SINT(self.tag-1000));
    }
}

- (void)loadData:(NSObject *)data andCliker:(ClikBlock)click {
    _click = click;
    
}

@end
