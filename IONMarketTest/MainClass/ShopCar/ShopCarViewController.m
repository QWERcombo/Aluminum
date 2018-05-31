//
//  ShopCarViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/8.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "ShopCarViewController.h"
#import "ShopCarDetailViewController.h"
#import "ConfirmOrderVC.h"

@interface ShopCarViewController ()
@property (nonatomic, strong) NSMutableArray *selectArr; //选中的数据
@property (nonatomic, assign) CGFloat totoal; //选中的总价
@property (nonatomic, assign) NSInteger pageNumber;
@end

@implementation ShopCarViewController {
    UILabel *priceLabel;
    UILabel *infoLabel;
    UIButton *allButton;
    UIButton *excuteButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.selectArr = [NSMutableArray array];
    self.title = @"购物车";
    [self setupSubViews];
    self.pageNumber = 1;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"RefreshNewData" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getData) name:@"RefreshNewData" object:nil];
    
    //下拉刷新
    self.tabView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getDataSource:1];
    }];
    //进入刷新状态
    [self.tabView.mj_header beginRefreshing];
    //自动更改透明度
    self.tabView.mj_header.automaticallyChangeAlpha = YES;
    //上拉刷新
    self.tabView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self getDataSource:self.pageNumber+1];
    }];
    
    self.tabView.ly_emptyView = [[PublicFuntionTool sharedInstance] getEmptyViewWithType:WHShowEmptyMode_noData withHintText:@"暂无数据" andDetailStr:@"" withReloadAction:^{
        
    }];
}

- (void)getData {
    //进入刷新状态
    [self.tabView.mj_header beginRefreshing];
}

- (void)setupSubViews {
    self.tabView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tabView.delegate = self;
    self.tabView.dataSource = self;
    self.tabView.showsVerticalScrollIndicator = NO;
    self.tabView.showsHorizontalScrollIndicator = NO;
    self.tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tabView.backgroundColor = [UIColor mianColor:1];
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        if (self.navigationController.viewControllers.count==1) {
            make.bottom.equalTo(self.view.mas_bottom).offset(-50-50);
        } else {
            make.bottom.equalTo(self.view.mas_bottom).offset(-50);
        }
    }];
    
    [self createBottomView];
    
    self.tabView.ly_emptyView = [[PublicFuntionTool sharedInstance] getEmptyViewWithType:WHShowEmptyMode_noData withHintText:@"购物车还是空的 快去购买" andDetailStr:@"" withReloadAction:^{
        
    }];
}

- (void)createBottomView {
    UIView *bottomView = [[UIView alloc] init];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(50));
        if (self.navigationController.viewControllers.count==1) {
            make.bottom.equalTo(self.view.mas_bottom).offset(-50);
        } else {
            make.bottom.equalTo(self.view.mas_bottom).offset(0);
        }
        
    }];
    
    excuteButton = [UIButton buttonWithTitle:[NSString stringWithFormat:@"去结算(0)"] andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:IMG(@"Main_buy") andHighlightedImage:IMG(@"Main_buy")];
    [excuteButton addTarget:self action:@selector(excuteAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:excuteButton];
    [excuteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(bottomView);
        make.width.equalTo(@(140));
    }];
    
    allButton = [UIButton buttonWithTitle:@"全选" andFont:FONT_ArialMT(13) andtitleNormaColor:[UIColor Black_WordColor] andHighlightedTitle:[UIColor Black_WordColor] andNormaImage:nil andHighlightedImage:nil];
    [allButton setImage:IMG(@"select_0") forState:UIControlStateNormal];
    [allButton setImage:IMG(@"select_1") forState:UIControlStateSelected];
    [allButton addTarget:self action:@selector(allButtonCliker:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:allButton];
    [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(70));
        make.height.equalTo(@(50));
        make.left.equalTo(bottomView.mas_left).offset(15);
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
    allButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    
    priceLabel = [UILabel lableWithText:@"合计：￥0.00元" Font:FONT_ArialMT(13) TextColor:[UIColor Black_WordColor]];
    [bottomView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(15));
        make.left.equalTo(allButton.mas_right).offset(10);
        make.centerY.equalTo(allButton.mas_centerY);
    }];

    
}

#pragma mark --- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataMuArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakself = self;
    return [UtilsMold creatCell:@"ShopCarNewListCell" table:tableView deledate:self model:[self.dataMuArr objectAtIndex:indexPath.row] data:nil andCliker:^(NSDictionary *clueDic) {
        if ([clueDic[@"key"] isEqualToString:@"1"]) {
            [weakself.selectArr addObject:[weakself.dataMuArr objectAtIndex:indexPath.row]];
        } else if ([clueDic[@"key"] isEqualToString:@"-1"]) {
            [weakself.selectArr removeObject:[weakself.dataMuArr objectAtIndex:indexPath.row]];
        } else {
            
        }
        
        weakself.totoal = 0.f;
        if (self.selectArr.count) {
            allButton.selected = YES;
            for (ShopCar *car in weakself.selectArr) {
                weakself.totoal += [car.money floatValue];
            }
            priceLabel.text = [NSString stringWithFormat:@"合计：￥%.2lf元", weakself.totoal];
            [excuteButton setTitle:[NSString stringWithFormat:@"去结算(%ld)", self.selectArr.count] forState:UIControlStateNormal];
        } else {
            allButton.selected = NO;
            priceLabel.text = @"合计：￥0.00元";
            [excuteButton setTitle:@"去结算(0)" forState:UIControlStateNormal];
        }
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"ShopCarNewListCell" data:nil model:nil indexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ShopCar *car = [self.dataMuArr objectAtIndex:indexPath.row];
        [self.dataMuArr removeObject:car];
        [self.tabView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        if ([self.selectArr containsObject:car]) {
            [self.selectArr removeObject:car];
            self.totoal = 0.f;
            if (self.selectArr.count) {
                allButton.selected = YES;
                for (ShopCar *car in self.selectArr) {
                    self.totoal += [car.money floatValue];
                }
                priceLabel.text = [NSString stringWithFormat:@"合计：￥%.2lf元", self.totoal];
                [excuteButton setTitle:[NSString stringWithFormat:@"去结算(%ld)", self.selectArr.count] forState:UIControlStateNormal];
            } else {
                allButton.selected = NO;
                priceLabel.text = @"合计：￥0.00元";
                [excuteButton setTitle:@"去结算(0)" forState:UIControlStateNormal];
            }
        }
        
    }
}

#pragma mark ----- Action
//去结算
- (void)excuteAction:(UIButton *)sender {
    
//    ShopCarDetailViewController *detail = [[ShopCarDetailViewController alloc] init];
    ConfirmOrderVC *detail = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil]instantiateViewControllerWithIdentifier:@"ConfirmOrderVC"];
    detail.carArr = self.selectArr;
    if (!detail.carArr.count) {
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请先选择要结算的订单！" time:0 aboutType:WHShowViewMode_Text state:NO];
        return;
    }
    detail.fromtype = FromVCType_ShopCar;
    [self.navigationController pushViewController:detail animated:YES];
        
}

- (void)allButtonCliker:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        CGFloat totoal = 0;
        for (ShopCar *car in self.dataMuArr) {
            car.isSelectedCard = YES;
            totoal += [car.money floatValue];
        }
        [self.selectArr addObjectsFromArray:self.dataMuArr];
        priceLabel.text = [NSString stringWithFormat:@"合计：￥%.2lf元", totoal];  //更新价格
        [excuteButton setTitle:[NSString stringWithFormat:@"去结算(%ld)", self.selectArr.count] forState:UIControlStateNormal];
    } else {
        for (ShopCar *car in self.dataMuArr) {
            car.isSelectedCard = NO;
        }
        [self.selectArr removeAllObjects];
        priceLabel.text = @"合计：￥0.00元";
        [excuteButton setTitle:@"去结算(0)" forState:UIControlStateNormal];
    }
    [self.tabView reloadData];
}


- (void)getDataSource:(NSInteger)page_number {
    allButton.selected = NO;
    [excuteButton setTitle:@"去结算(0)" forState:UIControlStateNormal];
    priceLabel.text = @"合计：￥0.00元";
    [self.selectArr removeAllObjects];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[UserData currentUser].phone forKey:@"phone"];
    [dict setValue:@"10" forKey:@"pageSize"];
    [dict setValue:SINT(page_number) forKey:@"pageNum"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_GetGouwucheByUser andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"++---%@", resultDic);
        
        NSArray *dataSource = resultDic[@"result"];
        
        if (page_number == 1) {
            [self.dataMuArr removeAllObjects];
            for (NSDictionary *dic in dataSource) {
                ShopCar *model = [[ShopCar alloc] initWithDictionary:dic error:nil];
                [self.dataMuArr addObject:model];
            }
            self.pageNumber = 1;
            [self.tabView.mj_header endRefreshing];
            [self.tabView.mj_footer endRefreshing];
            if (!dataSource.count) {
                priceLabel.text = @"合计：￥0.00元";
            }
        } else {
            if (dataSource.count) {
                for (NSDictionary *dic in dataSource) {
                    ShopCar *model = [[ShopCar alloc] initWithDictionary:dic error:nil];
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
        [self.tabView.mj_header endRefreshing];
        [self.tabView.mj_footer endRefreshing];
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
