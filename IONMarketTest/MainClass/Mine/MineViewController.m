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



@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *titleArr;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleArr = @[@"钱包",@"白条",@"开票",@"收货地址",@"银行卡",@"分享推广",@"设置"];
    self.tabView.backgroundColor = [UIColor mianColor:1];
    [self.view addSubview:self.tabView];
    [self.tabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"BasicCell"];
    
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
}


#pragma mark --- Delegate&DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section==0?0:7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *IDs = @"BasicCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:IDs];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor = [UIColor mianColor:2];
    cell.textLabel.text = [self.titleArr objectAtIndex:indexPath.row];
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self createUserView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section==0?120:0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MineDescrController *descri =[MineDescrController new];
    descri.titleStr = [self.titleArr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:descri animated:YES];
}




#pragma mark ---- subviews
- (UIView *)createUserView {
    UIView *userVIew = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 120)];
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 110)];
    contentView.backgroundColor = [UIColor whiteColor];
    [userVIew addSubview:contentView];
    
    UIImageView *user_imgv = [[UIImageView alloc] init];
    user_imgv.layer.cornerRadius = 30;
    user_imgv.backgroundColor = [UIColor mianColor:2];
    user_imgv.clipsToBounds = YES;
    [contentView addSubview:user_imgv];
    [user_imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(60));
        make.left.equalTo(userVIew.mas_left).offset(20);
        make.centerY.equalTo(userVIew.mas_centerY);
    }];
    
    UILabel *nameLabel = [UILabel lableWithText:@"用户名称" Font:FONT_ArialMT(16) TextColor:[UIColor mianColor:2]];
    [contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(user_imgv.mas_right).offset(15);
        make.top.equalTo(user_imgv.mas_top);
        make.height.equalTo(@(16));
    }];
    
    UILabel *statusLabel = [UILabel lableWithText:@"认证状态" Font:FONT_ArialMT(17) TextColor:[UIColor mianColor:2]];
    [contentView addSubview:statusLabel];
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(17));
        make.left.equalTo(nameLabel.mas_left);
        make.bottom.equalTo(user_imgv.mas_bottom);
    }];
    
    UITapGestureRecognizer *userInfo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goIntoUserInfo)];
    [userVIew addGestureRecognizer:userInfo];
    
    return userVIew;
}

#pragma mark ---- Action
- (void)goIntoUserInfo {
    UserInfoViewController *descri =[UserInfoViewController new];
    descri.titleStr = @"个人资料";
    [self.navigationController pushViewController:descri animated:YES];
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
