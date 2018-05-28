//
//  OrderPayVC.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/5/15.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "OrderPayVC.h"
#import "ChoosePayWayView.h"

@interface OrderPayVC ()
@property (weak, nonatomic) IBOutlet UILabel *orderNo;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *payWayLab;
@property (weak, nonatomic) IBOutlet UILabel *wuliufeiLab;

@end

@implementation OrderPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.orderNo.text = self.orderModel.no;
    self.priceLab.text = [NSString stringWithFormat:@"%@元",self.orderModel.totalMoney];
    if ([self.orderModel.wuliufei integerValue]>0) {
        self.wuliufeiLab.text = [NSString stringWithFormat:@"%@元", self.orderModel.wuliufei];
    } else {
        self.wuliufeiLab.text = @"0元";
    }
//    [self getOrderDetail:self.orderModel.no];
}

#pragma mark - Method

- (IBAction)payClicker:(UIButton *)sender {
    
    if (!self.payWayLab.text.length) {
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请选择支付方式!" time:0 aboutType:WHShowViewMode_Text state:NO];
        return;
    }
    
    if ([self.payWayLab.text isEqualToString:@"微信支付"]) {
        [[ShoppingCarSingle sharedShoppingCarSingle] beginPayUserWeixiWithOrderId:self.orderModel.no andTotalfee:self.orderModel.totalMoney userPayMode:weixinPayMode_order];
    }
    if ([self.payWayLab.text isEqualToString:@"钱包支付"]) {
        [[ShoppingCarSingle sharedShoppingCarSingle] beginPayUserWalletWithOrderId:self.orderModel.no andTotalfee:self.orderModel.totalMoney];
    }
    if ([self.payWayLab.text isEqualToString:@"白条支付"]) {
        [[ShoppingCarSingle sharedShoppingCarSingle] beginPayUserWhiteBarWithOrderId:self.orderModel.no andTotalfee:self.orderModel.totalMoney];
    }
    if ([self.payWayLab.text isEqualToString:@"支付宝支付"]) {
        [[ShoppingCarSingle sharedShoppingCarSingle] beginPayUserAliPayWithOrderId:self.orderModel.no andTotalfee:self.orderModel.totalMoney];
    }
    
}

- (IBAction)choosePayWay:(UIButton *)sender {
    
    [ChoosePayWayView showSelfWithBlock:^(NSString *value) {
//        NSLog(@"---%@", value);
        self.payWayLab.text = value;
    }];
    
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
