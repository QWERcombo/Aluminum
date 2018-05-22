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
    self.priceLab.text = [NSString stringWithFormat:@"%@元",self.orderModel.money];
    [self getExpressMoney:self.orderModel.no];
}

#pragma mark - Method

- (IBAction)payClicker:(UIButton *)sender {
    
    if (!self.payWayLab.text.length) {
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请选择支付方式!" time:0 aboutType:WHShowViewMode_Text state:NO];
        return;
    }
    
    [[ShoppingCarSingle sharedShoppingCarSingle] beginPayUserWeixiWithOrderId:self.orderModel.id andTotalfee:self.orderModel.money];
    
}

- (IBAction)choosePayWay:(UIButton *)sender {
    
    [ChoosePayWayView showSelfWithBlock:^(NSString *value) {
//        NSLog(@"---%@", value);
        self.payWayLab.text = value;
    }];
    
}

- (void)getExpressMoney:(NSString *)orderNo {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:orderNo forKey:@"orderNo"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_GetWuliufei andCookie:nil showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
//        NSLog(@"wuliufei: %@", resultDic);
        if ([resultDic[@"wuliufei"] integerValue]>0) {
            self.wuliufeiLab.text = [NSString stringWithFormat:@"%@元", resultDic[@"wuliufei"]];
        } else {
            self.wuliufeiLab.text = @"";
        }
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
