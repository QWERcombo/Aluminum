//
//  AddBankCardUploadView.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/21.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "AddBankCardUploadView.h"

@implementation AddBankCardUploadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([AddBankCardUploadView class]) owner:self options:nil] firstObject];
        
        self.frame = frame;
    }
    return self;
}


- (IBAction)getCodeAc:(id)sender {
    if (self.click) {
        self.click(@"0");
    }
}


- (IBAction)upload:(id)sender {
    if (self.click) {
        self.click(@"1");
    }
}


- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click {
    self.click = click;
    self.infoLab.text = @"本次操作需要短信验证，请输入手机号码15552523636收到的短信验证码";
    
    
}

@end
