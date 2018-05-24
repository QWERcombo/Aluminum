//
//  WholeBoardViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/19.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "WholeBoardViewController.h"
#import "MainItemView__WholeBoard.h"
#import "ShopCarViewController.h"

#define CAR_Color  [UIColor colorWithR:97 G:177 B:225 A:1]
@interface WholeBoardViewController ()
@property (nonatomic, copy) NSString *orderMoney;
@property (nonatomic, copy) NSString *amount;

@end

@implementation WholeBoardViewController {
    UIButton *radiusButton;
    UILabel *priceLabel;
    UILabel *infoLabel;
    UIView *bottomView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"下单";
    [self createScrollLayoutView];
    [self createBottomView];
}

- (void)createScrollLayoutView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, SCREEN_HEIGHT-50)];
    [self.view addSubview:scrollView];
    
    MainItemView__WholeBoard *single = [[MainItemView__WholeBoard alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 750)];
    [single loadData:self.wholeBoardModel andCliker:^(NSString *clueStr) {
        NSArray *infoArr = [clueStr componentsSeparatedByString:@","];
        self.orderMoney = [infoArr firstObject];
        self.amount = [infoArr lastObject];
    }];
    
    [scrollView setContentSize:CGSizeMake(SCREEN_WIGHT, 750)];
    [scrollView addSubview:single];
}



- (void)createBottomView {
    bottomView = [[UIView alloc] init];
    [self.view addSubview:bottomView];
    bottomView.backgroundColor = [UIColor whiteColor];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(50));
        make.bottom.left.right.equalTo(self.view);
    }];
    
    
    UIButton *buyButton = [UIButton buttonWithTitle:@"立即购买" andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:IMG(@"Main_buy") andHighlightedImage:IMG(@"Main_buy")];
    [buyButton addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:buyButton];
    [buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(bottomView);
        make.width.equalTo(@(100));
    }];
    UIButton *carButton = [UIButton buttonWithTitle:@"加入购物车" andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:IMG(@"Main_shop_car") andHighlightedImage:IMG(@"Main_shop_car")];
    [carButton addTarget:self action:@selector(carAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:carButton];
    [carButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(bottomView);
        make.width.equalTo(@(100));
        make.right.equalTo(buyButton.mas_left);
    }];
    
    radiusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    radiusButton.backgroundColor = CAR_Color;
    radiusButton.layer.cornerRadius = 25;
    radiusButton.layer.masksToBounds = YES;
    [radiusButton addTarget:self action:@selector(goToShopCar:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:radiusButton];
    [radiusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(50));
        make.left.equalTo(bottomView.mas_left).offset(5);
        make.bottom.equalTo(bottomView.mas_bottom).offset(-20);
    }];
    [radiusButton setImage:IMG(@"Shop_car") forState:UIControlStateNormal];
    radiusButton.badgeValue = SINT([ShoppingCarSingle sharedShoppingCarSingle].totalbadge);
    radiusButton.badgeFont = FONT_ArialMT(13);
    radiusButton.badgeBGColor = [UIColor mianColor:2];
    radiusButton.badgeOriginX = 35;
    
    priceLabel = [UILabel lableWithText:[NSString stringWithFormat:@"￥%@",[ShoppingCarSingle sharedShoppingCarSingle].totalPrice?[ShoppingCarSingle sharedShoppingCarSingle].totalPrice:@0] Font:FONT_ArialMT(15) TextColor:[UIColor mianColor:2]];
    [bottomView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(radiusButton.mas_right).offset(10);
        make.top.equalTo(bottomView.mas_top).offset(10);
    }];
    infoLabel = [UILabel lableWithText:@"" Font:FONT_ArialMT(13) TextColor:[UIColor mianColor:2]];
    [bottomView addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(priceLabel.mas_left);
        make.top.equalTo(priceLabel.mas_bottom);
    }];
    
    
}


- (void)buyAction:(UIButton *)sender {
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setValue:@"65" forKey:@"orderId"];
//    [dict setValue:@"1" forKey:@"totalfee"];
//
//    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_WeixinPay andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
//
//        [[ShoppingCarSingle sharedShoppingCarSingle] weixinPay:resultDic];
//
//    } failure:^(NSString *error, NSInteger code) {
//
//    }];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"整只" forKey:@"type"];
    [dict setValue:self.amount forKey:@"amount"];
    [dict setValue:self.wholeBoardModel.zhonglei forKey:@"zhonglei"];
    NSDictionary *idDic = self.wholeBoardModel.lvxing;
    NSString *typeID = [NSString stringWithFormat:@"%@",idDic[@"id"]];
    [dict setValue:typeID forKey:@"erjimulu"];
    [dict setValue:self.orderMoney forKey:@"money"];
    if ([self.wholeBoardModel.zhonglei isEqualToString:@"圆棒"]) {//圆棒
        [dict setValue:self.wholeBoardModel.arg2 forKey:@"chang"];
        [dict setValue:self.wholeBoardModel.arg1 forKey:@"kuang"];
    }
    if ([self.wholeBoardModel.zhonglei isEqualToString:@"型材"]) {//型材
        [dict setValue:self.wholeBoardModel.arg1 forKey:@"hou"];
        [dict setValue:self.wholeBoardModel.arg2 forKey:@"kuang"];
        [dict setValue:self.wholeBoardModel.arg3 forKey:@"chang"];
    }
    if ([self.wholeBoardModel.zhonglei isEqualToString:@"管材"]) {//管材
        [dict setValue:self.wholeBoardModel.arg1 forKey:@"waijing"];
        [dict setValue:self.wholeBoardModel.arg2 forKey:@"neijing"];
        [dict setValue:self.wholeBoardModel.arg3 forKey:@"chang"];
    }
    if ([self.wholeBoardModel.zhonglei isEqualToString:@"整板"]) {//整板
        [dict setValue:self.wholeBoardModel.arg1 forKey:@"hou"];
        [dict setValue:self.wholeBoardModel.arg2 forKey:@"kuang"];
        [dict setValue:self.wholeBoardModel.arg3 forKey:@"chang"];
    }
    [dict setValue:[UserData currentUser].phone forKey:@"phone"];
    [dict setValue:@"40" forKey:@"addressId"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_OrderSave andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        
        [self getOrderDetail:resultDic[@"orderId"]];
        
    } failure:^(NSString *error, NSInteger code) {
        
        
    }];
    
}

- (void)carAction:(UIButton *)sender {
    [self addToShopCar];
}


- (void)addToShopCar {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"整只" forKey:@"type"];
    [dict setValue:self.amount forKey:@"amount"];
    [dict setValue:self.wholeBoardModel.zhonglei forKey:@"zhonglei"];
    NSDictionary *idDic = self.wholeBoardModel.lvxing;
    NSString *typeID = [NSString stringWithFormat:@"%@",idDic[@"id"]];
    [dict setValue:typeID forKey:@"erjimulu"];
    [dict setValue:self.orderMoney forKey:@"money"];
    if ([self.wholeBoardModel.zhonglei isEqualToString:@"圆棒"]) {//圆棒
        [dict setValue:self.wholeBoardModel.arg2 forKey:@"chang"];
        [dict setValue:self.wholeBoardModel.arg1 forKey:@"kuang"];
    }
    if ([self.wholeBoardModel.zhonglei isEqualToString:@"型材"]) {//型材
        [dict setValue:self.wholeBoardModel.arg1 forKey:@"hou"];
        [dict setValue:self.wholeBoardModel.arg2 forKey:@"kuang"];
        [dict setValue:self.wholeBoardModel.arg3 forKey:@"chang"];
    }
    if ([self.wholeBoardModel.zhonglei isEqualToString:@"管材"]) {//管材
        [dict setValue:self.wholeBoardModel.arg1 forKey:@"waijing"];
        [dict setValue:self.wholeBoardModel.arg2 forKey:@"neijing"];
        [dict setValue:self.wholeBoardModel.arg3 forKey:@"chang"];
    }
    if ([self.wholeBoardModel.zhonglei isEqualToString:@"整板"]) {//整板
        [dict setValue:self.wholeBoardModel.arg1 forKey:@"hou"];
        [dict setValue:self.wholeBoardModel.arg2 forKey:@"kuang"];
        [dict setValue:self.wholeBoardModel.arg3 forKey:@"chang"];
    }
    [dict setValue:[UserData currentUser].phone forKey:@"phone"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_SaveToGouwuche andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
//        NSLog(@"car: +++%@", resultDic);
        [ShoppingCarSingle sharedShoppingCarSingle].totalbadge += 1;
        [ShoppingCarSingle sharedShoppingCarSingle].totalPrice = [NSNumber numberWithFloat:([self.orderMoney floatValue]+[ShoppingCarSingle sharedShoppingCarSingle].totalPrice.floatValue)];
        [self refreshBottomViewInfo];
        
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:msg time:1 aboutType:WHShowViewMode_Text state:YES];
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}

- (void)goToShopCar:(UIButton *)sender {
    ShopCarViewController *shopcar = [[ShopCarViewController alloc] init];
    [self.navigationController pushViewController:shopcar animated:YES];
}

- (void)refreshBottomViewInfo {
    priceLabel.text = [NSString stringWithFormat:@"%@",[ShoppingCarSingle sharedShoppingCarSingle].totalPrice];
    radiusButton.badgeValue = SINT([ShoppingCarSingle sharedShoppingCarSingle].totalbadge);
}


- (void)getOrderDetail:(NSString *)orderId {
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setValue:orderId forKey:@"no"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dataDic imageArray:nil WithType:Interface_detailList andCookie:nil showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
        
        
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
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
