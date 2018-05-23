//
//  MineViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/8.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "MineViewController.h"
#import "MineDescrController.h"
#import "UserInfoViewController.h"
#import "WalletViewController.h"
#import "WhiteBarViewController.h"
#import "TicketViewController.h"
#import "AddressViewController.h"
#import "BankCardViewController.h"
#import "ShareViewController.h"
#import "SettingTableViewController.h"
#import "AuthenticationTableViewController.h"

@interface MineViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *userHeader;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userRole;
@property (nonatomic, strong) NSArray *titleArr;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleArr = @[@"用户信息",@"",@"钱包",@"白条",@"开票",@"企业认证",@"",@"收货地址",@"分享推广",@"设置"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.userName.text = [UserData currentUser].phone;
    self.userRole.text = @"未认证";
    self.userHeader.layer.cornerRadius = 35;
    self.userHeader.layer.masksToBounds = YES;
    [self.userHeader sd_setImageWithURL:[NSURL URLWithString:[UserData currentUser].headImgUrl] placeholderImage:IMG(@"empty_image")];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSArray *classArray = @[[UserInfoViewController class],@"",[WalletViewController class],[WhiteBarViewController class],[TicketViewController class],[AuthenticationTableViewController class],@"",[AddressViewController class],[ShareViewController class],[SettingTableViewController class]];
    
    if (indexPath.row == 10) {
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", @"13372118858"];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
        }
    } else if (indexPath.row == 0) {
        UserInfoViewController *userInfo = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"UserInfoViewController"];
        userInfo.title = [self.titleArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:userInfo animated:YES];
    } else if (indexPath.row == 5) {
        AuthenticationTableViewController *auth = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"AuthenVC"];
        [self.navigationController pushViewController:auth animated:YES];
    } else if (indexPath.row == 8) {
        ShareViewController *share = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ShareVC"];
        [self.navigationController pushViewController:share animated:YES];
    } else {
        UIViewController *nextController = (UIViewController *)[[NSClassFromString(NSStringFromClass([classArray objectAtIndex:indexPath.row])) alloc] init];
        nextController.title = [self.titleArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:nextController animated:YES];
    }
    
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
