//
//  MainItemView__Tube.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/19.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "MainItemView__Tube.h"

@implementation MainItemView__Tube

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MainItemView__Tube class]) owner:self options:nil].firstObject];
    }
    
    return self;
}

- (void)loadData:(NSObject *)data andCliker:(ClikBlock)click {
    
    
    
    
}

@end