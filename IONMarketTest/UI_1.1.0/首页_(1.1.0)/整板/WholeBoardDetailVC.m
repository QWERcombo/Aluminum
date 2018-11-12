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

@interface WholeBoardDetailVC ()

@property (weak, nonatomic) IBOutlet HYStepper *stepper;
@property (weak, nonatomic) IBOutlet UILabel *guigeLabel;
@property (weak, nonatomic) IBOutlet UILabel *paihaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhuangtaiLabel;
@property (weak, nonatomic) IBOutlet UILabel *biaozhunLabel;
@property (weak, nonatomic) IBOutlet UILabel *biaomianLabel;
@property (weak, nonatomic) IBOutlet UILabel *fumoLabel;
@property (weak, nonatomic) IBOutlet UILabel *changjiaLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhongliangLabel;
@property (weak, nonatomic) IBOutlet UILabel *shengyuLabel;
@property (weak, nonatomic) IBOutlet UILabel *danjianLabel;
@property (weak, nonatomic) IBOutlet UILabel *gongjinLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIButton *shopBtn;

@property (nonatomic, copy) NSDictionary *dataDic;
@property (nonatomic, assign) NSInteger orderMoney;


@end

@implementation WholeBoardDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //配置信息
    [self configurateInfo];
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
        
        if (_stepper.value > 0) {
            
            [self placeOrder:UseType_OrderMoney];
            
        } else {
            [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请先添加数量" time:0 aboutType:WHShowViewMode_Text state:NO];
        }
        
    }];
}

- (IBAction)buyNow:(UIButton *)sender {
    
    [[PublicFuntionTool sharedInstance] isHadLogin:^{
        
        if (_stepper.value > 0) {
            
            [self placeOrder:UseType_BuyNow];
            
        } else {
            [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请先添加数量" time:0 aboutType:WHShowViewMode_Text state:NO];
        }
        
    }];
}


- (void)configurateInfo {
    
    _totalLabel.adjustsFontSizeToFitWidth = YES;
    self.stepper.maxValue = [_wholeModel.kucun integerValue]>10?10:[_wholeModel.kucun integerValue];
    self.stepper.value = _wholeModel.value;
    _guigeLabel.text = _wholeModel.guige;
    _paihaoLabel.text = _wholeModel.xinghao;
    _zhuangtaiLabel.text = _wholeModel.zhuangtai;
    _biaozhunLabel.text = _wholeModel.gongyibiaozhun;
    _biaomianLabel.text = _wholeModel.lasi;
    _fumoLabel.text = _wholeModel.fumo;
    _changjiaLabel.text = _wholeModel.canzhaozhishu;
    _zhongliangLabel.text = [NSString stringWithFormat:@"%@kg",_wholeModel.zhongliang];
    _shengyuLabel.text = [NSString stringWithFormat:@"%@件",_wholeModel.kucun];
    _danjianLabel.text = [NSString stringWithFormat:@"%@元",_wholeModel.danpianzhengbanjiage];
    _gongjinLabel.text = [NSString stringWithFormat:@"%@元/公斤", _wholeModel.danjia];
    _gongjinLabel.attributedText = [UILabel getAttributedFromRange:[_gongjinLabel.text rangeOfString:@"元/公斤"] WithColor:[UIColor Grey_OrangeColor] andFont:[UIFont systemFontOfSize:10 weight:UIFontWeightSemibold] allFullText:_gongjinLabel.text];
    //修改选中的数量
    MJWeakSelf
    _stepper.valueChanged = ^(double value) {
//        NSLog(@"%f---%ld", value, _wholeModel.value);
        if (weakSelf.selectValue) {
            weakSelf.selectValue(value);
        }
        
    };
}

- (void)refreshBottomViewInfo {
    
    [[ShoppingCarSingle sharedShoppingCarSingle] getServerShopCarAmountAndTotalfee:^(NSString *amout, NSString *totalfee) {
        
        self.shopBtn.badgeValue = amout;
    }];
}


- (void)placeOrder:(UseType)useType {
    
    NSString *amount = [NSNumber numberWithFloat:_stepper.value].stringValue;
    
    [[PublicFuntionTool sharedInstance] placeOrderCommonInterfaceWithUseType:useType moneyWithOrderType:GetOrderType_ZhengBan chang:_wholeModel.arg1 kuan:_wholeModel.arg2 hou:_wholeModel.arg3 amount:amount type:@"整只" erjimulu:_wholeModel.lvxing orderMoney:[[NSNumber alloc] initWithInteger:self.orderMoney].stringValue successBlock:^(NSDictionary *dataDic) {
        
        self.dataDic = dataDic;
        self.orderMoney = [self.dataDic[@"orderMoney"] integerValue];
        [self placeOrder:UseType_AddShopCar];
        
    } buyNowSuccessBlock:^(ShopCar *shopCar) {
        
        ConfirmOrderVC *confirm = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"ConfirmOrderVC"];
        confirm.carArr = @[shopCar];
        confirm.fromtype = FromVCType_Buy;
        [self.navigationController pushViewController:confirm animated:YES];
        
    } addCarSuccessBlock:^{
        
        [self refreshBottomViewInfo];
        self.totalLabel.text = [NSString stringWithFormat:@"合计:%@", [NSNumber numberWithInteger:self.orderMoney]];
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

@end
