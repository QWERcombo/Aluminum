//
//  UserInfoViewController.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/12.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoSettingViewController.h"

@interface UserInfoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *userHeader;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userPhone;
@property (weak, nonatomic) IBOutlet UILabel *userCompany;
@property (weak, nonatomic) IBOutlet UILabel *userRole;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.userName.text = [UserData currentUser].nickname;
    self.userRole.text = [UserData currentUser].zhiwei;
    self.userCompany.text = [UserData currentUser].company;
    self.userPhone.text = [UserData currentUser].phone;
    [self.userHeader sd_setImageWithURL:[NSURL URLWithString:[UserData currentUser].headImgUrl] placeholderImage:IMG(@"empty_image")];
    self.userHeader.layer.masksToBounds = YES;
    self.userHeader.layer.cornerRadius = 20;
}

#pragma mark --- Delegate&DataSource
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    UserInfoSettingViewController *setting = [UserInfoSettingViewController new];
//    [self.navigationController pushViewController:setting animated:YES];
//}



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
