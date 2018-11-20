//
//  ChangeCodeViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/14.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "ChangeCodeViewController.h"

@interface ChangeCodeViewController ()

@property (weak, nonatomic) IBOutlet UITextField *oldTF;
@property (weak, nonatomic) IBOutlet UITextField *theNewTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmTF;

@end

@implementation ChangeCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}



#pragma mark --- tfdelegate
- (IBAction)changeCode:(UIButton *)sender {
    
    if (!self.oldTF.text.length || !self.theNewTF.text.length || !self.confirmTF.text.length) {
        
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请正确填写信息!" time:0 aboutType:WHShowViewMode_Text state:NO];
        return;
    }
    
    
    __weak typeof(self) weakself = self;
    
    [[UtilsData sharedInstance] showAlertControllerWithTitle:@"提示" detail:@"是否确定修改密码" doneTitle:@"确定" cancelTitle:@"取消" haveCancel:YES doneAction:^{
        
        NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
        [dataDic setValue:self.oldTF.text forKey:@"oldPassword"];
        [dataDic setValue:self.theNewTF.text forKey:@"newPassword1"];
        [dataDic setValue:self.confirmTF.text forKey:@"newPassword2"];
        [dataDic setValue:[UserData currentUser].user_id forKey:@"userId"];
        
        [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dataDic imageArray:nil WithType:Interface_changePassword andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
            [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"修改成功!" time:2 aboutType:WHShowViewMode_Text state:YES];
            [weakself.navigationController popViewControllerAnimated:YES];
        } failure:^(NSString *error, NSInteger code) {
            
        }];
        
    } controller:self];
    
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
