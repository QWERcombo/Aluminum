//
//  OrderListItemView.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/5/27.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "OrderListItemView.h"

@implementation OrderListItemView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.showView = [[[NSBundle mainBundle] loadNibNamed:@"OrderListItemView" owner:self options:nil] firstObject];
        self.showView.frame = CGRectMake(0, 0, SCREEN_WIGHT, 40);
        [self addSubview:self.showView];
        
        self.frame = frame;
    }
    return self;
}


- (void)loadData:(NSObject *)dataSource {
    
    OrderListDetailModel *model = (OrderListDetailModel *)dataSource;
    self.moneyLab.text = [NSString stringWithFormat:@"%@元", [NSString getStringAfterTwo:model.money]];
    self.zhongleiLab.text = [NSString stringWithFormat:@"%@ * %@", model.zhonglei,model.productNum];
    
}

@end
