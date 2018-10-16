//
//  LoginTVC.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/10/16.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "LoginTVC.h"
#import "TextTableViewController.h"
#import "RegisterTVC.h"

@interface LoginTVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UIView *codeLine;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UIView *accountLIne;
@property (weak, nonatomic) IBOutlet UIButton *accountBtn;
@property (weak, nonatomic) IBOutlet UIImageView *code_img;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UIImageView *psd_img;
@property (weak, nonatomic) IBOutlet UITextField *psdTF;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@end

@implementation LoginTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginBtn.layer.cornerRadius = 4;
    self.loginBtn.layer.masksToBounds = YES;
    [self.loginBtn setEnabled:NO];
    self.loginBtn.backgroundColor = [[UIColor mianColor:2] colorWithAlphaComponent:0.5];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return SCREEN_HEIGHT-64;
}


#pragma mark - Handle
- (IBAction)close:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (IBAction)buttonClicker:(UIButton *)sender {
    
    switch (sender.tag) {
        case 101:
            //短信验证码登录
            self.codeLine.backgroundColor = [UIColor mianColor:2];
            self.codeLabel.textColor = [UIColor mianColor:2];
            self.accountLIne.backgroundColor = [UIColor whiteColor];
            self.accountLabel.textColor = [UIColor colorWithHexString:@"#8D959D"];
            self.psdTF.placeholder = @"请输入验证码";
            self.psdTF.keyboardType = UIKeyboardTypeNumberPad;
            [self.forgetBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [self.forgetBtn setTitleColor:[UIColor mianColor:2] forState:UIControlStateNormal];
            break;
        case 102:
            //账号密码登陆
            self.codeLine.backgroundColor = [UIColor whiteColor];
            self.codeLabel.textColor = [UIColor colorWithHexString:@"#8D959D"];
            self.accountLIne.backgroundColor = [UIColor mianColor:2];
            self.accountLabel.textColor = [UIColor mianColor:2];
            self.psdTF.placeholder = @"请输入登录密码";
            [self.forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
            [self.forgetBtn setTitleColor:[UIColor colorWithHexString:@"#595E64"] forState:UIControlStateNormal];
            break;
        case 103:
            //忘记密码
            [self goToRegister:@"0"];
            break;
        case 104:
            //注册
            [self goToRegister:@"1"];
            break;
        case 105:
            //登陆
            NSLog(@"login");
            [self.view endEditing:YES];
            
            break;
        case 106:
            //用户协议
            [self goToXieyi];
            
            break;
            
        default:
            break;
    }
}
- (void)goToXieyi {
    TextTableViewController *descri = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"TextTableViewController"];
    descri.title = @"用户协议";
    [self.navigationController pushViewController:descri animated:YES];
}
- (void)goToRegister:(NSString *)string {
    
    RegisterTVC *regist = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"RegisterTVC"];
    regist.type = [string integerValue];
    [self.navigationController pushViewController:regist animated:YES];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSMutableString *inputString_phone = [[NSMutableString alloc] initWithString:self.phoneTF.text];
    
    NSMutableString *inputString_code = [[NSMutableString alloc] initWithString:self.psdTF.text];
    
    if (textField == self.phoneTF) {
        
        [inputString_phone replaceCharactersInRange:range withString:string];
        self.code_img.image = inputString_phone.length?[UIImage imageNamed:@"login_account"]:[UIImage imageNamed:@"login_account_0"];
        
    }
    if (textField == self.psdTF) {
        
        [inputString_code replaceCharactersInRange:range withString:string];
        self.psd_img.image = inputString_code.length?[UIImage imageNamed:@"login_psd"]:[UIImage imageNamed:@"login_psd_0"];
    }
    
    if (inputString_phone.length && inputString_code.length) {
        [self.loginBtn setEnabled:YES];
        self.loginBtn.backgroundColor = [UIColor mianColor:2];
    } else {
        [self.loginBtn setEnabled:NO];
        self.loginBtn.backgroundColor = [[UIColor mianColor:2] colorWithAlphaComponent:0.5];
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
