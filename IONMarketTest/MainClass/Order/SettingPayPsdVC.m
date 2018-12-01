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
@property (weak, nonatomic) IBOutlet UILabel *showLabel;

@end

@implementation SettingPayPsdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    switch (_changeType) {
        case ChangeType_None:
            self.title = @"设置支付密码";
            [self.doneBtn setTitle:@"设置" forState:UIControlStateNormal];
            break;
        case ChangeType_PayPsd:
            self.title = @"修改支付密码";
            [self.doneBtn setTitle:@"提交" forState:UIControlStateNormal];
            break;
        case ChangeType_LogPsd:
            self.title = @"修改登录密码";
            [self.doneBtn setTitle:@"提交" forState:UIControlStateNormal];
            self.psdTF.placeholder = @"请输入登陆密码";
            self.showLabel.text = @"*登录密码8-16个数字和字母组成";
            break;
        default:
            break;
    }
    
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
    
    switch (_changeType) {
        case ChangeType_None:
            [self uploadDataWithType:ChangeType_None];
            break;
        case ChangeType_PayPsd:
            [self uploadDataWithType:ChangeType_PayPsd];
            break;
        case ChangeType_LogPsd:
            [self uploadDataWithType:ChangeType_LogPsd];
            break;
        default:
            break;
    }
    
    
}

- (void)uploadDataWithType:(NSInteger)type {
    
    if (type==ChangeType_None) {
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:self.phoneTF.text forKey:@"phone"];
        [dict setValue:self.codeTF.text forKey:@"number"];
        [dict setValue:self.psdTF.text forKey:@"payPassword"];
        
        [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_setPayPassword andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
            //NSLog(@"%@", resultDic);
            [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"设置成功" time:0 aboutType:WHShowViewMode_Text state:YES];
            [[UserData currentUser] giveData:@{@"zhifumima":@"123456"}];
            [self dismissViewControllerAnimated:YES completion:^{
                if (self.delegate && [self.delegate respondsToSelector:@selector(settingPayPsdFinish)]) {
                    [self.delegate settingPayPsdFinish];
                }
            }];
        } failure:^(NSString *error, NSInteger code) {
            
        }];
    } else if (type == ChangeType_LogPsd) {
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:self.phoneTF.text forKey:@"phone"];
        [dict setValue:self.codeTF.text forKey:@"number"];
        [dict setValue:self.psdTF.text forKey:@"password1"];
        
        [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_Forget andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
            //NSLog(@"%@", resultDic);
            [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"修改成功" time:0 aboutType:WHShowViewMode_Text state:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        } failure:^(NSString *error, NSInteger code) {
            
        }];
    } else if (type == ChangeType_PayPsd) {
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:self.phoneTF.text forKey:@"phone"];
        [dict setValue:self.codeTF.text forKey:@"number"];
        [dict setValue:self.psdTF.text forKey:@"payPassword"];
        
        [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_setPayPassword andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
            //NSLog(@"%@", resultDic);
            [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"修改成功" time:0 aboutType:WHShowViewMode_Text state:YES];
            [[UserData currentUser] giveData:@{@"zhifumima":@"123456"}];
            [self dismissViewControllerAnimated:YES completion:nil];
        } failure:^(NSString *error, NSInteger code) {
            
        }];
    } else {
        
    }
}

- (IBAction)code:(UIButton *)sender {
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
