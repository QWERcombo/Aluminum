//
//  MainItem__Single.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/17.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "MainItem__Single.h"

@implementation MainItem__Single


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        self = [[[NSBundle mainBundle] loadNibNamed:@"MainItem__Single" owner:self options:nil] firstObject];
        
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
}


- (IBAction)hbhb:(UITapGestureRecognizer *)sender {
    self.rightImgv.hidden = YES;
    self.leftImgv.hidden = NO;
    
    self.right_top_Label.textColor = [UIColor mianColor:3];
    self.right_down_Label.textColor  =[UIColor mianColor:3];
    self.left_top_Label.textColor = [UIColor mianColor:2];
    self.left_down_Label.textColor = [UIColor mianColor:2];
}


- (IBAction)selectAction:(UIButton *)sender {//选择厚度
    if (self.click) {
        self.click(@"0");
    }

}


- (IBAction)addNew:(UIButton *)sender {
//    NSLog(@"%@--%@---%@", self.lengthTF.text, self.widthTF.text, self.lengthTF.text);
    if (self.click) {
        self.click(@"1");
    }
}


- (void)loadData:(NSObject *)data andCliker:(ClikBlock)click {
    self.click = click;
    self.thinLabel.text = @"2222";
    
}

@end
