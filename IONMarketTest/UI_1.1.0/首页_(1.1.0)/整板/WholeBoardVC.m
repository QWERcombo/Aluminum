//
//  WholeBoardVC.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/10/18.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "WholeBoardVC.h"
#import "WholeBoardListCell.h"
#import "WholeBoardTapView.h"
#import "WholeBoardDetailVC.h"
#import "DisplayView.h"

@interface WholeBoardVC ()<UITableViewDataSource, UITableViewDelegate, WholeBoardTapViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *shopCarBtn;
@property (weak, nonatomic) IBOutlet UIButton *excuteBtn;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UIScrollView *topScrollView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger lastSelected;
@property (nonatomic, assign) NSInteger cur_page;//当前页数
@property (nonatomic, copy) NSString *xinghao;//选中的型号

@end

@implementation WholeBoardVC

- (UIScrollView *)topScrollView {
    if (!_topScrollView) {
        _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT-40, 40)];
        _topScrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_topScrollView];
    }
    return _topScrollView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"整板";
    self.dataSource = [NSMutableArray array];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.rowHeight = 100;
    [self configurateTopScrollView];
    self.xinghao = @"6061";
    [[UtilsData sharedInstance] MJRefreshNormalHeaderTarget:self table:self.tableView actionSelector:@selector(loadHeader)];
    [[UtilsData sharedInstance] MJRefreshAutoNormalFooterTarget:self table:self.tableView actionSelector:@selector(loadFooterMore)];
    
    [self getZhengBanListCur_page:1 withXinghao:self.xinghao];
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WholeBoardListCell *cell = [WholeBoardListCell initCell:tableView cellName:@"WholeBoardListCell" dataObject:[self.dataSource objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WholeBoardDetailVC *detail = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"WholeBoardDetailVC"];
    TBNavigationController *nav = [[TBNavigationController alloc] initWithRootViewController:detail];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
    
}

#pragma mark - Layout
- (void)configurateTopScrollView {
    
    NSArray *titleArray = @[@"6061T6",@"6061T651",@"7075T651",@"5052H552",@"5052H112"];
    
    CGFloat contentSizeWidth = 0;
    for (NSInteger i=0; i<titleArray.count; i++) {
        
        NSString *title = [titleArray objectAtIndex:i];
        
        CGSize rect = [title boundingRectWithSize:CGSizeMake(0, 38) font:[UIFont systemFontOfSize:14] lineSpacing:0];
        WholeBoardTapView *tapView = [[WholeBoardTapView alloc] initWithFrame:CGRectMake(contentSizeWidth, 0, rect.width+40, 40)];
        tapView.tag = 100+i;
        tapView.delegate = self;
        [tapView.showButton setTitle:title forState:UIControlStateNormal];
        
        contentSizeWidth += (rect.width+40);
        
        [self.topScrollView addSubview:tapView];
        
        if (i==0) {
            //默认选中第一个
            [tapView selectedStatus:YES];
            self.lastSelected = tapView.tag;
            
            
        }
    }
    
    [self.topScrollView setContentSize:CGSizeMake(contentSizeWidth, 40)];
    
}
- (void)setSelected:(UIButton *)selectedButton {

    WholeBoardTapView *currentTap = (WholeBoardTapView *)(selectedButton.superview);
    [currentTap selectedStatus:YES];
    
    WholeBoardTapView *lastTap = [self.view viewWithTag:self.lastSelected];
    [lastTap selectedStatus:NO];
    
    self.lastSelected = currentTap.tag;
}


#pragma mark - Handle

- (IBAction)excute:(UIButton *)sender {
    
    [[PublicFuntionTool sharedInstance] isHadLogin:^{
        NSLog(@"结算");
        
        
    }];
    
}

- (IBAction)goToShopCar:(UIButton *)sender {
    
    [[PublicFuntionTool sharedInstance] isHadLogin:^{
        NSLog(@"购物车");
        
        
    }];
}

- (IBAction)displayBtn:(UIButton *)sender {
    
    MJWeakSelf
    [DisplayView showDisplayViewWithDataSource:@[@"6061T6",@"6061T651",@"7075T651",@"5052H552",@"5052H112"] selectedIndexPath:^(NSString * _Nonnull title) {
        
        [weakSelf scrollTopScrollView:[title integerValue]];
        
    }];
    
}

- (void)scrollTopScrollView:(NSInteger)index {
    
    WholeBoardTapView *tapV = [self.view viewWithTag:100+index];
    [self setSelected:tapV.showButton];
    [self.topScrollView scrollRectToVisible:CGRectMake(tapV.mj_x, tapV.mj_y, tapV.mj_w, tapV.mj_h) animated:YES];
    
}

#pragma mark --- Data
- (void)loadHeader {
    [self getZhengBanListCur_page:1 withXinghao:self.xinghao];
}
- (void)loadFooterMore {
    [self getZhengBanListCur_page:self.cur_page+1 withXinghao:self.xinghao];
}
- (void)getZhengBanListCur_page:(NSInteger)cur_page withXinghao:(NSString *)xinghao {
    
    NSMutableDictionary *parDic = [NSMutableDictionary dictionary];
    [parDic setObject:[NSString stringWithFormat:@"%ld", cur_page] forKey:@"pageNum"];
    [parDic setObject:@"10" forKey:@"pageSize"];
    [parDic setObject:xinghao forKey:@"xinghao"];
    [parDic setObject:@"整板" forKey:@"zhonglei"];
    [parDic setObject:@"" forKey:@"houdu"];
    [parDic setObject:@"" forKey:@"zhijing"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:parDic imageArray:nil WithType:Interface_ZhengbanList andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        
        NSArray *dataArr = [resultDic objectForKey:@"result"];
        NSString *count = [resultDic objectForKey:@"count"];
        
        if (cur_page == 1) {
            self.cur_page = 1;
            [self.dataSource removeAllObjects];
            [self.tableView.mj_header endRefreshing];
        } else {
            self.cur_page ++;
        }
        
        for (NSDictionary *dataDic in dataArr) {
            
            WholeBoardModel *model = [[WholeBoardModel alloc] initWithDictionary:dataDic error:nil];
            
            [self.dataSource addObject:model];
        }
        
        if (self.dataSource.count < [count integerValue]) {
            [self.tableView.mj_footer endRefreshing];
        } else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        [self.tableView reloadData];
    } failure:^(NSString *error, NSInteger code) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
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

@end
