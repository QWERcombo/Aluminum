//
//  RegisterTVC.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/10/16.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "RegisterTVC.h"

@interface RegisterTVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *phone_img;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UIImageView *code_img;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIImageView *psd_img;
@property (weak, nonatomic) IBOutlet UITextField *psdTF;
@property (weak, nonatomic) IBOutlet UIImageView *invite_img;
@property (weak, nonatomic) IBOutlet UITextField *inviteTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;

@end

@implementation RegisterTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.type == FromVCType_forget) {
        self.title = @"忘记密码";
        [self.doneBtn setTitle:@"提交" forState:UIControlStateNormal];
    } else {
        self.title = @"注册";
        [self.doneBtn setTitle:@"注册" forState:UIControlStateNormal];
    }
    self.doneBtn.layer.cornerRadius = 4;
    self.doneBtn.layer.masksToBounds = YES;
    [self.doneBtn setEnabled:NO];
    self.doneBtn.backgroundColor = [[UIColor mianColor:2] colorWithAlphaComponent:0.5];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == FromVCType_forget) {
        
        return indexPath.row==1?0:UITableViewAutomaticDimension;
    } else {
        
        return UITableViewAutomaticDimension;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSMutableString *inputString_phone = [[NSMutableString alloc] initWithString:self.phoneTF.text];
    NSMutableString *inputString_code = [[NSMutableString alloc] initWithString:self.codeTF.text];
    NSMutableString *inputString_psd = [[NSMutableString alloc] initWithString:self.psdTF.text];
    NSMutableString *inputString_invite = [[NSMutableString alloc] initWithString:self.inviteTF.text];
    
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
    if (textField == self.inviteTF) {
        
        [inputString_invite replaceCharactersInRange:range withString:string];
        self.invite_img.image = inputString_invite.length?[UIImage imageNamed:@"login_account"]:[UIImage imageNamed:@"login_account_0"];
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

- (IBAction)done:(UIButton *)sender {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:self.phoneTF.text forKey:@"phone"];
    [dict setValue:self.codeTF.text forKey:@"number"];
    [dict setValue:self.psdTF.text forKey:@"password1"];
    [dict setValue:@"123456" forKey:@"password2"];
    if (self.type == FromVCType_regist) {
        //邀请人手机号非必填
        if ([[UtilsData sharedInstance] isHasValue:self.inviteTF.text]) {
            [dict setValue:self.inviteTF.text forKey:@"promotePhone"];
        }
    }
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:self.type == FromVCType_regist?Interface_Register:Interface_Forget andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        //NSLog(@"%@", resultDic);
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:self.type==FromVCType_regist?@"注册成功":@"修改成功" time:0 aboutType:WHShowViewMode_Text state:YES];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}


- (IBAction)getSMSCode:(UIButton *)sender {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
