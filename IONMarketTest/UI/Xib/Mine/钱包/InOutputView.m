//
//  InOutputView.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/21.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "InOutputView.h"

@implementation InOutputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:[[NSBundle mainBundle] loadNibNamed:@"InOutputView" owner:self options:nil].firstObject];
    }
    
    return self;
}


- (IBAction)nextCliker:(id)sender {
   
    _click(@"1");
}

- (IBAction)more:(id)sender {
    
    _click(@"0");
}


- (void)loadData:(NSObject *)data andCliker:(ClikBlock)click {
    _click = click;
    
    NSString *way = (NSString *)data;
    NSLog(@"%@", way);
    if ([way isEqualToString:@"1"]) {//转出
        
    } else {//转入
        
        self.hintLabel.text = @"单日限额20,000元 单月限额50,000元";
        
        
    }    
    
}



@end
