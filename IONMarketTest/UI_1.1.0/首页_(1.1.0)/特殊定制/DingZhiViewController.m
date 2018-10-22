//
//  DingZhiViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/10/19.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "DingZhiViewController.h"

@interface DingZhiViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *inoutTextView;
@property (weak, nonatomic) IBOutlet UILabel *placeHolderLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (nonatomic, copy) NSString *inputString;
@end

@implementation DingZhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"特殊定制";
    self.placeHolderLabel.text = @"特殊定制";
    self.submitBtn.layer.cornerRadius = 4;
    self.submitBtn.layer.masksToBounds = YES;
    self.submitBtn.enabled = NO;
    self.submitBtn.backgroundColor = [[UIColor mianColor:2] colorWithAlphaComponent:.5];
}


- (IBAction)submit:(UIButton *)sender {
    [self.view endEditing:YES];
    self.inputString = self.inoutTextView.text;
    [self.inoutTextView setText:@""];
    [self.placeHolderLabel setText:self.inputString];
    [self textViewDidChange:self.inoutTextView];
}

- (void)textViewDidChange:(UITextView *)textView {
    
    self.placeHolderLabel.hidden = textView.text.length;
    
    if (textView.text.length) {
        self.submitBtn.enabled = YES;
        self.submitBtn.backgroundColor = [UIColor mianColor:2] ;
    } else {
        self.submitBtn.enabled = NO;
        self.submitBtn.backgroundColor = [[UIColor mianColor:2] colorWithAlphaComponent:.5];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
