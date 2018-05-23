//
//  LoginViewController.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/22.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterTViewController.h"

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
//    [dict setValue:@"13407126200" forKey:@"phone"];
//    [dict setValue:@"12345678" forKey:@"password"];
    [dict setValue:@"13164628130" forKey:@"phone"];
    [dict setValue:self.codeTF.text forKey:@"password"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_Login andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
//        NSLog(@"++++%@", resultDic);
        [[UserData currentUser] giveData:resultDic[@"user"]];
        
        [[UtilsData sharedInstance] postLoginNotice];
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}

//忘记密码
- (IBAction)forgetAction:(UIButton *)sender {
    NSLog(@"%@", sender.currentTitle);
    RegisterTViewController *regist = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"RegisterTVC"];
    regist.registerType = @"forget";
    [self.navigationController pushViewController:regist animated:YES];
}

//注册
- (IBAction)registerAction:(UIButton *)sender {
    NSLog(@"%@", sender.currentTitle);
    RegisterTViewController *regist = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"RegisterTVC"];
    regist.registerType = @"register";
    [self.navigationController pushViewController:regist animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
