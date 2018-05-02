//
//  InventoryViewController.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/19.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "InventoryViewController.h"
#import "WholeBoardViewController.h"

@interface InventoryViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger pageNumber;
@end

@implementation InventoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pageNumber = 1;
    [self getDataSource];
    
    [[UtilsData sharedInstance] MJRefreshNormalHeaderTarget:self table:self.tabView actionSelector:@selector(loadHeaderNewData)];
    [[UtilsData sharedInstance] MJRefreshAutoNormalFooterTarget:self table:self.tabView actionSelector:@selector(loadFooterNewData)];
}

#pragma mark ----delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataMuArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold creatCell:@"InventoryCell" table:tableView deledate:self model:[self.dataMuArr objectAtIndex:indexPath.row] data:nil andCliker:^(NSDictionary *clueDic) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"InventoryCell" data:nil model:nil indexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WholeBoardViewController *whole = [WholeBoardViewController new];
    whole.wholeBoardModel = [self.dataMuArr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:whole animated:YES];
}


- (void)loadHeaderNewData {
    self.pageNumber = 1;
    [self getDataSource];
}

- (void)loadFooterNewData {
    self.pageNumber += 1;
    [self getDataSource];
}

- (void)getDataSource {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:SINT(self.pageNumber) forKey:@"pageNum"];
    [dict setValue:@"10" forKey:@"pageSize"];
    [dict setValue:@"7075" forKey:@"xinghao"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_ZhengbanList andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"---+%@", resultDic);
        
        for (NSDictionary *dataDic in resultDic) {
            WholeBoardModel *model = [[WholeBoardModel alloc] initWithDictionary:dataDic error:nil];
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
