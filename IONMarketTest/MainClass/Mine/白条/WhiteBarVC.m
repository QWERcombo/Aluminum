//
//  WhiteBarVC.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/6/4.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "WhiteBarVC.h"
#import "InputViewController.h"

@interface WhiteBarVC ()
@property (weak, nonatomic) IBOutlet UITableView *whiteBarTableView;
@property (weak, nonatomic) IBOutlet UILabel *totalFeeLab;
@property (weak, nonatomic) IBOutlet UILabel *availFeeLab;
@property (weak, nonatomic) IBOutlet UILabel *huankuanLab;

@end

@implementation WhiteBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.whiteBarTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.title = @"白条";
//    UIButton *recordBtn = [UIButton buttonWithTitle:@"还款记录" andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
//    recordBtn.frame = CGRectMake(0, 0, 70, 40);
//    [recordBtn addTarget:self action:@selector(payCliker:) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:recordBtn];
    
    self.tabView.ly_emptyView = [[PublicFuntionTool sharedInstance] getEmptyViewWithType:WHShowEmptyMode_noData withHintText:@"暂无交易明细" andDetailStr:@"" withReloadAction:^{
        
    }];
    
    [self getDataSource];
    [self getInfo];
}

//- (void)payCliker:(UIButton *)sender {
//    
//    TradeListViewController *list = [[TradeListViewController alloc] init];
//    list.listType = ListType_huankuan;
//    [self.navigationController pushViewController:list animated:YES];
//}

- (IBAction)huankuanClicker:(UIButton *)sender {
    
    if ([self.huankuanLab.text integerValue]==0) {
        
        [[UtilsData sharedInstance] showAlertControllerWithTitle:@"提示" detail:@"未有白条未还款" doneTitle:@"是" cancelTitle:@"" haveCancel:NO doneAction:^{
            
        } controller:self];
        
        return;
    }
    InputViewController *input = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"InputViewController"];
    input.mode_way = Mode_Output;
    [self.navigationController pushViewController:input animated:YES];
}


#pragma mark ----- UITableViewDelegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataMuArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold creatCell:@"WhiteBarCell" table:tableView deledate:self model:[self.dataMuArr objectAtIndex:indexPath.row] data:nil andCliker:^(NSDictionary *clueDic) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"WhiteBarCell" data:nil model:nil indexPath:indexPath];
}


- (void)getDataSource {
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setValue:[UserData currentUser].user_id forKey:@"userId"];
    [dataDic setValue:@"1" forKey:@"pageNum"];
    [dataDic setValue:@"999" forKey:@"pageSize"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dataDic imageArray:nil WithType:Interface_BaitiaoBillList andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        
        NSArray *dataArray = resultDic[@"result"];
        
        for (NSDictionary *dict in dataArray) {
            
            WalletListModel *model = [[WalletListModel alloc] initWithDictionary:dict error:nil];
            
            [self.dataMuArr addObject:model];
        }
        
        self.huankuanLab.text = [NSString getStringAfterTwo:[resultDic[@"money"] stringValue]];
        
        [self.whiteBarTableView reloadData];
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}

- (void)getInfo {
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setValue:[UserData currentUser].user_id forKey:@"userId"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dataDic imageArray:nil WithType:Interface_GetBaitiaoEDuById andCookie:nil showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
        
        self.totalFeeLab.text = [NSString stringWithFormat:@"白条额度:%@", [NSString getStringAfterTwo:[resultDic[@"zongedu"] stringValue]]];
        self.availFeeLab.text = [NSString stringWithFormat:@"可用额度:%@", [NSString getStringAfterTwo:[resultDic[@"keyongedu"] stringValue]]];
        
    } failure:^(NSString *error, NSInteger code) {
        
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
