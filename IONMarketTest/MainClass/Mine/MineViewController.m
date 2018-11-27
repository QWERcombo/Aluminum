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
#import "WhiteBarVC.h"
#import "SettingTVC.h"


@interface MineViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *userHeader;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userRole;
@property (nonatomic, strong) NSArray *titleArr;
@end

@implementation MineViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.userHeader sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BASE_URL_IMAGE, [UserData currentUser].headImgUrl]] placeholderImage:IMG(@"head_default")];
    self.userHeader.contentMode = UIViewContentModeScaleAspectFill;
    self.userHeader.layer.cornerRadius = self.userHeader.frame.size.width/2;
    self.userHeader.layer.masksToBounds = YES;
    
    self.userName.text = [UserData currentUser].name;
    self.userRole.text = [UserData currentUser].renzheng.length ? [UserData currentUser].renzheng : @"未认证";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleArr = @[@"用户信息",@"",@"钱包",@"白条",@"开票",@"企业认证",@"",@"收货地址",@"分享推广",@"设置"];
    
    self.title = @"我的";
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.userHeader.layer.cornerRadius = 35;
    self.userHeader.layer.masksToBounds = YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSArray *classArray = @[[UserInfoViewController class],@"",[WalletViewController class],[WhiteBarViewController class],[TicketViewController class],[AuthenticationTableViewController class],@"",[AddressViewController class],[ShareViewController class],[SettingTableViewController class]];
    
    if (indexPath.row == 10) {
        NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", @"0510-88996061"];
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
    } else if (indexPath.row == 3) {//白条

        [self goToBaitiao];
        
    } else if (indexPath.row == 4) {//开票
        TicketViewController *share = [[UIStoryboard storyboardWithName:@"Common" bundle:nil] instantiateViewControllerWithIdentifier:@"TicketViewController"];
        [self.navigationController pushViewController:share animated:YES];
    } else if (indexPath.row == 9) {//设置
        SettingTVC *setting = [[UIStoryboard storyboardWithName:@"Common" bundle:nil] instantiateViewControllerWithIdentifier:@"SettingTVC"];
        [self.navigationController pushViewController:setting animated:YES];
    } else if (indexPath.row == 2) {//钱包
        WalletViewController *wallet = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"WalletViewController"];
        [self.navigationController pushViewController:wallet animated:YES];
    }
    else {
        UIViewController *nextController = (UIViewController *)[[NSClassFromString(NSStringFromClass([classArray objectAtIndex:indexPath.row])) alloc] init];
        nextController.title = [self.titleArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:nextController animated:YES];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 2) {
        
//        return [[UserData currentUser].isCheck integerValue]==0?0:50;
        return 50;
    } else {
        if (indexPath.row == 0) {
            return 120;
        } else if (indexPath.row == 1 || indexPath.row == 6) {
            return 10;
        } else {
            return 50;
        }
    }
    
}

- (void)goToBaitiao {
    
//    if ([[UserData currentUser].baitiaoprocess integerValue] != 2) {
    
        WhiteBarViewController *whiteBar = [WhiteBarViewController new];
        whiteBar.title = @"白条";
        [self.navigationController pushViewController:whiteBar animated:YES];
        
//    } else {
//
//        WhiteBarVC *share = [[UIStoryboard storyboardWithName:@"Common" bundle:nil] instantiateViewControllerWithIdentifier:@"WhiteBarVC"];
//        [self.navigationController pushViewController:share animated:YES];
//    }
    
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
