//
//  SettingPayPsdVC.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/10/29.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "SettingPayPsdVC.h"

@interface SettingPayPsdVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *psdTF;
@property (weak, nonatomic) IBOutlet UIImageView *psd_img;
@property (weak, nonatomic) IBOutlet UIImageView *code_img;
@property (weak, nonatomic) IBOutlet UIImageView *phone_img;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

@end

@implementation SettingPayPsdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置支付密码";
    self.doneBtn.layer.cornerRadius = 4;
    self.doneBtn.layer.masksToBounds = YES;
    [self.doneBtn setEnabled:NO];
    self.doneBtn.backgroundColor = [[UIColor mianColor:2] colorWithAlphaComponent:0.5];
}

#pragma mark - Table view data source

- (IBAction)close:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)done:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)code:(UIButton *)sender {
    
    
}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSMutableString *inputString_phone = [[NSMutableString alloc] initWithString:self.phoneTF.text];
    NSMutableString *inputString_code = [[NSMutableString alloc] initWithString:self.codeTF.text];
    NSMutableString *inputString_psd = [[NSMutableString alloc] initWithString:self.psdTF.text];
    
    if (textField == self.phoneTF) {
        
        [inputString_phone replaceCharactersInRange:range withString:string];
        self.phone_img.image = inputString_phone.length?[UIImage imageNamed:@"login_account"]:[UIImage imageNamed:@"login_account_0"];
    }
    if (textField == self.codeTF) {
        
        [inputString_code replaceCharactersInRange:range withString:string];
        self.code_img.image = inputString_code.length?[UIImage imageNamed:@"login_psd"]:[UIImage imageNamed:@"login_psd_0"];
    }
    if (textField == self.psdTF) {
        
        [inputString_psd replaceCharactersInRange:range withString:string];
        self.psd_img.image = inputString_psd.length?[UIImage imageNamed:@"login_psd"]:[UIImage imageNamed:@"login_psd_0"];
    }
    
    
    if (inputString_phone.length && inputString_code.length && inputString_psd.length) {
        [self.doneBtn setEnabled:YES];
        self.doneBtn.backgroundColor = [UIColor mianColor:2];
    } else {
        [self.doneBtn setEnabled:NO];
        self.doneBtn.backgroundColor = [[UIColor mianColor:2] colorWithAlphaComponent:0.5];
    }
    
    return YES;
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
