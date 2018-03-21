//
//  AddBankCardView.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/21.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "AddBankCardView.h"

@implementation AddBankCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([AddBankCardView class]) owner:self options:nil] firstObject];
    }
    return self;
}

- (IBAction)next:(id)sender {
    NSLog(@"%@---%@---%@", self.holderTF.text, self.cardIDTF.text, self.phoneTF.text);
    if (self.click) {
        self.click(@"0");
    }
}


- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click {
    self.click = click;
    
}

@end
