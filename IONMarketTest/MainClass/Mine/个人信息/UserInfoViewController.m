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

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.titleStr;
    self.dataMuArr = [NSMutableArray arrayWithArray:@[@"头像",@"姓名",@"电话",@"公司",@"职位",@"绑定QQ",@"绑定微信"]];
    [self setSubviews];
}

- (void)setSubviews {
    self.tabView.backgroundColor = [UIColor mianColor:1];
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
}

#pragma mark --- Delegate&DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataMuArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *IDs = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:IDs];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor = [UIColor mianColor:2];
    cell.textLabel.text = [self.dataMuArr objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.dataMuArr objectAtIndex:indexPath.row];
    UIView *line = [[UIView alloc] init];
    [cell.contentView addSubview:line];
    line.backgroundColor = [UIColor mianColor:1];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(1));
        make.left.bottom.equalTo(cell.contentView);
        make.right.equalTo(cell.contentView.mas_right).offset(50);
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UserInfoSettingViewController *setting = [UserInfoSettingViewController new];
    [self.navigationController pushViewController:setting animated:YES];
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
