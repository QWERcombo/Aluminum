//
//  SettingTableViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/14.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "SettingTableViewController.h"
#import "TextTableViewController.h"
#import "ChangeCodeViewController.h"

@interface SettingTableViewController ()
@property (nonatomic, strong) NSArray *titleArr;
@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArr = @[@"关于我们",@"密码修改",@"清理缓存",@"用户协议",@"退出登录"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [self.titleArr objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor mianColor:2];
    NSString *imageName = [NSString stringWithFormat:@"Settings_%ld", indexPath.row];
    cell.imageView.image = IMG(imageName);

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TextTableViewController *descri = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"TextTableViewController"];
    ChangeCodeViewController *code = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ChangeCodeViewController"];
    if (indexPath.row==0) {
        descri.title = [self.titleArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:descri animated:YES];
    } else if (indexPath.row==1) {
        code.title = [self.titleArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:code animated:YES];
    } else if (indexPath.row==2) {
        [[UtilsData sharedInstance] showAlertControllerWithTitle:@"提示" detail:@"是否确定清理缓存" doneTitle:@"确定" cancelTitle:@"取消" haveCancel:YES doneAction:^{
            
        } controller:self];
    } else if (indexPath.row==3) {
        descri.title = [self.titleArr objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:descri animated:YES];
    } else if (indexPath.row==4) {
        [[UtilsData sharedInstance] showAlertControllerWithTitle:@"提示" detail:@"是否确定退出登录" doneTitle:@"确定" cancelTitle:@"取消" haveCancel:YES doneAction:^{
            
            [[UserData currentUser] removeMe];
            [[UtilsData sharedInstance] postLogoutNotice];
            
        } controller:self];
    } else {
        
    }
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
