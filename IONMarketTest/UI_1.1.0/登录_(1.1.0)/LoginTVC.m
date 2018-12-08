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
#import "InviteNumberVC.h"

typedef NS_ENUM(NSUInteger, LoginType) {
    LoginType_Code,     //短信登陆
    LoginType_Account,  //账号登陆
};


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

@property (nonatomic, assign) LoginType loginType;

@end

@implementation LoginTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loginBtn.layer.cornerRadius = 4;
    self.loginBtn.layer.masksToBounds = YES;
    [self.loginBtn setEnabled:NO];
    self.loginBtn.backgroundColor = [[UIColor mianColor:2] colorWithAlphaComponent:0.5];
    self.loginType = LoginType_Account;
    self.psdTF.secureTextEntry = YES;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_PHONE]) {
        self.phoneTF.text = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_PHONE];
        self.code_img.image = [UIImage imageNamed:@"login_account"];
    }
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
            self.psdTF.secureTextEntry = NO;
            self.psdTF.keyboardType = UIKeyboardTypeNumberPad;
            [self.forgetBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            [self.forgetBtn setTitleColor:[UIColor mianColor:2] forState:UIControlStateNormal];
            self.loginType = LoginType_Code;
            self.psdTF.text = @"";
            break;
        case 102:
            //账号密码登陆
            self.codeLine.backgroundColor = [UIColor whiteColor];
            self.codeLabel.textColor = [UIColor colorWithHexString:@"#8D959D"];
            self.accountLIne.backgroundColor = [UIColor mianColor:2];
            self.accountLabel.textColor = [UIColor mianColor:2];
            self.psdTF.placeholder = @"请输入登录密码";
            self.psdTF.secureTextEntry = YES;
            self.psdTF.keyboardType = UIKeyboardTypeASCIICapable;
            [self.forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
            [self.forgetBtn setTitleColor:[UIColor colorWithHexString:@"#595E64"] forState:UIControlStateNormal];
            self.loginType = LoginType_Account;
            self.psdTF.text = @"";
            break;
        case 103:
            
            if ([sender.currentTitle isEqualToString:@"忘记密码"]) {
                //忘记密码
                [self goToRegister:@"0"];
            } else {
                //获取验证码
                [self getPhoneCode:sender];
            }
            break;
        case 104:
            //注册
            [self goToRegister:@"1"];
            break;
        case 105:
            //登陆
            [self goToLogin];
            
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

- (void)getPhoneCode:(UIButton *)sender {
    
    [self.view endEditing:YES];
    if (![self.phoneTF.text isValidateMobile]) {
        [[UtilsData sharedInstance] showAlertTitle:@"提示" detailsText:@"请输入正确的手机号" time:2.0 aboutType:WHShowViewMode_Text state:NO];
        return;
    }
    [self startTimer:sender];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:self.phoneTF.text forKey:@"phone"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_SendMsg andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        //NSLog(@"%@", resultDic);
    } failure:^(NSString *error, NSInteger code) {
        
    }];
}

- (void)startTimer:(UIButton *)btnCoder
{
    self.codeBtn.enabled = NO;
    __block int timeout = 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.codeBtn.enabled = YES;
                [btnCoder setTitle:@"重新发送" forState:UIControlStateNormal];
            });
        }else{
            //            int minutes = timeout / 60;
            NSString *strTime = [NSString stringWithFormat:@"%d 秒",timeout];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [btnCoder setTitle:strTime forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (void)goToLogin {
    
    [self.view endEditing:YES];
    
    if (self.loginType == LoginType_Account) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:self.phoneTF.text forKey:@"phone"];
        [dict setValue:self.psdTF.text forKey:@"password"];
        [dict setValue:[self getLastVersion] forKey:@"lastVersion"];
//        [dict setValue:@"v110" forKey:@"lastVersion"];
        
        [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_Login andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
            //NSLog(@"++++%@", resultDic);
            //用户手机号存本地
            NSString *login_phone = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_PHONE];
            if (![login_phone isEqualToString:self.phoneTF.text]) {
                [[NSUserDefaults standardUserDefaults] setObject:self.phoneTF.text forKey:LOGIN_PHONE];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            
            [[UserData currentUser] giveData:resultDic[@"user"]];
//            [[UserData currentUser] giveData:@{@"isCheck":[NSString stringWithFormat:@"%@", resultDic[@"isCheck"]]}];
            [[UserData currentUser] giveData:@{@"isCheck":@"1"}];
            //[[UtilsData sharedInstance] postLoginNotice];
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
            
        } failure:^(NSString *error, NSInteger code) {
            
        }];
    } else {
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:self.phoneTF.text forKey:@"phone"];
        [dict setValue:self.psdTF.text forKey:@"number"];
        [dict setValue:[self getLastVersion] forKey:@"lastVersion"];
        
        [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_loginByCode andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
            //用户手机号存本地
            NSString *login_phone = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_PHONE];
            if (![login_phone isEqualToString:self.phoneTF.text]) {
                [[NSUserDefaults standardUserDefaults] setObject:self.phoneTF.text forKey:LOGIN_PHONE];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            [[UserData currentUser] giveData:resultDic[@"user"]];
            [[UserData currentUser] giveData:@{@"isCheck":@"1"}];
            
            
            NSString *userRegisterFlag = [resultDic objectForKey:@"userRegisterFlag"];
            
            if ([userRegisterFlag integerValue]==1) {
                //老用户不跳
                [self dismissViewControllerAnimated:YES completion:^{
                }];
            } else {
                //新用户跳转推荐人
                InviteNumberVC *invite = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"InviteNumberVC"];
                invite.showType = ShowType_Invite;
                [self.navigationController pushViewController:invite animated:YES];
            }
            
        } failure:^(NSString *error, NSInteger code) {
            
        }];
        
    }
    
}
- (NSString *)getLastVersion {
    
    NSString *lastVersion = [[[[PublicFuntionTool sharedInstance] getAppVersion] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]] componentsJoinedByString:@""];
    
    return [NSString stringWithFormat:@"v%@", lastVersion];
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
