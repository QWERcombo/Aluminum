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
@property (weak, nonatomic) IBOutlet UILabel *chanpinfei;
@property (weak, nonatomic) IBOutlet UILabel *wuliufei;
@property (weak, nonatomic) IBOutlet UILabel *zhifufangshi;
@property (weak, nonatomic) IBOutlet UILabel *zhifushijian;
@property (weak, nonatomic) IBOutlet UIView *zhifuView;
@property (weak, nonatomic) IBOutlet UIView *headerView;


@property (nonatomic, strong) NSMutableArray *detailDataSource;

@property (nonatomic, strong) OrderModel *orderModel;

@end

@implementation OrderNewDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailDataSource = [NSMutableArray array];
    [self getOrderDetail:self.orderid];
}


- (void)getOrderDetail:(NSString *)orderId {
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setValue:orderId forKey:@"no"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dataDic imageArray:nil WithType:Interface_detailList andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
//        NSLog(@"___===%@", resultDic);
        NSArray *dataArr = resultDic[@"result"];
        
        for (NSDictionary *dic in dataArr) {
            
            ShopCar *car = [[ShopCar alloc] initWithDictionary:dic error:nil];
            
            self.orderModel = [[OrderModel alloc] initWithDictionary:dic error:nil];
            
            [self.detailDataSource addObject:car];
        }
        
        [self updateInfomation];
        [self.tableView reloadData];
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.detailDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold creatCell:@"OrderDetailCell" table:tableView deledate:self model:[self.detailDataSource objectAtIndex:indexPath.row] data:nil andCliker:^(NSDictionary *clueDic) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"OrderDetailCell" data:nil model:nil indexPath:indexPath];
}

- (void)updateInfomation {
    self.addressLab.text = [NSString stringWithFormat:@"收货地址 : %@",self.orderModel.address];
    self.nameLab.text = [NSString stringWithFormat:@"收货人 : %@", self.orderModel.currentAddress[@"name"]];
    self.phoneLab.text = self.orderModel.userPhone;
    self.orderNo.text = self.orderModel.no;
    self.zhifufangshi.text = self.orderModel.paymethod;
    self.wuliufei.text = [NSString getStringAfterTwo:self.listModel.wuliufei];
    self.chanpinfei.text = [NSString getStringAfterTwo:self.listModel.totalMoney];
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    dateformatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    self.orderDate.text = [dateformatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[self.orderModel.createDate integerValue]/1000]];
    self.zhifushijian.text = [dateformatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[self.orderModel.payTime integerValue]/1000]];
    
    //没有支付方式和时间不显示高度
    if (!self.orderModel.payTime.length) {
        self.headerView.frame = CGRectMake(0, 0, SCREEN_WIGHT, self.headerView.frame.size.height-70);
        self.zhifuView.hidden = YES;
    }
    
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
