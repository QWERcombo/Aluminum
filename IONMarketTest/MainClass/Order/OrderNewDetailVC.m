//
//  OrderNewDetailVC.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/5/15.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "OrderNewDetailVC.h"
#import "NewDetailInfoCell.h"
#import "NewDetailListCell.h"
#import "WuLiuVC.h"

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
@property (weak, nonatomic) IBOutlet UIView *kuaidiView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *kuaidiHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *zhifuHeight;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;


@property (nonatomic, strong) NSMutableArray *detailDataSource;
@property (nonatomic, copy) NSArray *wuliuNoArray;
//@property (nonatomic, assign) BOOL isWuliuNo;
@property (nonatomic, strong) OrderModel *orderModel;

@end

@implementation OrderNewDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailDataSource = [NSMutableArray array];
    self.wuliuNoArray = [NSArray array];
    [self getOrderDetail:self.orderid];

    /*
    switch (self.orderDetailType) {
        case OrderDetailType_WillPay:
            self.kuaidiHeight.constant = 0.0;
            self.zhifuHeight.constant = 0.0;
            self.kuaidiView.hidden = YES;
            self.zhifuView.hidden = YES;
            self.headerView.frame = CGRectMake(0, 0, SCREEN_WIGHT, self.headerView.frame.size.height-74-74);
            break;
        case OrderDetailType_Ziti:
            self.kuaidiView.hidden = YES;
            self.kuaidiHeight.constant = 0.0;
            self.headerView.frame = CGRectMake(0, 0, SCREEN_WIGHT, self.headerView.frame.size.height-74);
            break;
        case OrderDetailType_WillSend:
            
            break;
        case OrderDetailType_Sended:
            self.kuaidiView.hidden = YES;
            self.kuaidiHeight.constant = 0.0;
            self.headerView.frame = CGRectMake(0, 0, SCREEN_WIGHT, self.headerView.frame.size.height-74);
            break;
        default:
            break;
    }
     */
}


- (void)getOrderDetail:(NSString *)orderId {
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setValue:orderId forKey:@"no"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dataDic imageArray:nil WithType:Interface_detailList andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
//        NSLog(@"___===%@", resultDic);
        NSArray *dataArr = resultDic[@"result"];
        
        float totalWeight=0;
        for (NSDictionary *dic in dataArr) {
            
            ShopCar *car = [[ShopCar alloc] initWithDictionary:dic error:nil];
            
            self.orderModel = [[OrderModel alloc] initWithDictionary:dic error:nil];
            
            if ([self.orderModel.logisticsNo integerValue]>0) {
                self.wuliuNoArray = [self.orderModel.logisticsNo componentsSeparatedByString:@","];
            }
            
            totalWeight += [car.zongzhongliang floatValue];
            [self.detailDataSource addObject:car];
        }
        self.orderModel.zongjianshu = [NSString stringWithFormat:@"%ld件", self.listModel.detail.count];
        self.orderModel.totalMoney = [NSString stringWithFormat:@"%@元",self.listModel.totalMoney];
        self.orderModel.wuliufei = [NSString stringWithFormat:@"%@元",self.listModel.wuliufei];
        self.orderModel.zongzhongliang = [NSNumber numberWithFloat:totalWeight].stringValue;
        
        
//        [self updateInfomation];
        [self.tableView reloadData];
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    } else if (section==1) {
        return 1;
    } else {
        return self.detailDataSource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return [UtilsMold creatCell:@"WuLiuCell" table:tableView deledate:self model:nil data:self.orderModel.logisticsName andCliker:^(NSDictionary *clueDic) {
        }];

    } else if (indexPath.section == 1) {
        
        NewDetailInfoCell *cell = [NewDetailInfoCell initCell:tableView cellName:@"NewDetailInfoCell" dataObject:self.orderModel];
        
        return cell;
        
    } else {
        
        NewDetailListCell *cell = [NewDetailListCell initCell:tableView cellName:@"NewDetailListCell" dataObject:[self.detailDataSource objectAtIndex:indexPath.row]];
        
        return cell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 70;
            break;
        case 1:
            return UITableViewAutomaticDimension;
            break;
        case 2:
            return 72;
            break;
        default:
            return 44;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        WuLiuVC *wuliu = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"WuLiuVC"];
        
        [self.navigationController pushViewController:wuliu animated:YES];
        
    }
    
}


- (void)updateInfomation {
    
    if ([self.orderModel.ziti isEqualToString:@"自提"]) {
        self.addressLab.text = @"自提地址：江苏省无锡市新吴区展鸿路18号院内乐切金属";
        self.nameLab.text = @"联系人：乐切金属";
        self.phoneLab.text = @"0510-88996061";
    } else {
        self.addressLab.text = [NSString stringWithFormat:@"收货地址 : %@",self.orderModel.address];
        self.nameLab.text = [NSString stringWithFormat:@"联系人 : %@", self.orderModel.currentAddress[@"name"]];
        self.phoneLab.text = self.orderModel.userPhone;
    }
    self.addressLab.adjustsFontSizeToFitWidth = YES;
    self.orderNo.text = self.orderModel.no;
    self.zhifufangshi.text = self.orderModel.paymethod;
    self.wuliufei.text = [NSString getStringAfterTwo:self.listModel.wuliufei];
    self.chanpinfei.text = [NSString getStringAfterTwo:self.listModel.totalMoney];
    NSInteger count=0;
    for (ShopCar *car in self.detailDataSource) {
        count+=[car.productNum integerValue];
    }
    self.countLabel.text = [NSString stringWithFormat:@"%ld",(long)count];
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    dateformatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    self.orderDate.text = [dateformatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[self.orderModel.createDate integerValue]/1000]];
    self.zhifushijian.text = [dateformatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[self.orderModel.payTime integerValue]/1000]];
    
    //没有支付方式和时间不显示高度
//    if (!self.orderModel.payTime.length) {
//        self.headerView.frame = CGRectMake(0, 0, SCREEN_WIGHT, self.headerView.frame.size.height-70);
//        self.zhifuView.hidden = YES;
//    }
    
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
