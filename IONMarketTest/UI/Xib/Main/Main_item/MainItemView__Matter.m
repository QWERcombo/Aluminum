//
//  MainItemView__Matter.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/19.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "MainItemView__Matter.h"

@implementation MainItemView__Matter

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MainItemView__Matter class]) owner:self options:nil] firstObject];
        self.frame = frame;
    }
    
    return self;
}

- (IBAction)rightTap:(UITapGestureRecognizer *)sender {
    self.rightImgv.hidden = NO;
    self.leftImgv.hidden = YES;
    
    self.right_top_Label.textColor = [UIColor mianColor:2];
    self.right_down_Label.textColor  =[UIColor mianColor:2];
    self.left_top_Label.textColor = [UIColor mianColor:3];
    self.left_down_Label.textColor = [UIColor mianColor:3];
    
    self.amountTF.userInteractionEnabled = NO;
    self.rightCountLabel.text = @"0 元";
    
    if (self.click) {
        self.click(@"整只");
    }
}

- (IBAction)leftTap:(UITapGestureRecognizer *)sender {
    self.rightImgv.hidden = YES;
    self.leftImgv.hidden = NO;
    
    self.right_top_Label.textColor = [UIColor mianColor:3];
    self.right_down_Label.textColor  =[UIColor mianColor:3];
    self.left_top_Label.textColor = [UIColor mianColor:2];
    self.left_down_Label.textColor = [UIColor mianColor:2];
    if (self.click) {
        self.click(@"零切");
    }
}


- (IBAction)addNewAction:(UIButton *)sender {
    
    
}

- (IBAction)waiClicker:(UIButton *)sender {
    if (self.click) {
        self.click(@"0");
    }
}

- (IBAction)neiClicker:(UIButton *)sender {
    if (self.click) {
        self.click(@"1");
    }
}


- (void)loadData:(NSObject *)data andCliker:(ClikBlock)click {
    self.click = click;
    
    
}

@end
