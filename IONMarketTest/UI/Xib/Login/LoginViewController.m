//
//  LoginViewController.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/22.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterTViewController.h"
#import "TextTableViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;

@end

@implementation LoginViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self.phoneTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_PHONE]) {
        
        self.phoneTF.text = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_PHONE];
    }
}

//- (void) textFieldDidChange:(UITextField *)textField
//{
//    NSInteger kMaxLength = 8;
//    NSString *toBeString = textField.text;
//    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage; //ios7之前使用[UITextInputMode currentInputMode].primaryLanguage
//    if ([lang isEqualToString:@"zh-Hans"]) { //中文输入
//        UITextRange *selectedRange = [textField markedTextRange];
//        //获取高亮部分
//        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
//        if (!position) {// 没有高亮选择的字，则对已输入的文字进行字数统计和限制
//            if (toBeString.length > kMaxLength) {
//                textField.text = [toBeString substringToIndex:kMaxLength];
//            }
//        }
//        else{//有高亮选择的字符串，则暂不对文字进行统计和限制
//        }
//    }else{//中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
//        if (toBeString.length > kMaxLength) {
//            textField.text = [toBeString substringToIndex:kMaxLength];
//        }
//    }
//}

//登陆
- (IBAction)loginAction:(UIButton *)sender {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:self.phoneTF.text forKey:@"phone"];
    [dict setValue:self.codeTF.text forKey:@"password"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_Login andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
//        NSLog(@"++++%@", resultDic);
        [[UserData currentUser] giveData:resultDic[@"user"]];
        
        //用户手机号存本地
        NSString *login_phone = [[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_PHONE];
        if (![login_phone isEqualToString:self.phoneTF.text]) {
            
            [[NSUserDefaults standardUserDefaults] setObject:self.phoneTF.text forKey:LOGIN_PHONE];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        
        [[UtilsData sharedInstance] postLoginNotice];
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}

//忘记密码
- (IBAction)forgetAction:(UIButton *)sender {
//    NSLog(@"%@", sender.currentTitle);
    RegisterTViewController *regist = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"RegisterTVC"];
    regist.registerType = @"forget";
    [self.navigationController pushViewController:regist animated:YES];
}

//注册
- (IBAction)registerAction:(UIButton *)sender {
//    NSLog(@"%@", sender.currentTitle);
    RegisterTViewController *regist = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"RegisterTVC"];
    regist.registerType = @"register";
    [self.navigationController pushViewController:regist animated:YES];
}

//用户协议
- (IBAction)yonghuxieyi:(UIButton *)sender {
    
    TextTableViewController *descri = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"TextTableViewController"];
    descri.title = @"用户协议";
    [self.navigationController pushViewController:descri animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
