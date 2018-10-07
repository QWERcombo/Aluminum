//
//  ConfirmOrderVC.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/5/16.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "ConfirmOrderVC.h"
#import "AddressViewController.h"
#import "OrderPayVC.h"

@interface ConfirmOrderVC () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UITableView *confirmOrderDataSource;
@property (nonatomic, strong) AddressModel *addressModel;
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;
@property (weak, nonatomic) IBOutlet UILabel *wuliufeiLab;
@property (weak, nonatomic) IBOutlet UILabel *shuliangLab;


@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UISwitch *zitiSwitch;
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UISwitch *dayinSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *biaoqianSwitch;
@property (weak, nonatomic) IBOutlet UITextField *noteTF;


@end

@implementation ConfirmOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.addressModel = nil;
    CGFloat total = 0;
    NSInteger shuliang = 0;
    for (ShopCar *car in self.carArr) {
        total += [car.money floatValue];
        shuliang += [car.productNum integerValue];
    }
    self.moneyLab.text = [NSString stringWithFormat:@"%@元", [NSString getStringAfterTwo:[NSNumber numberWithFloat:total].stringValue]];
    NSString *shuliangStr = [NSString stringWithFormat:@"%ld", shuliang];
    self.shuliangLab.text = [NSString stringWithFormat:@"共 %@ 件", shuliangStr];
//    self.shuliangLab.attributedText = [UILabel labGetAttributedStringFrom:2 toEnd:shuliangStr.length WithColor:[UIColor colorWithHexString:@"2F75EC"] andFont:nil allFullText:self.shuliangLab.text];
    self.confirmOrderDataSource.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self getDefaultAddressModel];
}

- (IBAction)confirmClicker:(UIButton *)sender {
    
    if (!self.addressModel && !self.zitiSwitch.isOn) {
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请先选择地址！" time:0 aboutType:WHShowViewMode_Text state:NO];
        return;
    }
    
    if (self.fromtype == FromVCType_Buy) {
        //直接购买下单
        ShopCar *shopcar = [self.carArr firstObject];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:shopcar.type forKey:@"type"];
        [dict setValue:shopcar.productNum forKey:@"amount"];
        [dict setValue:shopcar.zhonglei forKey:@"zhonglei"];
        [dict setValue:shopcar.erjimulu forKey:@"erjimulu"];
        [dict setValue:shopcar.money forKey:@"money"];
        [dict setValue:[UserData currentUser].phone forKey:@"phone"];
        if (self.zitiSwitch.isOn) {
            [dict setValue:nil forKey:@"addressId"];
            [dict setValue:@"自提" forKey:@"ziti"];
        } else {
            [dict setValue:self.addressModel.id forKey:@"addressId"];
        }
        if (self.dayinSwitch.isOn) {
            [dict setValue:@"打包" forKey:@"isPackage"];
        } else {
            [dict setValue:@"不打包" forKey:@"isPackage"];
        }
        if (self.biaoqianSwitch.isOn) {
            [dict setValue:@"打印标签" forKey:@"isTip"];
        } else {
            [dict setValue:@"不打印标签" forKey:@"isTip"];
        }
        [dict setValue:self.noteTF.text forKey:@"remark"];

        if ([shopcar.zhonglei isEqualToString:@"圆棒"]) {
            [dict setValue:shopcar.length forKey:@"chang"];
            [dict setValue:shopcar.width forKey:@"kuang"];
        } else {
            [dict setValue:shopcar.length forKey:@"chang"];
            [dict setValue:shopcar.width forKey:@"kuang"];
            [dict setValue:shopcar.height forKey:@"hou"];
        }

        
        [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_OrderSave andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
//            NSLog(@"buy: +++%@", resultDic);
//            [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"下单成功!" time:0 aboutType:WHShowViewMode_Text state:YES];
            
            OrderListModel *orderList = [[OrderListModel alloc] init];
            orderList.wuliufei = [NSString stringWithFormat:@"%@", resultDic[@"newOrders"][@"wuliufei"]];
            orderList.totalMoney = [NSString stringWithFormat:@"%@", resultDic[@"newOrders"][@"money"]];
            orderList.no = [NSString stringWithFormat:@"%@", resultDic[@"no"]];
            
            OrderPayVC *pay = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"OrderPayVC"];
            pay.orderModel = orderList;
            [self.navigationController pushViewController:pay animated:YES];
            
        } failure:^(NSString *error, NSInteger code) {
            
        }];
        
    } else {
        //购物车下单
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        NSMutableString *orderIds = [NSMutableString string];
        for (ShopCar *car in self.carArr) {
            [orderIds appendString:car.id];
            [orderIds appendString:@","];
        }
        [dict setValue:[orderIds substringToIndex:orderIds.length-1] forKey:@"gouwucheIds"];
//        [dict setValue:self.addressModel.id forKey:@"addressId"];
        [dict setValue:[UserData currentUser].phone forKey:@"phone"];
        if (self.zitiSwitch.isOn) {
            [dict setValue:@"" forKey:@"addressId"];
            [dict setValue:@"自提" forKey:@"ziti"];
        } else {
            [dict setValue:self.addressModel.id forKey:@"addressId"];
        }
        if (self.dayinSwitch.isOn) {
            [dict setValue:@"打包" forKey:@"isPackage"];
        } else {
            [dict setValue:@"不打包" forKey:@"isPackage"];
        }
        if (self.biaoqianSwitch.isOn) {
            [dict setValue:@"打印标签" forKey:@"isTip"];
        } else {
            [dict setValue:@"不打印标签" forKey:@"isTip"];
        }
        [dict setValue:self.noteTF.text forKey:@"remark"];
        
        
        [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_SaveFromGouwuche andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
//            NSLog(@"---%@", resultDic);
            [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"下单成功" time:0 aboutType:WHShowViewMode_Text state:YES];
            //刷新购物车列表
            [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshNewData" object:nil];
            
            
            OrderListModel *orderList = [[OrderListModel alloc] init];
            orderList.wuliufei = [NSString stringWithFormat:@"%@", resultDic[@"newOrders"][@"wuliufei"]];
            orderList.totalMoney = [NSString stringWithFormat:@"%@", resultDic[@"newOrders"][@"money"]];
            orderList.no = [NSString stringWithFormat:@"%@", resultDic[@"no"]];
            
            OrderPayVC *pay = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"OrderPayVC"];
            pay.orderModel = orderList;
            [self.navigationController pushViewController:pay animated:YES];
            
        } failure:^(NSString *error, NSInteger code) {
            
        }];
        
    }
}

- (IBAction)addAddress:(UIButton *)sender {
    
    AddressViewController *address = [[AddressViewController alloc] init];
    __weak typeof(self) weakself = self;
    address.SelectAddressBlock = ^(AddressModel *address) {
        weakself.addressView.hidden = YES;
        weakself.addressModel = address;
        weakself.nameLab.text = address.name;
        weakself.phoneLab.text = address.phone;
        weakself.addressLab.text = [NSString stringWithFormat:@"%@ %@ %@ %@", address.sheng,address.shi,address.qu,address.detailAddress];
        [weakself.addressBtn setTitle:@"" forState:UIControlStateNormal];
    };
    
    [self.navigationController pushViewController:address animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.carArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [UtilsMold creatCell:@"ConfirmOrderCell" table:tableView deledate:self model:[self.carArr objectAtIndex:indexPath.row] data:nil andCliker:^(NSDictionary *clueDic) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"ConfirmOrderCell" data:nil model:nil indexPath:indexPath];
}


- (void)getDefaultAddressModel {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[UserData currentUser].id forKey:@"userId"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_GetAddressByPhone andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
//        NSLog(@"%@", resultDic);
        NSArray *dataSource = resultDic[@"result"];
        
        for (NSDictionary *dic in dataSource) {
            
            AddressModel *model = [[AddressModel alloc] initWithDictionary:dic error:nil];
            
            if ([model.moren isEqualToString:@"1"]) {
                
                self.addressModel = model;
                self.nameLab.text = model.name;
                self.phoneLab.text = model.phone;
                self.addressLab.text = [NSString stringWithFormat:@"%@ %@ %@ %@", model.sheng,model.shi,model.qu,model.detailAddress];
                [self.addressBtn setTitle:@"" forState:UIControlStateNormal];
                
                break;
            }
        }
        
        
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
    
}

#pragma mark --- Handle

- (IBAction)ziti:(UISwitch *)sender {
    NSLog(@"自提 %d", sender.isOn);
    self.addressView.hidden = sender.isOn;
}

- (IBAction)dayin:(UISwitch *)sender {
    NSLog(@"打印 %d", sender.isOn);
}

- (IBAction)biaoqian:(UISwitch *)sender {
    NSLog(@"尺寸 %d", sender.isOn);
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
