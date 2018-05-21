//
//  OrderViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/8.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderDetailViewController.h"
#import "OrderNewDetailVC.h"
#import "OrderPayVC.h"

#define Button_Width  80
#define Button_Margin  ((SCREEN_WIGHT-80*4)/5)

@interface OrderViewController ()
@property (nonatomic, assign) NSInteger lastSelected;
@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, copy) NSString *type;
@end

@implementation OrderViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    //进入刷新状态
    [self.tabView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor mianColor:1];
    [self setupSubviews];
    
    self.pageNumber = 1;
    self.type = @"";
    //下拉刷新
    self.tabView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getDataSource:1 withType:self.type];
    }];
    //自动更改透明度
    self.tabView.mj_header.automaticallyChangeAlpha = YES;
    //上拉刷新
    self.tabView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getDataSource:self.pageNumber+1 withType:self.type];
    }];
    
    self.tabView.ly_emptyView = [[PublicFuntionTool sharedInstance] getEmptyViewWithType:WHShowEmptyMode_noData withHintText:@"暂无数据" andDetailStr:@"" withReloadAction:^{
        
    }];
}

- (void)setupSubviews {
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(50);
    }];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 50)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    NSArray *array = @[@"全部",@"待付款",@"待收货",@"已完成"];
    UIButton *lastButton = nil;
    for (NSInteger b=0; b<array.count; b++) {
        
        UIButton *button = [UIButton buttonWithTitle:[array objectAtIndex:b] andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor Black_WordColor] andHighlightedTitle:[UIColor Black_WordColor] andNormaImage:nil andHighlightedImage:nil];
        if (b==0) {
            [button setTitleColor:[UIColor mianColor:2] forState:UIControlStateNormal];
        }
        [button addTarget:self action:@selector(buttonCliker:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 150+b;
        
        [topView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(Button_Width));
            make.height.equalTo(@(17));
            make.centerY.equalTo(topView.mas_centerY);
            if (lastButton) {
                make.left.equalTo(lastButton.mas_right).offset(Button_Margin);
            } else {
                make.left.equalTo(topView.mas_left).offset(Button_Margin);
            }
        }];
        
        lastButton = button;
        
        UIView *bottomLine = [UIView new];
        bottomLine.tag = 200+b;
        bottomLine.hidden = b==0?NO:YES;
        bottomLine.backgroundColor = [UIColor mianColor:2];
        [topView addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(Button_Width));
            make.left.equalTo(button.mas_left);
            make.height.equalTo(@(3));
            make.bottom.equalTo(topView.mas_bottom);
        }];
    }
    
    self.lastSelected = 150;
}





#pragma mark --- UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataMuArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderModel *model = [self.dataMuArr objectAtIndex:indexPath.row];
    __weak typeof(self) weakself = self;
    
    return [UtilsMold creatCell:@"OrderListCell" table:tableView deledate:self model:model data:nil andCliker:^(NSDictionary *clueDic) {
//        NSLog(@"%@---%ld", clueDic, indexPath.row);
//        [weakself getExpressMoney:model.id];
        if ([clueDic[@"key"] isEqualToString:@"  材质证明下载  "]) {
            
        }
        if ([clueDic[@"key"] isEqualToString:@"  去支付  "]) {
            OrderPayVC *pay = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"OrderPayVC"];
            pay.orderModel = [self.dataMuArr objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:pay animated:YES];
        }
        if ([clueDic[@"key"] isEqualToString:@"  取消订单  "]) {
            [weakself cancelOrder:model.no withIndexPath:indexPath];
        }
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"OrderListCell" data:nil model:nil indexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    OrderDetailViewController *detail_o = [OrderDetailViewController new];
//    [self.navigationController pushViewController: detail_o animated:YES];
    OrderNewDetailVC *detail = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"OrderNewDetailVC"];
    OrderModel *model = [self.dataMuArr objectAtIndex:indexPath.row];
    detail.orderModel = model;
    [self.navigationController pushViewController:detail animated:YES];
}


#pragma mark ----- Action

- (void)buttonCliker:(UIButton *)sender {
//    NSLog(@"%@", sender.currentTitle);
    [sender setTitleColor:[UIColor mianColor:2] forState:UIControlStateNormal];
    
    UIButton *button = [self.view viewWithTag:self.lastSelected];
    [button setTitleColor:[UIColor Black_WordColor] forState:UIControlStateNormal];
    
    UIView *lastLine = [self.view viewWithTag:self.lastSelected+50];
    lastLine.hidden = YES;
    
    UIView *nowLine = [self.view viewWithTag:sender.tag+50];
    nowLine.hidden = NO;
    
    self.lastSelected = sender.tag;
    
    if (sender.tag-151<0) {
        self.type = @"";
    } else {
        self.type = SINT((sender.tag-151));
    }
    [self loadHeaderNewData];
}

#pragma mark ----- DataSource

- (void)loadHeaderNewData {
    [self getDataSource:1 withType:self.type];
}

- (void)loadFooterNewData {
    [self getDataSource:self.pageNumber+1 withType:self.type];
}

- (void)getDataSource:(NSInteger)page_number withType:(NSString *)type {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[UserData currentUser].phone forKey:@"phone"];
    [dict setValue:SINT(page_number) forKey:@"pageNum"];
    [dict setValue:@"10" forKey:@"pageSize"];
    [dict setValue:type forKey:@"type"]; // 0:待付款；1：待收货；2:已完成；不传查找全部
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_OrdersList andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
//        NSLog(@"++++%@", resultDic);
        NSArray *dataSourceArr = resultDic[@"result"];
        
        if (page_number == 1) {
            [self.dataMuArr removeAllObjects];
            for (NSDictionary *dict in dataSourceArr) {
                OrderModel *model = [[OrderModel alloc] initWithDictionary:dict error:nil];
                [self.dataMuArr addObject:model];
            }
            self.pageNumber = 1;
            [self.tabView.mj_footer endRefreshing];
            [self.tabView.mj_header endRefreshing];
        } else {
            if (dataSourceArr.count) {
                for (NSDictionary *dict in dataSourceArr) {
                    OrderModel *model = [[OrderModel alloc] initWithDictionary:dict error:nil];
                    [self.dataMuArr addObject:model];
                }
                self.pageNumber += 1;
                [self.tabView.mj_footer endRefreshing];
            } else {
                [self.tabView.mj_footer endRefreshingWithNoMoreData];
            }
            
        }
        
        
        [self.tabView reloadData];
    } failure:^(NSString *error, NSInteger code) {
        [self.tabView.mj_footer endRefreshing];
        [self.tabView.mj_header endRefreshing];
    }];
    
}


//获取物流费
- (void)getExpressMoney:(NSString *)orderNo {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:orderNo forKey:@"orderNo"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_GetWuliufei andCookie:nil showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"wuliufei: %@", resultDic);
        
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}

//取消订单
- (void)cancelOrder:(NSString *)orderNo withIndexPath:(NSIndexPath *)indexpath {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:orderNo forKey:@"no"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_OrdersRemove andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:msg time:0 aboutType:WHShowViewMode_Text state:YES];
        [self.dataMuArr removeObjectAtIndex:indexpath.row];
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
