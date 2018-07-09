//
//  TradeListViewController.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/20.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "TradeListViewController.h"

@interface TradeListViewController ()

@end

@implementation TradeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.listType == ListType_Record) {
        self.title = @"消费记录";
    }
    if (self.listType == ListType_Withdraw) {
        self.title = @"提现记录";
    }
    if (self.listType == ListType_huankuan) {
        self.title = @"还款记录";
    }
    self.tabView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self getDataSource];
    [self setupSubviews];
}

- (void)setupSubviews {
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
//    __weak typeof(self) weakself = self;
    self.tabView.ly_emptyView = [[PublicFuntionTool sharedInstance] getEmptyViewWithType:WHShowEmptyMode_noData withHintText:@"暂无交易明细" andDetailStr:@"" withReloadAction:^{
        
    }];

}


#pragma mark ----- UITableViewDelegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataMuArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold creatCell:@"TradeRecordCell" table:tableView deledate:self model:[self.dataMuArr objectAtIndex:indexPath.row] data:nil andCliker:^(NSDictionary *clueDic) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"TradeRecordCell" data:nil model:nil indexPath:indexPath];
}


#pragma mark ----- Actio

- (void)getDataSource {
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    NSString *url = @"";
    
    [dataDic setValue:[UserData currentUser].id forKey:@"userId"];
    
    if (self.listType == ListType_Record) {
        [dataDic setValue:@"1" forKey:@"pageNum"];
        [dataDic setValue:@"999" forKey:@"pageSize"];
        url = Interface_qianBaoBillList;
    }
    if (self.listType == ListType_Withdraw) {
        [dataDic setValue:@"1" forKey:@"p"];
        url = Interface_withdrawSave;
    }
    if (self.listType == ListType_huankuan) {
        [dataDic setValue:@"1" forKey:@"pageNum"];
        [dataDic setValue:@"999" forKey:@"pageSize"];
        url = Interface_BaitiaoHuanKuanList;
    }
    
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dataDic imageArray:nil WithType:url andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        
        NSArray *dataArray = resultDic[@"result"];

        for (NSDictionary *dict in dataArray) {

            WalletListModel *model = [[WalletListModel alloc] initWithDictionary:dict error:nil];

            [self.dataMuArr addObject:model];
        }
        
        [self.tabView reloadData];
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
