//
//  ConfirmOrderVC.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/5/16.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "ConfirmOrderVC.h"
#import "AddressViewController.h"

@interface ConfirmOrderVC ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UITableView *confirmOrderDataSource;
@property (nonatomic, strong) AddressModel *addressModel;
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;
@property (weak, nonatomic) IBOutlet UILabel *wuliufeiLab;

@end

@implementation ConfirmOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.addressModel = nil;
    CGFloat total = 0;
    for (ShopCar *car in self.carArr) {
        total += [car.money floatValue];
    }
    self.priceLab.text = [NSString stringWithFormat:@"%.2lf", total];
}

- (IBAction)confirmClicker:(UIButton *)sender {
    if (!self.addressModel) {
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请先选择地址！" time:0 aboutType:WHShowViewMode_Text state:NO];
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableString *orderIds = [NSMutableString string];
    for (ShopCar *car in self.carArr) {
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

        [self.navigationController popToRootViewControllerAnimated:YES];
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}

- (IBAction)addAddress:(UIButton *)sender {
    AddressViewController *address = [[AddressViewController alloc] init];
    
    __weak typeof(self) weakself = self;
    address.SelectAddressBlock = ^(AddressModel *address) {
        weakself.addressModel = address;
        weakself.nameLab.text = address.name;
        weakself.phoneLab.text = address.phone;
        weakself.addressLab.text = [NSString stringWithFormat:@"%@ %@ %@ %@", address.sheng,address.shi,address.qu,address.detailAddress];
        weakself.addressBtn.hidden = YES;
    };
    
    [self.navigationController pushViewController:address animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.carArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [UtilsMold creatCell:@"OrderDetailCell" table:tableView deledate:self model:[self.carArr objectAtIndex:indexPath.row] data:nil andCliker:^(NSDictionary *clueDic) {
        
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
