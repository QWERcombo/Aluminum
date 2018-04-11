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
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([MainItemView__Tube class]) owner:self options:nil] firstObject];
        
        self.frame = frame;
        
        self.mainM = [[MainModel alloc] init];
    }
    
    return self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    switch (textField.tag) {
        case 300:
            self.mainM.changdu = textField.text;
            self.lengthIsChanged = YES;
            break;
        case 301:
            self.mainM.shuliang = textField.text;
            break;
        default:
            break;
    }
    if (self.mainBlock) {
        self.mainBlock(self.mainM, self.lengthIsChanged);
    }
}

- (IBAction)AddNewAction:(UIButton *)sender {
    if (self.click) {
        self.click(@"2");
    }
}

- (IBAction)rightTap:(UITapGestureRecognizer *)sender {
    self.rightImgv.hidden = NO;
    self.leftImgv.hidden = YES;
    
    self.right_top_Label.textColor = [UIColor mianColor:2];
    self.right_down_Label.textColor  =[UIColor mianColor:2];
    self.left_top_Label.textColor = [UIColor mianColor:3];
    self.left_down_Label.textColor = [UIColor mianColor:3];
    
    self.lengthTF.userInteractionEnabled = NO;
    self.rightCountLabel.text = @"0 元";
    
    self.lengthBtn.hidden = NO;
    self.lengthTF.hidden = YES;
    [self.lengthBtn setTitle:@"选择长度" forState:UIControlStateNormal];
    
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
    
    self.lengthTF.userInteractionEnabled = YES;
    
    self.lengthBtn.hidden = YES;
    self.lengthTF.hidden = NO;
    
    if (self.click) {
        self.click(@"零切");
    }
}

- (IBAction)thinClicker:(UIButton *)sender {
    if (self.click) {
        self.click(@"0");
    }
}

- (IBAction)widthClicker:(UIButton *)sender {
    if (self.click) {
        self.click(@"1");
    }
}

- (IBAction)selectLength:(UIButton *)sender {
    if (self.click) {
        self.click(@"-1");
    }
}



- (void)loadData:(NSObject *)data andCliker:(ClikBlock)click andMainBlock:(JudgeBlock)mainB {
    self.click = click;
    self.mainBlock = mainB;
    
}

@end
