//
//  RegisterTViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/4/12.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "RegisterTViewController.h"

@interface RegisterTViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

@end

@implementation RegisterTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    UIImageView *backImgv = [[UIImageView alloc] initWithFrame:self.tableView.bounds];
    backImgv.image = IMG(@"Login_bg");
    self.tableView.backgroundView = backImgv;
    self.codeBtn.layer.masksToBounds = YES;
    self.codeBtn.layer.cornerRadius = 5;
}

- (IBAction)codeClicker:(UIButton *)sender {
    [self.view endEditing:YES];
    if (![self.phoneTF.text isValidateMobile]) {
        [[UtilsData sharedInstance] showAlertTitle:@"提示" detailsText:@"请输入正确的手机号" time:2.0 aboutType:WHShowViewMode_Text state:NO];
        return;
    }
    [self startTimer:sender];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:self.phoneTF.text forKey:@"phone"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_SendMsg andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
//        NSLog(@"%@", resultDic);
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}



- (IBAction)registerClicker:(UIButton *)sender {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:self.phoneTF.text forKey:@"phone"];
    [dict setValue:self.codeTF.text forKey:@"number"];
    [dict setValue:self.passwordTF.text forKey:@"password1"];
    [dict setValue:self.confirmTF.text forKey:@"password2"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_Register andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"%@", resultDic);
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"注册成功！请重新登录" time:0 aboutType:WHShowViewMode_Text state:YES];
        [self.navigationController popViewControllerAnimated:YES];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



@end
