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
#import "ExpressInfoManager.h"

@interface OrderNewDetailVC ()

@property (nonatomic, strong) NSMutableArray *detailDataSource;
@property (nonatomic, strong) NSMutableArray *wuliuArray;
@property (nonatomic, strong) OrderModel *orderModel;

@end

@implementation OrderNewDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailDataSource = [NSMutableArray array];
    self.wuliuArray = [NSMutableArray array];
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
                NSArray *expNoArr = [self.orderModel.logisticsNo componentsSeparatedByString:@","];
                NSArray *expNameArr = [self.orderModel.logisticsName componentsSeparatedByString:@","];
                
                for (int i=0; i<expNoArr.count; i++) {
                    
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    
                    [dic setObject:expNameArr[i] forKey:@"expName"];
                    [dic setObject:[ExpressInfoManager getExpressCodeWithName:expNameArr[i]] forKey:@"expCode"];
                    [dic setObject:expNoArr[i] forKey:@"expNo"];
                    [dic setObject:self.orderModel.logisticsTime forKey:@"expTime"];
                    
                    [self.wuliuArray addObject:dic];
                    
                }
            }
            
            totalWeight += [car.zongzhongliang floatValue];
            [self.detailDataSource addObject:car];
        }
        self.orderModel.zongjianshu = [NSString stringWithFormat:@"%ld件", self.listModel.detail.count];
        self.orderModel.totalMoney = [NSString stringWithFormat:@"%@元",self.listModel.totalMoney];
        self.orderModel.wuliufei = [NSString stringWithFormat:@"%@元",self.listModel.wuliufei];
        self.orderModel.zongzhongliang = [NSNumber numberWithFloat:totalWeight].stringValue;
        
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
        return self.wuliuArray.count;
    } else if (section==1) {
        return 1;
    } else {
        return self.detailDataSource.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return [UtilsMold creatCell:@"WuLiuCell" table:tableView deledate:self model:[self.wuliuArray objectAtIndex:indexPath.row] data:@"" andCliker:^(NSDictionary *clueDic) {
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
        
        NSDictionary *dic = [self.wuliuArray objectAtIndex:indexPath.row];
        
        WuLiuVC *wuliu = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"WuLiuVC"];
        wuliu.expNo = [dic objectForKey:@"expNo"];
        wuliu.expCode = [dic objectForKey:@"expCode"];
        wuliu.expName = [dic objectForKey:@"expName"];
        
        [self.navigationController pushViewController:wuliu animated:YES];
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
