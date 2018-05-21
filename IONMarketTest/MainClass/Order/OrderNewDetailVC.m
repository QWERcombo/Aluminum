//
//  OrderNewDetailVC.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/5/15.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "OrderNewDetailVC.h"

@interface OrderNewDetailVC ()
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *orderNo;
@property (weak, nonatomic) IBOutlet UILabel *orderDate;
@property (weak, nonatomic) IBOutlet UILabel *infoLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *amountLab;


@end

@implementation OrderNewDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.addressLab.text = self.orderModel.address;
    self.nameLab.text = [NSString stringWithFormat:@"%@", self.orderModel.currentAddress[@"name"]];
    self.phoneLab.text = self.orderModel.userPhone;
    self.orderNo.text = self.orderModel.no;
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    dateformatter.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    self.orderDate.text = [dateformatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[self.orderModel.createDate integerValue]]];
    self.infoLab.text = [NSString stringWithFormat:@"%@/%@", self.orderModel.zhonglei, self.orderModel.type];
    self.priceLab.text = [NSString stringWithFormat:@"%@元", self.orderModel.money];
    self.amountLab.text = self.orderModel.productNum;
    
}


#pragma mark - Table view data source
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
