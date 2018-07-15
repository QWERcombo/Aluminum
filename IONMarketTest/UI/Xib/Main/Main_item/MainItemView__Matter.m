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
        
        self.mainM = [[MainModel alloc] init];
        self.changduS = [NSMutableString string];
        self.shuliangS = [NSMutableString string];
    }
    
    return self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    switch (textField.tag) {
        case 300:
            [self.changduS replaceCharactersInRange:range withString:string];
            self.mainM.changdu = self.changduS;
            self.lengthIsChanged = YES;
            break;
        case 301:
            [self.shuliangS replaceCharactersInRange:range withString:string];
            self.mainM.shuliang = self.shuliangS;
            break;
        default:
            break;
    }
    
    if (self.mainBlock) {
        self.mainBlock(self.mainM, self.lengthIsChanged);
    }
    [self resetShowLabel];
    
    return YES;
}
//有值变化重置
- (void)resetShowLabel {
    self.rightImgv.hidden = YES;
    self.leftImgv.hidden = YES;
    self.right_top_Label.text = @"0元";
    self.left_top_Label.text = @"0元";
    self.left_top_Label.textColor  =[UIColor mianColor:3];
    self.right_top_Label.textColor  =[UIColor mianColor:3];
    self.right_down_Label.textColor  =[UIColor mianColor:3];
    self.left_down_Label.textColor = [UIColor mianColor:3];
    self.leftCountLabel.text = @"0";
}

- (IBAction)rightTap:(UITapGestureRecognizer *)sender {
//    self.rightImgv.hidden = NO;
//    self.leftImgv.hidden = YES;
    
    self.right_top_Label.textColor = [UIColor mianColor:2];
    self.right_down_Label.textColor  =[UIColor mianColor:2];
    self.left_top_Label.text = @"0元";
    self.left_top_Label.textColor = [UIColor mianColor:3];
    self.left_down_Label.textColor = [UIColor mianColor:3];
    
    self.lengthTF.userInteractionEnabled = NO;
    
    self.lengthBtn.hidden = NO;
    self.lengthTF.hidden = YES;
    [self.lengthBtn setTitle:@"选择长度" forState:UIControlStateNormal];
    
    if (self.click) {
        self.click(@"整只");
    }
}

- (IBAction)leftTap:(UITapGestureRecognizer *)sender {
//    self.rightImgv.hidden = YES;
//    self.leftImgv.hidden = NO;
//
//    self.right_top_Label.text = @"0元";
//    self.right_top_Label.textColor = [UIColor mianColor:3];
//    self.right_down_Label.textColor  =[UIColor mianColor:3];
//    self.left_top_Label.textColor = [UIColor mianColor:2];
//    self.left_down_Label.textColor = [UIColor mianColor:2];
//
//    self.lengthTF.userInteractionEnabled = YES;
//
//    self.lengthBtn.hidden = YES;
//    self.lengthTF.hidden = NO;
//
//    if (self.click) {
//        self.click(@"零切");
//    }
}


- (IBAction)addNewAction:(UIButton *)sender {
    if (self.click) {
        self.click(@"2");
    }
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

- (IBAction)getLength:(UIButton *)sender {
    if (self.click) {
        self.click(@"-1");
    }
    
}



- (void)loadData:(NSObject *)data andCliker:(ClikBlock)click andMainBlock:(JudgeBlock)mainB {
    self.click = click;
    self.mainBlock = mainB;
    
}

@end
