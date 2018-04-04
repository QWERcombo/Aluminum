//
//  AddNewTicketViewController.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/21.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "AddNewTicketViewController.h"
#import "AddressViewController.h"
#import "AddressShowView.h"

@interface AddNewTicketViewController ()

@property (nonatomic, strong) AddressModel *addressM;
@property (weak, nonatomic) IBOutlet UIView *addressView;

@end

@implementation AddNewTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"申请发票";
    self.dataMuArr = [self.orderArr mutableCopy];
    [self setupSubviews];
}

- (void)setupSubviews {
    [self.view addSubview:self.tabView];
//    self.tabView.scrollEnabled = NO;
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(110);
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
        make.left.right.equalTo(self.view);
    }];
    
}


#pragma mark ----- UITableViewDelegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataMuArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold creatCell:@"EndTicketCell" table:tableView deledate:self model:[self.dataMuArr objectAtIndex:indexPath.row] data:nil andCliker:^(NSDictionary *clueDic) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"EndTicketCell" data:nil model:nil indexPath:indexPath];
}




- (IBAction)addAc:(UIButton *)sender {
    
    AddressViewController *address = [AddressViewController new];
    __weak typeof(self) weakself = self;
    [address setSelectAddressBlock:^(AddressModel *address) {
        weakself.addressM = address;
        
        AddressShowView *showView = [[AddressShowView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 100)];
        [showView loadData:weakself.addressM andCliker:^(NSString *clueStr) {
            if ([clueStr isEqualToString:@"0"]) {
                AddressViewController *address = [[AddressViewController alloc] init];
                [weakself.navigationController pushViewController:address animated:YES];
            }
        }];
        
        [weakself.addressView addSubview:showView];
        
        [weakself.tabView reloadData];
    }];
    [self.navigationController pushViewController:address animated:YES];
}

- (IBAction)doneAc:(UIButton *)sender {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableString *orderIds = [NSMutableString string];
    for (ShopCar *car in self.dataMuArr) {
        [orderIds appendString:car.id];
        [orderIds appendString:@","];
    }
    
    [dict setValue:[orderIds substringToIndex:orderIds.length-1] forKey:@"orderIds"]; //orderIds订单id，不是订单编号。开票订单id，多个用逗号开
    [dict setValue:@"" forKey:@"money"]; //开票总额
    [dict setValue:[UserData currentUser].id forKey:@"userId"];
    [dict setValue:@"" forKey:@"fapiaoId"]; //发票id
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_Login andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"++--+%@", resultDic);
        
        
    } failure:^(NSString *error, NSInteger code) {
        
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
