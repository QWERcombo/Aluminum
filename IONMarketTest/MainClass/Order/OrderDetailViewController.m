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
    if (section==1) {
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
        return nil;
    } else {
        return [self createSectionBottomView];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 222;
    } else if (section==1) {
        return 40;
    } else if (section==2) {
        return 0;
    } else {
        return 160;
    }
}

#pragma mark ----- Subviews
- (UIView *)createSectionOneView {
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 222)];
    mainView.backgroundColor = [UIColor mianColor:1];
    
    UIView *expressView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIGHT, 70)];
    expressView.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:expressView];
    UIImageView *exp = [UIImageView new];
    exp.image = IMG(@"Order_express");
    [expressView addSubview:exp];
    [exp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(expressView.mas_centerY);
        make.left.equalTo(expressView.mas_left).offset(15);
        make.width.height.equalTo(@(20));
    }];
    
    UILabel *hint1 = [UILabel lableWithText:@"物流状态" Font:FONT_ArialMT(16) TextColor:[UIColor mianColor:2]];
    [expressView addSubview:hint1];
    [hint1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(18));
        make.left.equalTo(exp.mas_right).offset(15);
        make.top.equalTo(expressView.mas_top).offset(15);
    }];
    UILabel *hint11 = [UILabel lableWithText:@"2018-03-20 18:17:17" Font:FONT_ArialMT(13) TextColor:[UIColor mianColor:3]];
    [expressView addSubview:hint11];
    [hint11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(15));
        make.left.equalTo(exp.mas_right).offset(15);
        make.top.equalTo(hint1.mas_bottom).offset(10);
    }];
    
    
    
    //------------------------------------------------------------
    UIView *infomationView = [[UIView alloc] initWithFrame:CGRectMake(0, 81, SCREEN_WIGHT, 75)];
    infomationView.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:infomationView];
    UIImageView *info = [UIImageView new];
    info.image = IMG(@"Order_address");
    [infomationView addSubview:info];
    [info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(infomationView.mas_centerY);
        make.left.equalTo(infomationView.mas_left).offset(15);
        make.height.equalTo(@(20));
        make.width.equalTo(@(15));
    }];
    
    
    UILabel *userLabel = [UILabel lableWithText:@"XXX  186 5227 5886" Font:FONT_ArialMT(16) TextColor:[UIColor mianColor:2]];
    [infomationView addSubview:userLabel];
    [userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(info.mas_right).offset(15);
        make.top.equalTo(infomationView.mas_top).offset(15);
    }];
    
    UILabel *addressLabel = [UILabel lableWithText:@"江苏省 苏州市 吴中区 长桥街道 越湖名邸206" Font:FONT_ArialMT(13) TextColor:[UIColor mianColor:2]];
    addressLabel.numberOfLines = 2;
    [infomationView addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(info.mas_right).offset(15);
        make.top.equalTo(userLabel.mas_bottom).offset(10);
    }];
    
    
    //-------------------------------------------------------------
    UIView *orderView = [[UIView alloc] initWithFrame:CGRectMake(0, 157, SCREEN_WIGHT, 65)];
    orderView.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:orderView];
    UILabel *orderLabel = [UILabel lableWithText:@"订单编号:1524252\n\n下单时间:2018-03-16" Font:FONT_ArialMT(15) TextColor:[UIColor mianColor:2]];
    orderLabel.numberOfLines = 0;
    [orderView addSubview:orderLabel];
    [orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(orderView.mas_left).offset(15);
        make.top.equalTo(orderView.mas_top).offset(0);
        make.bottom.equalTo(orderView.mas_bottom).offset(0);
    }];
    
    UIButton *telButton = [UIButton buttonWithTitle:@"联系客服" andFont:FONT_ArialMT(12) andtitleNormaColor:[UIColor mianColor:2] andHighlightedTitle:[UIColor mianColor:2] andNormaImage:nil andHighlightedImage:nil];
    [telButton setImage:IMG(@"Order_service") forState:UIControlStateNormal];
    [orderView addSubview:telButton];
    telButton.layer.borderColor = [UIColor mianColor:2].CGColor;
    telButton.layer.borderWidth = 2;
    telButton.layer.cornerRadius = 5;
    telButton.layer.masksToBounds = YES;
    [telButton addTarget:self action:@selector(buttonCliker:) forControlEvents:UIControlEventTouchUpInside];
    [telButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(orderView.mas_right).offset(-15);
        make.centerY.equalTo(orderView.mas_centerY);
        make.width.equalTo(@(90));
        make.height.equalTo(@(35));
    }];
    
    telButton.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
    
    return mainView;
}

- (UIView *)createSectionHeaderView:(NSInteger)section {
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 40)];
    mainView.backgroundColor = [UIColor mianColor:1];
    UIView *vvv = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIGHT, 30)];
    vvv.backgroundColor = [UIColor mianColor:1];
    [mainView addSubview:vvv];
    
    UILabel *label = [UILabel lableWithText:section==0?@"整板":@"零切" Font:FONT_ArialMT(17) TextColor:[UIColor mianColor:3]];
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
    UILabel *label1 = [UILabel lableWithText:@"预计到达时间" Font:FONT_ArialMT(17) TextColor:[UIColor Black_WordColor]];
    [blank1 addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(blank1.mas_centerY);
        make.left.equalTo(blank1.mas_left).offset(20);
    }];
    UILabel *label2 = [UILabel lableWithText:@"2018-05-20" Font:FONT_ArialMT(17) TextColor:[UIColor Black_WordColor]];
    [blank1 addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(blank1.mas_centerY);
        make.right.equalTo(blank1.mas_right).offset(-20);
    }];
    
    
    
    UIView *blank2 = [[UIView alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIGHT, 40)];
    blank2.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:blank2];
    UILabel *label3 = [UILabel lableWithText:@"选择支付方式" Font:FONT_ArialMT(17) TextColor:[UIColor Black_WordColor]];
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
    UIButton *downloadButton = [UIButton buttonWithTitle:@"材质证明" andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor mianColor:2] andHighlightedTitle:[UIColor mianColor:2] andNormaImage:nil andHighlightedImage:nil];
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
