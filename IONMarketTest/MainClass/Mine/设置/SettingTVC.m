//
//  SettingTVC.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/11/17.
//  Copyright © 2018 赵越. All rights reserved.
//

#import "SettingTVC.h"
#import "TextTableViewController.h"
#import "SettingPayPsdVC.h"

@interface SettingTVC ()
@property (weak, nonatomic) IBOutlet UILabel *versionLab;
@property (weak, nonatomic) IBOutlet UILabel *hintLab;

@end

@implementation SettingTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.title = @"设置";
    self.versionLab.text = [[PublicFuntionTool sharedInstance] getAppVersion];
    self.hintLab.layer.cornerRadius = 10;
    self.hintLab.layer.masksToBounds = YES;
    self.hintLab.textColor = [UIColor whiteColor];
    self.hintLab.backgroundColor = [UIColor Grey_OrangeColor];
}

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TextTableViewController *descri = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"TextTableViewController"];
    if (indexPath.row == 1) {
        descri.title = @"关于我们";
        [self.navigationController pushViewController:descri animated:YES];
    }
    if (indexPath.row == 2) {
        descri.title = @"用户协议";
        [self.navigationController pushViewController:descri animated:YES];
    }
    if (indexPath.row == 3) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APPSTORE_URL]];
    }
    if (indexPath.row == 5) {
        SettingPayPsdVC *payset = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"SettingPayPsdVC"];
        payset.changeType = ChangeType_PayPsd;
        TBNavigationController *nav = [[TBNavigationController alloc] initWithRootViewController:payset];
        [self presentViewController:nav animated:YES completion:^{
        }];
    }
    if (indexPath.row == 7) {
        SettingPayPsdVC *payset = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"SettingPayPsdVC"];
        payset.changeType = ChangeType_LogPsd;
        TBNavigationController *nav = [[TBNavigationController alloc] initWithRootViewController:payset];
        [self presentViewController:nav animated:YES completion:^{
        }];
    }
    
}


- (IBAction)logout:(UIButton *)sender {
    
    [[UtilsData sharedInstance] showAlertControllerWithTitle:@"提示" detail:@"是否确定退出登录" doneTitle:@"确定" cancelTitle:@"取消" haveCancel:YES doneAction:^{
        
        [[UserData currentUser] removeMe];
        [[UtilsData sharedInstance] postLogoutNotice];
        
    } controller:self];
    
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
