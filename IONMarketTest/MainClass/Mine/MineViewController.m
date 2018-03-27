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

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *imageArr;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleArr = @[@[@"钱包",@"白条",@"开票"],@[@"收货地址",@"银行卡"],@[@"分享推广",@"设置"]];
    self.imageArr = @[@[@"Mine_item_0",@"Mine_item_1",@"Mine_item_2"],@[@"Mine_item_3",@"Mine_item_4"],@[@"Mine_item_5",@"Mine_item_6"]];
    self.tabView.backgroundColor = [UIColor mianColor:1];
    [self.view addSubview:self.tabView];
    [self.tabView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"BasicCell"];
    self.tabView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tabView.tableFooterView = [UIView new];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
}


#pragma mark --- Delegate&DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 0;
    } else if (section==1) {
        return 3;
    } else if (section==2) {
        return 2;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *IDs = @"BasicCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:IDs];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor = [UIColor Black_WordColor];
    cell.imageView.image = [UIImage imageNamed:[self.imageArr objectAtIndex:indexPath.section-1][indexPath.row]];
    cell.textLabel.text = [self.titleArr objectAtIndex:indexPath.section-1][indexPath.row];
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return section==0?[self createUserView]:nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section==0?120:10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==3 && indexPath.row==0) {
        
        ShareViewController *share = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ShareVC"];
        [self.navigationController pushViewController:share animated:YES];
    } else {
        
        NSArray *classArray = @[@[[WalletViewController class],[WhiteBarViewController class],[TicketViewController class]],@[[AddressViewController class],[BankCardViewController class]],@[[ShareViewController class],[SettingTableViewController class]]];
        NSArray *sectionArray = [classArray objectAtIndex:indexPath.section-1];
        
        UIViewController *nextController = (UIViewController *)[[NSClassFromString(NSStringFromClass([sectionArray objectAtIndex:indexPath.row])) alloc] init];
        nextController.title = [self.titleArr objectAtIndex:indexPath.section-1][indexPath.row];
        [self.navigationController pushViewController:nextController animated:YES];
    }
    
}




#pragma mark ---- subviews
- (UIView *)createUserView {
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 120)];
    contentView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *user_imgv = [[UIImageView alloc] init];
    user_imgv.layer.cornerRadius = 30;
    user_imgv.clipsToBounds = YES;
    [contentView addSubview:user_imgv];
    [user_imgv sd_setImageWithURL:URL_STRING([UserData currentUser].headImgUrl)];
    [user_imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(60));
        make.left.equalTo(contentView.mas_left).offset(20);
        make.centerY.equalTo(contentView.mas_centerY);
    }];
    
    UILabel *nameLabel = [UILabel lableWithText:@"用户名称" Font:FONT_BoldMT(16) TextColor:[UIColor mianColor:2]];
    [contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(user_imgv.mas_right).offset(15);
        make.top.equalTo(user_imgv.mas_top).offset(8);
        make.height.equalTo(@(16));
    }];
    
    
    NSString *statusStr = @"已认证";
    UILabel *statusLabel = [UILabel lableWithText:statusStr Font:FONT_ArialMT(13) TextColor:[UIColor whiteColor]];
    CGSize labelSize = [UILabel getSizeWithText:statusStr andFont:FONT_ArialMT(13) andSize:CGSizeMake(0, 20)];
    statusLabel.backgroundColor = [UIColor mianColor:2];
    statusLabel.layer.cornerRadius = 10;
    statusLabel.layer.masksToBounds = YES;
    statusLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:statusLabel];
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(20));
        make.width.equalTo(@(labelSize.width+20));
        make.left.equalTo(nameLabel.mas_left);
        make.bottom.equalTo(user_imgv.mas_bottom).offset(-8);
    }];
    
    UITapGestureRecognizer *userInfo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goIntoUserInfo)];
    [contentView addGestureRecognizer:userInfo];
    
    return contentView;
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
