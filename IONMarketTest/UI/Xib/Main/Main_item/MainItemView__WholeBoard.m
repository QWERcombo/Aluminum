//
//  MainItemView__WholeBoard.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/17.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "MainItemView__WholeBoard.h"

@implementation MainItemView__WholeBoard

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
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MainItemView__WholeBoard class]) owner:self options:nil] firstObject];
        
        self.frame = frame;
    }
    
    return self;
}



- (void)loadData:(NSObject *)data andCliker:(ClikBlock)click {
    NSArray *array = @[@"H24",@"1.95*1220*2440",@"国标",@"1系",@"否",@"否",@"简易包装",@"8.99吨",@"10元/吨",@"1/吨",@"2866件",@"长江有色"];
    for (NSInteger i = 0; i<array.count; i++) {
        
        UILabel *label = [self viewWithTag:100+i];
        
        label.text = [array objectAtIndex:i];
    }
}

@end
