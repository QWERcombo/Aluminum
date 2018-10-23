//
//  ShopCarDetailViewController.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/20.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "ShopCarDetailViewController.h"
#import "AddressViewController.h"

#import "AddressShowView.h"

@interface ShopCarDetailViewController ()
@property (nonatomic, assign) BOOL isAddress;
@property (nonatomic, strong) AddressModel *addressModel;
@end

@implementation ShopCarDetailViewController {
    UILabel *priceLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"确认订单";
    self.dataMuArr = [self.shopCarArr mutableCopy];
    [self setupSubviews];
}


- (void)setupSubviews {
    [self.view addSubview:self.tabView];
    self.tabView.backgroundColor = [UIColor mianColor:1];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-80);
    }];
    
    [self createBottomView];
}

- (void)createBottomView {
    UIView *bottomView = [[UIView alloc] init];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.equalTo(@(80));
    }];
    
    UIButton *nextButton = [UIButton buttonWithTitle:@"下一步" andFont:FONT_ArialMT(13) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:IMG(@"Main_shop_car") andHighlightedImage:IMG(@"Main_shop_car")];
    nextButton.backgroundColor = [UIColor mianColor:2];
    [nextButton addTarget:self action:@selector(nextButtonCliker:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:nextButton];
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(bottomView);
        make.top.equalTo(bottomView.mas_top).offset(30);
        make.width.equalTo(@(120));
    }];
    
    priceLabel = [UILabel lableWithText:@"实付款  ￥152151.00元" Font:FONT_ArialMT(15) TextColor:[UIColor mianColor:2]];
    [bottomView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nextButton);
        make.left.equalTo(bottomView.mas_left).offset(20);
        make.right.equalTo(nextButton.mas_left).offset(-20);
    }];
    priceLabel.attributedText = [UILabel getAttributedFromRange:[priceLabel.text rangeOfString:@"实付款"] WithColor:[UIColor mianColor:2] andFont:FONT_ArialMT(17) allFullText:priceLabel.text];
    
    
    NSArray *textArr = @[@"产品：51515.00元",@"加工费：586.00元",@"物流费：848232.00元"];
    UILabel *lastLabel = nil;
    for (NSInteger i = 0; i<3; i++) {
        
        UILabel *label = [UILabel lableWithText:[textArr objectAtIndex:i] Font:FONT_ArialMT(11) TextColor:[UIColor mianColor:2]];
        label.textAlignment = NSTextAlignmentCenter;
        [bottomView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@((SCREEN_WIGHT-30)/3));
            make.height.equalTo(@(15));
            make.top.equalTo(bottomView.mas_top).offset(7.5);
            if (lastLabel) {
                make.left.equalTo(lastLabel.mas_right);
            } else {
                make.left.equalTo(bottomView.mas_left).offset(15);
            }
        }];
        
        lastLabel = label;
    }
    
    
}


#pragma mark ----- UITableViewDelegate &
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section==1?self.dataMuArr.count:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShopCar *model = [self.dataMuArr objectAtIndex:indexPath.row];
    return [UtilsMold creatCell:@"OrderDetailCell" table:tableView deledate:self model:model data:nil andCliker:^(NSDictionary *clueDic) {
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"OrderDetailCell" data:nil model:nil indexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section== 0) {
        return [self createAddressView];
    } else if (section==1) {
        return [self createSectionView];
    } else {
        return [self createOrderInfoView];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section== 0) {
        return 110;
    } else if (section==1) {
        return 40;
    } else {
        return 60;
    }
}

#pragma mark ----- Subviews
- (UIView *)createAddressView {
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 110)];
    mainView.backgroundColor = [UIColor mianColor:1];
    UIView *content = [self addressContentView];
    [mainView addSubview:content];
    [content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(mainView);
        make.top.equalTo(mainView.mas_top).offset(10);
        make.width.equalTo(@(SCREEN_WIGHT));
        make.height.equalTo(@(100));
    }];
    return mainView;
}

- (UIView *)createSectionView {
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 40)];
    mainView.backgroundColor = [UIColor mianColor:1];
    ShopCar *model = [self.dataMuArr firstObject];
    UILabel *nameLab = [UILabel lableWithText:model.zhonglei Font:FONT_ArialMT(17) TextColor:[UIColor mianColor:2]];
    [mainView addSubview:nameLab];
    nameLab.frame = CGRectMake(20, 10, SCREEN_WIGHT, 30);
    return mainView;
}

- (UIView *)createOrderInfoView {
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 60)];
    mainView.backgroundColor = [UIColor mianColor:1];
    
    UIView *blank2 = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIGHT, 40)];
    blank2.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:blank2];
    UILabel *label3 = [UILabel lableWithText:@"选择支付方式" Font:FONT_ArialMT(17) TextColor:[UIColor mianColor:2]];
    [blank2 addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(blank2.mas_centerY);
        make.left.equalTo(blank2.mas_left).offset(20);
    }];
    UIButton *paywayButton = [UIButton buttonWithTitle:@"支付宝" andFont:FONT_ArialMT(17) andtitleNormaColor:[UIColor mianColor:2] andHighlightedTitle:[UIColor mianColor:2] andNormaImage:nil andHighlightedImage:nil];
    [paywayButton setImage:IMG(@"image_more") forState:UIControlStateNormal];

    [paywayButton addTarget:self action:@selector(payCliker:) forControlEvents:UIControlEventTouchUpInside];
    [blank2 addSubview:paywayButton];
    [paywayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(blank2.mas_centerY);
        make.right.equalTo(blank2.mas_right).offset(-20);
    }];
    paywayButton.titleEdgeInsets = UIEdgeInsetsMake(0, -paywayButton.imageView.bounds.size.width, 0, paywayButton.imageView.bounds.size.width);
    paywayButton.imageEdgeInsets = UIEdgeInsetsMake(0, paywayButton.titleLabel.bounds.size.width, 0, -paywayButton.titleLabel.bounds.size.width);
    
    return mainView;
}

- (UIView *)addressContentView {
    UIView *blank = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 100)];
    blank.backgroundColor = [UIColor whiteColor];
    
    if (self.isAddress) {
        
        __weak typeof(self) weakself = self;
        AddressShowView *showView = [[AddressShowView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 100)];

        [showView loadData:self.addressModel andCliker:^(NSString *clueStr) {
            if ([clueStr isEqualToString:@"0"]) {
                AddressViewController *address = [[AddressViewController alloc] init];
                [weakself.navigationController pushViewController:address animated:YES];
            }
        }];
        [blank addSubview:showView];
        
    } else {
        UIButton *addButton = [UIButton buttonWithTitle:@"添加收货地址" andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor mianColor:2] andHighlightedTitle:[UIColor mianColor:2] andNormaImage:nil andHighlightedImage:nil];
        [blank addSubview:addButton];
        [addButton addTarget:self action:@selector(addAddress:) forControlEvents:UIControlEventTouchUpInside];
        [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(blank);
        }];
    }
    
    return blank;
}

#pragma mark ----- Action
- (void)nextButtonCliker:(UIButton *)sender {
    
    if (!self.addressModel.id.length) {
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请先选择收货地址！" time:0 aboutType:WHShowViewMode_Text state:NO];
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableString *orderIds = [NSMutableString string];
    for (ShopCar *car in self.dataMuArr) {
        [orderIds appendString:car.id];
        [orderIds appendString:@","];
    }
    [dict setValue:[orderIds substringToIndex:orderIds.length-1] forKey:@"gouwucheIds"];
    [dict setValue:self.addressModel.id forKey:@"addressId"];
    [dict setValue:[UserData currentUser].phone forKey:@"phone"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_SaveFromGouwuche andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"---%@", resultDic);
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"下单成功" time:0 aboutType:WHShowViewMode_Text state:YES];
        //刷新购物车列表
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshNewData" object:nil];
        //重置购物车信息
//        [ShoppingCarSingle sharedShoppingCarSingle].totalbadge = 0;
//        [ShoppingCarSingle sharedShoppingCarSingle].totalPrice = @0;
//        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];

    
}

- (void)payCliker:(UIButton *)sender {
    NSLog(@"%@", sender.currentTitle);
    
}

- (void)addAddress:(UIButton *)sender {
    AddressViewController *address = [[AddressViewController alloc] init];
    
    __weak typeof(self) weakself = self;
    address.SelectAddressBlock = ^(AddressModel *address) {
        weakself.addressModel = address;
        weakself.isAddress = YES;
        [weakself.tabView reloadData];
    };
    
    [self.navigationController pushViewController:address animated:YES];
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
