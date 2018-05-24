//
//  InventoryViewController.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/19.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "InventoryViewController.h"
#import "WholeBoardViewController.h"

@interface InventoryViewController ()<UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, strong) NSMutableArray *invenDataSource;
@property (nonatomic, strong) NSString *keyword;
@end

@implementation InventoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.invenDataSource = [NSMutableArray array];
    self.pageNumber = 1;
    [self getDataSource:self.pageNumber];
    
    [[UtilsData sharedInstance] MJRefreshNormalHeaderTarget:self table:self.tableView actionSelector:@selector(loadHeaderNewData)];
    [[UtilsData sharedInstance] MJRefreshAutoNormalFooterTarget:self table:self.tableView actionSelector:@selector(loadFooterNewData)];
    
    self.tableView.ly_emptyView = [[PublicFuntionTool sharedInstance] getEmptyViewWithType:WHShowEmptyMode_noData withHintText:@"暂无数据" andDetailStr:@"" withReloadAction:^{
        
    }];
}

#pragma mark ----delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.invenDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold creatCell:@"InventoryCell" table:tableView deledate:self model:[self.invenDataSource objectAtIndex:indexPath.row] data:nil andCliker:^(NSDictionary *clueDic) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"InventoryCell" data:nil model:nil indexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WholeBoardViewController *whole = [WholeBoardViewController new];
    whole.wholeBoardModel = [self.invenDataSource objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:whole animated:YES];
}


- (void)loadHeaderNewData {
    [self getDataSource:1];
}

- (void)loadFooterNewData {
    [self getDataSource:self.pageNumber+1];
}

- (void)getDataSource:(NSInteger)page_number {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:SINT(self.pageNumber) forKey:@"pageNum"];
    [dict setValue:@"10" forKey:@"pageSize"];
    if (self.keyword.length) {
        [dict setValue:self.keyword forKey:@"xinghao"];
    }
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_ZhengbanList andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"---+%@", resultDic);
        NSArray *resultArr = resultDic[@"result"];
        
        if (page_number == 1) {
            [self.invenDataSource removeAllObjects];
            for (NSDictionary *dataDic in resultArr) {
                WholeBoardModel *model = [[WholeBoardModel alloc] initWithDictionary:dataDic error:nil];
                [self.invenDataSource addObject:model];
            }
            [self.tableView.mj_footer endRefreshing];
            [self.tableView.mj_header endRefreshing];
        } else {
            if (resultArr.count) {
                for (NSDictionary *dataDic in resultArr) {
                    WholeBoardModel *model = [[WholeBoardModel alloc] initWithDictionary:dataDic error:nil];
                    [self.invenDataSource addObject:model];
                }
                [self.tableView.mj_footer endRefreshing];
            } else {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }        
        
        [self.view endEditing:YES];
        [self.tableView reloadData];
    } failure:^(NSString *error, NSInteger code) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
    
    
}

//搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.keyword = searchBar.text;
    [self getDataSource:1];
    
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
