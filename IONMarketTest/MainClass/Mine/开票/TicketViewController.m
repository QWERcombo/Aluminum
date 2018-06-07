//
//  TicketViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/6/6.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "TicketViewController.h"
#import "ConfirmTicketVC.h"
#import "TicketInfoVC.h"

@interface TicketViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *weikaipiaoBtn;
@property (weak, nonatomic) IBOutlet UIButton *yikaipianBtn;
@property (weak, nonatomic) IBOutlet UITableView *ticketTableview;
@property (nonatomic, strong) NSMutableArray *ticketDataSource;
@property (nonatomic, strong) NSString *type;
@end

@implementation TicketViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self getDataSource:@"0"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"开票";
    self.ticketDataSource = [NSMutableArray array];
    [self.weikaipiaoBtn setSelected:YES];
    self.ticketTableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    UIButton *recordBtn = [UIButton buttonWithTitle:@"我的发票" andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    recordBtn.frame = CGRectMake(0, 0, 70, 40);
    [recordBtn addTarget:self action:@selector(payCliker:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:recordBtn];
    
    self.ticketTableview.ly_emptyView = [[PublicFuntionTool sharedInstance] getEmptyViewWithType:WHShowEmptyMode_noData withHintText:@"暂无数据" andDetailStr:@"" withReloadAction:^{
        
    }];
}

- (IBAction)weikaipiaoClicker:(UIButton *)sender {
    [self.weikaipiaoBtn setSelected:YES];
    [self.yikaipianBtn setSelected:NO];
    [self getDataSource:@"0"];//未开
}

- (IBAction)yikaipiaoClicker:(UIButton *)sender {
    [self.weikaipiaoBtn setSelected:NO];
    [self.yikaipianBtn setSelected:YES];
    [self getDataSource:@"1"];//已开
}

- (void)payCliker:(UIButton *)sender {
    
    TicketInfoVC *info = [[UIStoryboard storyboardWithName:@"Common" bundle:nil] instantiateViewControllerWithIdentifier:@"TicketInfoVC"];
    [self.navigationController pushViewController:info animated:YES];
    
}

- (void)getDataSource:(NSString *)type {
    [self.ticketDataSource removeAllObjects];
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setValue:type forKey:@"kaipiaoStatus"];
    [dataDic setValue:[UserData currentUser].phone forKey:@"phone"];
    self.type = type;
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dataDic imageArray:nil WithType:Interface_OrderList andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"--+%@", resultDic);
        
        NSArray *dataSourceArr = resultDic[@"result"];
        for (NSDictionary *dic in dataSourceArr) {
            OrderListModel *model = [[OrderListModel alloc] initWithDictionary:dic error:nil];
            [self.ticketDataSource addObject:model];
        }
        
        [self.ticketTableview reloadData];
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}

#pragma mark - delegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ticketDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold creatCell:@"TicketCell" table:tableView deledate:self model:[self.ticketDataSource objectAtIndex:indexPath.row] data:nil andCliker:^(NSDictionary *clueDic) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"TicketCell" data:nil model:nil indexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.type isEqualToString:@"0"]) {
        ConfirmTicketVC *confirm = [[UIStoryboard storyboardWithName:@"Common" bundle:nil] instantiateViewControllerWithIdentifier:@"ConfirmTicketVC"];
        confirm.model = [self.ticketDataSource objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:confirm animated:YES];
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
