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
        self = [[[NSBundle mainBundle] loadNibNamed:@"MainItem__Single" owner:self options:nil] firstObject];
        
        self.frame = frame;
        
        self.mainM = [[MainModel alloc] init];
    }
    
    return self;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    switch (textField.tag) {
        case 200:
            self.mainM.changdu = textField.text;
            self.lengthIsChanged = YES;
            break;
        case 201:
            self.mainM.kuandu = textField.text;
            break;
        case 202:
            self.mainM.shuliang = textField.text;
            break;
        default:
            break;
    }
    if (self.mainBlock) {
        self.mainBlock(self.mainM, self.lengthIsChanged);
    }
    
}

- (IBAction)rightTap:(UITapGestureRecognizer *)sender {
    if ([self.mainM.changdu integerValue] <150 && [self.mainM.kuandu integerValue]<150) {
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"长宽都大于150才能选择优切" time:0 aboutType:WHShowViewMode_Text state:NO];
        return;
    }
    
    self.rightImgv.hidden = NO;
    self.leftImgv.hidden = YES;
    
    self.right_top_Label.textColor = [UIColor mianColor:2];
    self.right_down_Label.textColor  =[UIColor mianColor:2];
    self.left_top_Label.textColor = [UIColor mianColor:3];
    self.left_down_Label.textColor = [UIColor mianColor:3];
    
    self.lengthTF.userInteractionEnabled = YES;
    
    if (self.click) {
        self.click(@"优切");
    }
}


- (IBAction)hbhb:(UITapGestureRecognizer *)sender {
    self.rightImgv.hidden = YES;
    self.leftImgv.hidden = NO;
    
    self.right_top_Label.textColor = [UIColor mianColor:3];
    self.right_down_Label.textColor  =[UIColor mianColor:3];
    self.left_top_Label.textColor = [UIColor mianColor:2];
    self.left_down_Label.textColor = [UIColor mianColor:2];
    
    self.lengthTF.userInteractionEnabled = NO;
    self.rightCountLabel.text = @"0 元";
    if (self.click) {
        self.click(@"快速");
    }
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


- (void)loadData:(NSObject *)data andCliker:(ClikBlock)click andMainBlock:(JudgeBlock)mainB {
    self.click = click;
    self.mainBlock = mainB;
    
    
}

@end
