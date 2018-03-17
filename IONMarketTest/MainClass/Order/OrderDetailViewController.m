//
//  OrderDetailViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/17.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "OrderDetailViewController.h"

@interface OrderDetailViewController ()

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单详情";
    [self setupSubViews];
}

- (void)setupSubViews {
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(self.view);
    }];
}



#pragma mark --- UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==1 || section==2) {
        return 5;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold creatCell:@"OrderDetailCell" table:tableView deledate:self model:nil data:nil andCliker:^(NSDictionary *clueDic) {
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"OrderDetailCell" data:nil model:nil indexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return [self createSectionOneView];
    } else if (section==1) {
        return [self createSectionHeaderView:section];
    } else if (section==2) {
        return [self createSectionHeaderView:section];
    } else {
        return [self createSectionBottomView];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 270;
    } else if (section==1) {
        return 40;
    } else if (section==2) {
        return 40;
    } else {
        return 160;
    }
}

#pragma mark ----- Subviews
- (UIView *)createSectionOneView {
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 270)];
    mainView.backgroundColor = [UIColor mianColor:1];
    
    UIView *expressView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIGHT, 90)];
    expressView.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:expressView];
    UILabel *hint1 = [UILabel lableWithText:@"物流状态" Font:FONT_ArialMT(18) TextColor:[UIColor mianColor:2]];
    [expressView addSubview:hint1];
    [hint1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(18));
        make.left.equalTo(expressView.mas_left).offset(20);
        make.top.equalTo(expressView.mas_top).offset(20);
    }];
    
    UIView *infomationView = [[UIView alloc] initWithFrame:CGRectMake(0, 110, SCREEN_WIGHT, 90)];
    infomationView.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:infomationView];
    UILabel *userLabel = [UILabel lableWithText:@"XXX  186 5227 5886" Font:FONT_ArialMT(18) TextColor:[UIColor mianColor:2]];
    [infomationView addSubview:userLabel];
    [userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infomationView.mas_left).offset(20);
        make.top.equalTo(infomationView.mas_top).offset(15);
    }];
    
    UILabel *addressLabel = [UILabel lableWithText:@"江苏省 苏州市 吴中区 长桥街道\n越湖名邸206" Font:FONT_ArialMT(15) TextColor:[UIColor mianColor:2]];
    addressLabel.numberOfLines = 0;
    [infomationView addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(infomationView.mas_left).offset(20);
        make.top.equalTo(userLabel.mas_bottom).offset(10);
    }];
    
    
    UIView *orderView = [[UIView alloc] initWithFrame:CGRectMake(0, 210, SCREEN_WIGHT, 60)];
    orderView.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:orderView];
    UILabel *orderLabel = [UILabel lableWithText:@"订单编号:1524252\n下单时间:2018-03-16" Font:FONT_ArialMT(15) TextColor:[UIColor mianColor:2]];
    orderLabel.numberOfLines = 0;
    [orderView addSubview:orderLabel];
    [orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(orderView.mas_left).offset(15);
        make.top.equalTo(orderView.mas_top).offset(0);
        make.bottom.equalTo(orderView.mas_bottom).offset(0);
    }];
    
    UIButton *telButton = [UIButton buttonWithTitle:@"联系客服" andFont:FONT_ArialMT(13) andtitleNormaColor:[UIColor mianColor:2] andHighlightedTitle:[UIColor mianColor:2] andNormaImage:nil andHighlightedImage:nil];
    [orderView addSubview:telButton];
    [telButton addTarget:self action:@selector(buttonCliker:) forControlEvents:UIControlEventTouchUpInside];
    [telButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(orderView.mas_right).offset(-15);
        make.top.equalTo(orderView.mas_top).offset(10);
    }];
    
    
    return mainView;
}

- (UIView *)createSectionHeaderView:(NSInteger)section {
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 40)];
    mainView.backgroundColor = [UIColor mianColor:1];
    UIView *vvv = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIGHT, 30)];
    vvv.backgroundColor = [UIColor mianColor:3];
    [mainView addSubview:vvv];
    
    UILabel *label = [UILabel lableWithText:section==0?@"整板":@"零切" Font:FONT_ArialMT(17) TextColor:[UIColor mianColor:2]];
    [vvv addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(vvv.mas_centerY);
        make.left.equalTo(vvv.mas_left).offset(20);
        make.height.equalTo(@(17));
    }];
    
    return mainView;
}

- (UIView *)createSectionBottomView {
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 160)];
    mainView.backgroundColor = [UIColor mianColor:1];
    
    UIView *blank1 = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIGHT, 40)];
    blank1.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:blank1];
    UILabel *label1 = [UILabel lableWithText:@"预计到达时间" Font:FONT_ArialMT(17) TextColor:[UIColor mianColor:2]];
    [blank1 addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(blank1.mas_centerY);
        make.left.equalTo(blank1.mas_left).offset(20);
    }];
    UILabel *label2 = [UILabel lableWithText:@"2018-05-20" Font:FONT_ArialMT(17) TextColor:[UIColor mianColor:2]];
    [blank1 addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(blank1.mas_centerY);
        make.right.equalTo(blank1.mas_right).offset(-20);
    }];
    
    
    
    UIView *blank2 = [[UIView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIGHT, 40)];
    blank2.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:blank2];
    UILabel *label3 = [UILabel lableWithText:@"选择支付方式" Font:FONT_ArialMT(17) TextColor:[UIColor mianColor:2]];
    [blank2 addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(blank2.mas_centerY);
        make.left.equalTo(blank2.mas_left).offset(20);
    }];
    UILabel *label4 = [UILabel lableWithText:@"支付宝" Font:FONT_ArialMT(17) TextColor:[UIColor mianColor:2]];
    [blank2 addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(blank2.mas_centerY);
        make.right.equalTo(blank2.mas_right).offset(-20);
    }];
    
    
    
    UIView *blank3 = [[UIView alloc] initWithFrame:CGRectMake(0, 110, SCREEN_WIGHT, 50)];
    blank3.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:blank3];
    UIButton *downloadButton = [UIButton buttonWithTitle:@"材料证下载" andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor mianColor:2] andHighlightedTitle:[UIColor mianColor:2] andNormaImage:nil andHighlightedImage:nil];
    [blank3 addSubview:downloadButton];
    [downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(blank3.mas_centerY);
        make.left.equalTo(blank3.mas_left).offset(20);
    }];
    [downloadButton addTarget:self action:@selector(downloadAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *buyButton = [UIButton buttonWithTitle:@"再次购买" andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor mianColor:2] andHighlightedTitle:[UIColor mianColor:2] andNormaImage:nil andHighlightedImage:nil];
    [blank3 addSubview:buyButton];
    [buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(blank3.mas_centerY);
        make.right.equalTo(blank3.mas_right).offset(-20);
    }];
    [buyButton addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *serviceButton = [UIButton buttonWithTitle:@"申请售后" andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor mianColor:2] andHighlightedTitle:[UIColor mianColor:2] andNormaImage:nil andHighlightedImage:nil];
    [blank3 addSubview:serviceButton];
    [serviceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(blank3.mas_centerY);
        make.right.equalTo(buyButton.mas_left).offset(-20);
    }];
    [serviceButton addTarget:self action:@selector(serviceAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return mainView;
}

#pragma mark ----- Action
- (void)buttonCliker:(UIButton *)sender {
    NSLog(@"%@", sender.currentTitle);
    
}

- (void)downloadAction:(UIButton *)sender {
    NSLog(@"%@", sender.currentTitle);
}

- (void)buyAction:(UIButton *)sender {
    NSLog(@"%@", sender.currentTitle);
}

- (void)serviceAction:(UIButton *)sender {
    NSLog(@"%@", sender.currentTitle);
}
#pragma mark ----- DataSource
- (void)getDataSource {
    
    
    
    
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
