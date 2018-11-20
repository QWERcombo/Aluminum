//
//  TicketInfoVC.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/6/6.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "TicketInfoVC.h"
#import "ApplyTicketViewController.h"

@interface TicketInfoVC ()
@property (nonatomic, strong) NSMutableArray *infoDataSource;
@end

@implementation TicketInfoVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: YES];
    [self getDataSource];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的开票信息";
    self.infoDataSource = [NSMutableArray array];
    
    UIButton *recordBtn = [UIButton buttonWithTitle:@"新增" andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    recordBtn.frame = CGRectMake(0, 0, 50, 40);
    [recordBtn addTarget:self action:@selector(payCliker:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:recordBtn];
    
    self.tableView.ly_emptyView = [[PublicFuntionTool sharedInstance] getEmptyViewWithType:WHShowEmptyMode_noData withHintText:@"暂无数据" andDetailStr:@"" withReloadAction:^{
        
    }];
}


- (void)payCliker:(UIButton *)sender {
    
    ApplyTicketViewController *apply = [[ApplyTicketViewController alloc] initWithNibName:@"ApplyTicketViewController" bundle:nil];
    apply.ticketMode = TicketMode_Add;
    [self.navigationController pushViewController:apply animated:YES];
    
}


- (void)getDataSource {
    
    [self.infoDataSource removeAllObjects];
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setValue:[UserData currentUser].user_id forKey:@"userId"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dataDic imageArray:nil WithType:Interface_GetFapiaoByUser andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        
        NSArray *dataArr = resultDic[@"result"];
        
        for (NSDictionary *dci in dataArr) {
            BillTicketModel *model = [[BillTicketModel alloc] initWithDictionary:dci error:nil];
            [self.infoDataSource addObject:model];
        }
        
        [self.tableView reloadData];
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
    
}


#pragma mark - delegate & datasource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold creatCell:@"TicketInfoCell" table:tableView deledate:self model:[self.infoDataSource objectAtIndex:indexPath.row] data:nil andCliker:^(NSDictionary *clueDic) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoDataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"TicketInfoCell" data:nil model:nil indexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BillTicketModel *model = [self.infoDataSource objectAtIndex:indexPath.row];
    if (self.PassBillModel) {
        self.PassBillModel(model);
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        
        ApplyTicketViewController *apply = [[ApplyTicketViewController alloc] initWithNibName:@"ApplyTicketViewController" bundle:nil];
        apply.ticketMode = TicketMode_Change;
        apply.billModel = [self.infoDataSource objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:apply animated:YES];
        
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
