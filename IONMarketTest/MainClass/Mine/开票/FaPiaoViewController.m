//
//  FaPiaoViewController.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/4/5.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "FaPiaoViewController.h"

@interface FaPiaoViewController ()

@end

@implementation FaPiaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"开票信息";
    [self setupSubviews];
    [self getData];
}

- (void)setupSubviews {
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.right.equalTo(self.view);
    }];
}

#pragma mark ----- UITableViewDelegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataMuArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold creatCell:@"TicketInfoCell" table:tableView deledate:self model:[self.dataMuArr objectAtIndex:indexPath.row] data:nil andCliker:^(NSDictionary *clueDic) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"TicketInfoCell" data:nil model:nil indexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.SelectModelBlock) {
        self.SelectModelBlock([self.dataMuArr objectAtIndex:indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getData {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[UserData currentUser].id forKey:@"userId"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_GetFapiaoByUser andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
//        NSLog(@"+++%@", resultDic);
        NSArray *dataSourceArr = resultDic[@"result"];
        for (NSDictionary *dic in dataSourceArr) {
            BillTicketModel *model = [[BillTicketModel alloc] initWithDictionary:dic error:nil];
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
