//
//  OrderPayVC.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/5/15.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "OrderPayVC.h"
#import "ChoosePayWayView.h"
#import "OrderPayResultVC.h"
#import "SettingPayPsdVC.h"
#import "CYPasswordView.h"

@interface OrderPayVC ()<SettingPayPsdVCDelegate>
@property (weak, nonatomic) IBOutlet UILabel *orderNo;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *payWayLab;
@property (weak, nonatomic) IBOutlet UILabel *wuliufeiLab;
@property (weak, nonatomic) IBOutlet UILabel *totalLab;

@property (nonatomic, strong) CYPasswordView *passwordView;
@end

@implementation OrderPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.orderNo.text = self.orderModel.no;
    self.priceLab.text = [NSString stringWithFormat:@"￥%@", [NSString getStringAfterTwo:self.orderModel.totalMoney]];
    if ([self.orderModel.wuliufei integerValue]>0) {
        self.wuliufeiLab.text = [NSString stringWithFormat:@"￥%@", [NSString getStringAfterTwo:self.orderModel.wuliufei]];
    } else {
        self.wuliufeiLab.text = @"￥0.00";
    }
//    NSLog(@"%@", self.orderModel);
    NSNumber *total = [NSNumber numberWithFloat:([self.orderModel.totalMoney floatValue] + [self.orderModel.wuliufei floatValue])];
    self.totalLab.text = [NSString stringWithFormat:@"￥%@", [NSString getStringAfterTwo:total.stringValue]];

    
}

- (void)resetPasswordView {
    _passwordView = [[CYPasswordView alloc] init];
    /** 注册取消按钮点击的通知 */
    [CYNotificationCenter addObserver:self selector:@selector(cancel) name:CYPasswordViewCancleButtonClickNotification object:nil];
    _passwordView.title = @"输入支付密码";
    [_passwordView showInView:self.view];
//    [CYNotificationCenter addObserver:self selector:@selector(forgetPWD) name:CYPasswordViewForgetPWDButtonClickNotification object:nil];
}


#pragma mark - Method
- (void)cancel {
    
}

- (IBAction)payClicker:(UIButton *)sender {
    
    if ([self.payWayLab.text isEqualToString:@"选择支付方式"]) {
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请选择支付方式!" time:0 aboutType:WHShowViewMode_Text state:NO];
        return;
    }
    
    if ([self.payWayLab.text isEqualToString:@"微信支付"]) {
        [[ShoppingCarSingle sharedShoppingCarSingle] beginPayUserWeixiWithOrderId:self.orderModel.no andTotalfee:[self.totalLab.text substringToIndex:1] userPayMode:weixinPayMode_order paySuccessBlock:^{
            [self goToPayResuit];
        }];
    }
    if ([self.payWayLab.text isEqualToString:@"钱包支付"]) {
        
        if ([UserData currentUser].zhifumima.length) {
            [self resetPasswordView];
            MJWeakSelf
            self.passwordView.finish = ^(NSString *password) {
                [weakSelf.passwordView hide];
                [weakSelf.passwordView hideKeyboard];
                
                [[ShoppingCarSingle sharedShoppingCarSingle] beginPayUserWalletWithOrderId:weakSelf.orderModel.no andTotalfee:[weakSelf.totalLab.text substringToIndex:1] payPassword:password paySuccessBlock:^{
                    
                    [weakSelf goToPayResuit];
                }];
                
            };
            
        } else {
            [self showSettingPayVC];
        }
        
    }
    if ([self.payWayLab.text isEqualToString:@"白条支付"]) {
        
        if ([UserData currentUser].zhifumima.length) {
            [self resetPasswordView];
            MJWeakSelf
            self.passwordView.finish = ^(NSString *password) {
                [weakSelf.passwordView hide];
                [weakSelf.passwordView hideKeyboard];
                
                [[ShoppingCarSingle sharedShoppingCarSingle] beginPayUserWhiteBarWithOrderId:weakSelf.orderModel.no andTotalfee:[weakSelf.totalLab.text substringToIndex:1] payPassword:password paySuccessBlock:^{
                    [weakSelf goToPayResuit];
                }];
            };
        } else {
            [self showSettingPayVC];
        }
        
    }
    if ([self.payWayLab.text isEqualToString:@"支付宝支付"]) {
        [[ShoppingCarSingle sharedShoppingCarSingle] beginPayUserAliPayWithOrderId:self.orderModel.no andTotalfee:[self.totalLab.text substringToIndex:1] userPayMode:aliPayMode_order paySuccessBlock:^{
            
            [self goToPayResuit];
        }];
    }
    
}

- (void)goToPayResuit {
    OrderPayResultVC *result = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"OrderPayResultVC"];
    [self.navigationController pushViewController:result animated:YES];
}


- (IBAction)choosePayWay:(UIButton *)sender {
    
    [ChoosePayWayView showSelfWithBlock:^(NSString *value) {
//        NSLog(@"---%@", value);
        self.payWayLab.text = value;
        self.payWayLab.textColor = [UIColor Black_WordColor];
    }];
    
}

- (void)showSettingPayVC {
    
    SettingPayPsdVC *payset = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"SettingPayPsdVC"];
    payset.delegate = self;
    TBNavigationController *nav = [[TBNavigationController alloc] initWithRootViewController:payset];
    [self presentViewController:nav animated:YES completion:^{
    }];
}

- (void)settingPayPsdFinish {
    
    if ([self.payWayLab.text isEqualToString:@"白条支付"]) {
        [self resetPasswordView];
        MJWeakSelf
        self.passwordView.finish = ^(NSString *password) {
            [weakSelf.passwordView hide];
            [weakSelf.passwordView hideKeyboard];
            
            [[ShoppingCarSingle sharedShoppingCarSingle] beginPayUserWhiteBarWithOrderId:weakSelf.orderModel.no andTotalfee:[weakSelf.totalLab.text substringToIndex:1] payPassword:password paySuccessBlock:^{
                [weakSelf goToPayResuit];
            }];
        };
    } else if ([self.payWayLab.text isEqualToString:@"钱包支付"]) {
        [self resetPasswordView];
        MJWeakSelf
        self.passwordView.finish = ^(NSString *password) {
            [weakSelf.passwordView hide];
            [weakSelf.passwordView hideKeyboard];
            
            [[ShoppingCarSingle sharedShoppingCarSingle] beginPayUserWalletWithOrderId:weakSelf.orderModel.no andTotalfee:[weakSelf.totalLab.text substringToIndex:1] payPassword:password paySuccessBlock:^{
                [weakSelf goToPayResuit];
            }];
            
        };
        
    } else {
    }
    
}
//- (void)getOrderDetail:(NSString *)orderId {
//
//    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
//    [dataDic setValue:orderId forKey:@"no"];
//
//    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dataDic imageArray:nil WithType:Interface_detailList andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
//        //        NSLog(@"___===%@", resultDic);
//        NSArray *dataArr = resultDic[@"result"];

//        for (NSDictionary *dic in dataArr) {
//
//            ShopCar *car = [[ShopCar alloc] initWithDictionary:dic error:nil];
//            self.orderModel = [[OrderModel alloc] initWithDictionary:dic error:nil];
//
//            [self.detailDataSource addObject:car];
//        }
//
//        [self updateInfomation];
//        [self.tableView reloadData];
//    } failure:^(NSString *error, NSInteger code) {
//
//    }];
//
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
