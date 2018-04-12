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
        self.changduS = [NSMutableString string];
        self.shuliangS = [NSMutableString string];
        self.kuanduS = [NSMutableString string];
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
            [self.kuanduS replaceCharactersInRange:range withString:string];
            self.mainM.kuandu = self.changduS;
            break;
        case 302:
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
    if ([self.mainM.changdu integerValue] <150 && [self.mainM.kuandu integerValue]<150) {
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"长宽都大于150才能选择优切" time:0 aboutType:WHShowViewMode_Text state:NO];
        return;
    }
    
    self.rightImgv.hidden = NO;
    self.leftImgv.hidden = YES;
    
    self.right_top_Label.textColor = [UIColor mianColor:2];
    self.right_down_Label.textColor  =[UIColor mianColor:2];
    self.left_top_Label.text = @"0元";
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
    
    self.right_top_Label.text = @"0元";
    self.right_top_Label.textColor = [UIColor mianColor:3];
    self.right_down_Label.textColor  =[UIColor mianColor:3];
    self.left_top_Label.textColor = [UIColor mianColor:2];
    self.left_down_Label.textColor = [UIColor mianColor:2];
    
    self.lengthTF.userInteractionEnabled = NO;

    if (self.click) {
        self.click(@"快速");
    }
}


- (IBAction)selectTapAction:(UITapGestureRecognizer *)sender {
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
