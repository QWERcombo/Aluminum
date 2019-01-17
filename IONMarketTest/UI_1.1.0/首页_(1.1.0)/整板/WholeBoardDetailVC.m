//
//  WholeBoardDetailVC.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/10/23.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "WholeBoardDetailVC.h"
#import "ShopCarViewController.h"
#import "ConfirmOrderVC.h"
#import "WholeBoardTableVC.h"

@interface WholeBoardDetailVC ()

@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIButton *shopBtn;

@property (nonatomic, copy) NSDictionary *dataDic;
@property (nonatomic, assign) NSInteger orderMoney;
@property (nonatomic, strong) WholeBoardTableVC *showVC;

@end

@implementation WholeBoardDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _totalLabel.adjustsFontSizeToFitWidth = YES;
    [self refreshBottomViewInfo];
}

- (IBAction)close:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)shopCar:(UIButton *)sender {
    [[PublicFuntionTool sharedInstance] isHadLogin:^{
        ShopCarViewController *shopcar = [[ShopCarViewController alloc] init];
        [self.navigationController pushViewController:shopcar animated:YES];
    }];
}

- (IBAction)excute:(UIButton *)sender {
    [[PublicFuntionTool sharedInstance] isHadLogin:^{
        
//        if (_stepper.value > 0) {
//
//            [self placeOrder:UseType_OrderMoney];
//
//        } else {
//            [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请先添加数量" time:0 aboutType:WHShowViewMode_Text state:NO];
//        }
        
    }];
}

- (IBAction)buyNow:(UIButton *)sender {
    
    [[PublicFuntionTool sharedInstance] isHadLogin:^{
        
//        if (_stepper.value > 0) {
//
//            [self placeOrder:UseType_BuyNow];
//
//        } else {
//            [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请先添加数量" time:0 aboutType:WHShowViewMode_Text state:NO];
//        }
        
    }];
}




- (void)refreshBottomViewInfo {
    
    [[ShoppingCarSingle sharedShoppingCarSingle] getServerShopCarAmountAndTotalfee:^(NSString *amout, NSString *totalfee) {
        
//        self.shopBtn.badgeValue = amout;
    }];
//    self.totalLabel.text = [NSString stringWithFormat:@"合计:%@", [NSNumber numberWithFloat:[_wholeModel.danpianzhengbanjiage floatValue]*_wholeModel.value]];
}


- (void)placeOrder:(UseType)useType {
    
//    NSString *amount = [NSNumber numberWithFloat:_stepper.value].stringValue;
    
    [[PublicFuntionTool sharedInstance] placeOrderCommonInterfaceWithUseType:useType moneyWithOrderType:GetOrderType_ZhengBan chang:_wholeModel.arg3 kuan:_wholeModel.arg2 hou:_wholeModel.arg1 amount:@"" type:@"整只" erjimulu:_wholeModel.lvxing orderMoney:[[NSNumber alloc] initWithInteger:self.orderMoney].stringValue successBlock:^(NSDictionary *dataDic) {
        
        self.dataDic = dataDic;
        self.orderMoney = [self.dataDic[@"orderMoney"] integerValue];
        [self placeOrder:UseType_AddShopCar];
        
    } buyNowSuccessBlock:^(ShopCar *shopCar) {
        
        ConfirmOrderVC *confirm = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"ConfirmOrderVC"];
//        shopCar.money = [NSNumber numberWithFloat:[_wholeModel.danpianzhengbanjiage floatValue]*_stepper.value].stringValue;
        confirm.carArr = @[shopCar];
        confirm.fromtype = FromVCType_Buy;
        [self.navigationController pushViewController:confirm animated:YES];
        
    } addCarSuccessBlock:^{
        
        [self refreshBottomViewInfo];
//        self.totalLabel.text = [NSString stringWithFormat:@"合计:%@", [NSNumber numberWithInteger:self.orderMoney]];
    }];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"goToWholeBoardTableVC"]) {
        
        self.showVC = segue.destinationViewController;
        
        self.showVC.wholeModel = self.wholeModel;
        self.showVC.selectCount = self.selectCount;
        
    }
    
    
}


@end
