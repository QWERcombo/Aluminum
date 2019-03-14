//
//  InviteNumberVC.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/10/18.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "InviteNumberVC.h"

@interface InviteNumberVC ()
@property (weak, nonatomic) IBOutlet UITextField *inviteTF;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@end

@implementation InviteNumberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.showType == ShowType_Invite) {
        self.title = @"推荐人";
        self.inviteTF.placeholder = @"请输入专属客服手机号";
    } else {
        self.title = @"设置密码";
        self.inviteTF.placeholder = @"请设置账号密码";
    }
    self.submitBtn.layer.cornerRadius = 4;
    self.submitBtn.layer.masksToBounds = YES;
    self.closeBtn.layer.cornerRadius = 4;
    self.closeBtn.layer.masksToBounds = YES;
    [self.inviteTF setValue:[UIFont systemFontOfSize:20 weight:UIFontWeightBold] forKeyPath:@"_placeholderLabel.font"];
    [self.inviteTF setValue:[UIColor colorWithHexString:@"#CED4DA"] forKeyPath:@"_placeholderLabel.textColor"];
}

#pragma mark - Table view data source

- (IBAction)submit:(UIButton *)sender {
    
    if (self.showType == ShowType_Invite) {
        //推荐人
        if (![[UtilsData sharedInstance] isHasValue:self.inviteTF.text]) {
            [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请输入推荐人手机号" time:0 aboutType:WHShowViewMode_Text state:NO];
            return;
        }
        NSMutableDictionary *parDic = [NSMutableDictionary dictionary];
        [parDic setObject:self.inviteTF.text forKey:@"promotePhone"];
        [parDic setObject:[UserData currentUser].user_id forKey:@"userId"];
        
        [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:parDic imageArray:nil WithType:Interface_updatePromotePhone andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
            
            [self dismissViewControllerAnimated:YES completion:^{
            }];
            
        } failure:^(NSString *error, NSInteger code) {
            
        }];
        
    } else {
        //账号密码
        if (![[UtilsData sharedInstance] isHasValue:self.inviteTF.text]) {
            [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请输入账号密码" time:0 aboutType:WHShowViewMode_Text state:NO];
            return;
        }
        NSMutableDictionary *parDic = [NSMutableDictionary dictionary];
        [parDic setObject:self.inviteTF.text forKey:@"password"];
        [parDic setObject:[UserData currentUser].user_id forKey:@"userId"];
        
        [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:parDic imageArray:nil WithType:Interface_setPassword andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
            
            if (self.callBlock) {
                self.callBlock();
                [self dismissViewControllerAnimated:YES completion:^{
                }];
            }
            
        } failure:^(NSString *error, NSInteger code) {
            
        }];
        
    }
    
}


- (IBAction)close:(UIButton *)sender {
    if (self.callBlock) {
        self.callBlock();
    }
    [self dismissViewControllerAnimated:YES completion:^{
    }];
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
