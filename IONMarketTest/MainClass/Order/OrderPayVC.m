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

@end

@implementation OrderPayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.orderNo.text = self.orderModel.no;
    self.priceLab.text = [NSString stringWithFormat:@"%@元",self.orderModel.money];
}

#pragma mark - Method

- (IBAction)payClicker:(UIButton *)sender {
    
    if (!self.payWayLab.text.length) {
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请选择支付方式!" time:0 aboutType:WHShowViewMode_Text state:NO];
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:self.orderModel.id forKey:@"orderId"];
    [dict setValue:self.orderModel.money forKey:@"totalfee"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_WeixinPay andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        
        [[ShoppingCarSingle sharedShoppingCarSingle] weixinPay:resultDic];
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
}

- (IBAction)choosePayWay:(UIButton *)sender {
    
    [ChoosePayWayView showSelfWithBlock:^(NSString *value) {
//        NSLog(@"---%@", value);
        self.payWayLab.text = value;
        
    }];
    
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
