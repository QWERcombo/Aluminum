//
//  MainItem__Single.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/17.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "MainItem__Single.h"

@implementation MainItem__Single

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
        [self addSubview:[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MainItem__Single class]) owner:self options:nil].firstObject];
    }
    
    return self;
}



- (IBAction)addAction:(id)sender {
    NSLog(@"%@--%@---%@", self.lengthTF.text, self.widthTF.text, self.heightTF.text);
    
    
    
    
}
- (void)leftAction:(UITapGestureRecognizer *)sender {
    self.leftView.backgroundColor = [UIColor mianColor:1];
    self.rightView.backgroundColor = [UIColor whiteColor];
}
- (void)rightAction:(UITapGestureRecognizer *)sender {
    self.rightView.backgroundColor = [UIColor mianColor:1];
    self.leftView.backgroundColor = [UIColor whiteColor];
}

- (void)loadData:(NSObject *)data andCliker:(ClikBlock)click {
    
    
    
}

@end
