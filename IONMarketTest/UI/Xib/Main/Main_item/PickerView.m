//
//  PickerView.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/24.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "PickerView.h"

@implementation PickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"PickerView" owner:self options:nil] firstObject];
        
        self.frame = frame;
    }
    return self;
}


- (IBAction)cancelAction:(UIButton *)sender {
    
}


- (IBAction)confirmAction:(UIButton *)sender {
    
}



- (void)loadData:(NSObject *)data andCliker:(ClikBlock)click {
    self.click = click;
    
    
    
}



@end
