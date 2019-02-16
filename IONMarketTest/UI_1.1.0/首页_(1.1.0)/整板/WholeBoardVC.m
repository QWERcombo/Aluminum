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
#import "ShopCarViewController.h"
#import "ConfirmOrderVC.h"
#import "ConditionDisplayView.h"
#import "SelectConditionView.h"

@interface WholeBoardVC ()<UITableViewDataSource, UITableViewDelegate, WholeBoardTapViewDelegate,UIGestureRecognizerDelegate,SelectConditionViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *shopCarBtn;
@property (weak, nonatomic) IBOutlet UIButton *excuteBtn;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//@property (strong, nonatomic) UIScrollView *topScrollView;
@property (nonatomic, strong) SelectConditionView *conditionView;

@property (nonatomic, strong) NSMutableArray *dataSource;//數據源
@property (nonatomic, strong) NSArray *titleArray;//型號數據源
@property (nonatomic, strong) NSMutableArray *selectArray;//有数量修改的数据源
@property (nonatomic, assign) NSInteger lastSelected;
@property (nonatomic, assign) NSInteger cur_page;//当前页数
@property (nonatomic, copy) NSString *xinghao;//选中的型号

@property (nonatomic, copy) NSDictionary *dataDic;
@property (nonatomic, assign) NSInteger orderMoney;

@property (nonatomic, assign) NSInteger mainIndex;
@property (nonatomic, assign) NSInteger subIndex;


@end

@implementation WholeBoardVC

//- (UIScrollView *)topScrollView {
//    if (!_topScrollView) {
//        _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT-40, 40)];
//        _topScrollView.showsHorizontalScrollIndicator = NO;
//        [self.view addSubview:_topScrollView];
//    }
//    return _topScrollView;
//}
- (SelectConditionView *)conditionView {
    if (!_conditionView) {
        _conditionView = [[SelectConditionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 40) titleArray:self.titleArray];
        _conditionView.delegate = self;
    }
    return _conditionView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    switch (self.showTye) {
        case WholeBoardShowType_Zhengban:
            self.title = @"整板";
            self.titleArray = [NSArray arrayWithObjects:@"品类",@"牌号",@"状态",@"厚度", nil];
            break;
        case WholeBoardShowType_BanChengPin:
            self.title = @"半成品";
            self.titleArray = [NSArray arrayWithObjects:@"品类",@"牌号",@"状态",@"厚度", nil];
            break;
        case WholeBoardShowType_YueBao:
            self.title = @"约包";
            self.titleArray = [NSArray arrayWithObjects:@"牌号",@"状态",@"厚度",@"更多", nil];
            break;
        default:
            self.title = @"";
            break;
    }
    
    self.totalLabel.adjustsFontSizeToFitWidth = YES;
    self.dataSource = [NSMutableArray array];
    self.selectArray = [NSMutableArray array];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.rowHeight = 100;

    [[UtilsData sharedInstance] MJRefreshNormalHeaderTarget:self table:self.tableView actionSelector:@selector(loadHeader)];
    [[UtilsData sharedInstance] MJRefreshAutoNormalFooterTarget:self table:self.tableView actionSelector:@selector(loadFooterMore)];
    self.tableView.ly_emptyView = [[PublicFuntionTool sharedInstance] getEmptyViewWithType:WHShowEmptyMode_noData withHintText:@"暂无数据" andDetailStr:@"" withReloadAction:^{
    }];
    
    [self getCateList];
    [self.view addSubview:self.conditionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //刷新信息
    [self refreshBottomViewInfo];
    [self refreshTotalLabel];
}

#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WholeBoardListCell *cell = [WholeBoardListCell initCell:tableView cellName:@"WholeBoardListCell" type:self.showTye == WholeBoardShowType_YueBao ? @"2" : @"1" dataObject:nil];
    //添加手势判断 enable为NO时 不跳转
    UITapGestureRecognizer *cell_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
    cell_tap.delegate = self;
    [cell.contentView addGestureRecognizer:cell_tap];
    
//    WholeBoardModel *model = [self.dataSource objectAtIndex:indexPath.row];
//    MJWeakSelf
//    [cell showSelectedBlock:^{
//        //有值修改的数据
//        if (model.value==0) {
//            [weakSelf.selectArray removeObject:model];
//        } else {
//            if (![weakSelf.selectArray containsObject:model]) {
//                [weakSelf.selectArray addObject:model];
//            }
//        }
//        [weakSelf refreshTotalLabel];
//    }];

    return cell;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[HYStepper class]]) {
        return YES;
    } else {
        return NO;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WholeBoardDetailVC *detail = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"WholeBoardDetailVC"];
    WholeBoardModel *model = [self.dataSource objectAtIndex:indexPath.row];
    detail.wholeModel = model;
    MJWeakSelf
    [detail setSelectValue:^(NSInteger selectNumber) {
        model.value = selectNumber;
        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }];
    
    TBNavigationController *nav = [[TBNavigationController alloc] initWithRootViewController:detail];
    [self presentViewController:nav animated:YES completion:^{
    }];
    
}


#pragma mark - Layout
//- (void)configurateTopScrollView {
//
//    CGFloat contentSizeWidth = 0;
//    for (NSInteger i=0; i<_titleArray.count; i++) {
//
//        MainItemTypeModel *dataModel = [_titleArray objectAtIndex:i];
//
//        CGSize rect = [dataModel.name boundingRectWithSize:CGSizeMake(0, 38) font:[UIFont systemFontOfSize:14] lineSpacing:0];
//        WholeBoardTapView *tapView = [[WholeBoardTapView alloc] initWithFrame:CGRectMake(contentSizeWidth, 0, rect.width+40, 40)];
//        tapView.tag = 100+i;
//        tapView.delegate = self;
//        [tapView.showButton setTitle:dataModel.name forState:UIControlStateNormal];
//
//        contentSizeWidth += (rect.width+40);
//
//        [self.topScrollView addSubview:tapView];
//
//        if (i==0) {
//            //默认选中第一个
//            [tapView selectedStatus:YES];
//            self.lastSelected = tapView.tag;
//            //設置選中型號
//            self.xinghao = dataModel.name;
//            //請求列表數據
//            [self getZhengBanListCur_page:1 withXinghao:self.xinghao];
//        }
//    }
//
////    [self.topScrollView setContentSize:CGSizeMake(contentSizeWidth, 40)];
//
//}
//- (void)setSelected:(UIButton *)selectedButton {
//
//    WholeBoardTapView *currentTap = (WholeBoardTapView *)(selectedButton.superview);
//    [currentTap selectedStatus:YES];
//
//    WholeBoardTapView *lastTap = [self.view viewWithTag:self.lastSelected];
//    [lastTap selectedStatus:NO];
//
//    self.lastSelected = currentTap.tag;
//    self.xinghao = ((MainItemTypeModel *)[self.titleArray objectAtIndex:self.lastSelected-100]).name;
//    [self getZhengBanListCur_page:1 withXinghao:self.xinghao];
//}
- (void)didSelectedConditionIndex:(NSInteger)index conditionTitle:(NSString *)title {
    NSLog(@"selected-----%ld",(long)index);
    if (index == -1) {
        //收起
        [ConditionDisplayView hideConditionDisplayView];
        
    } else {
        //选中
        self.mainIndex = index;
        
        [ConditionDisplayView showConditionDisplayViewWithTitle:[self.titleArray objectAtIndex:index] parameter:@"" selectTitle:title selectedBlock:^(NSString * _Nonnull title, BOOL isOver) {
            NSLog(@"----%@", title);
            if ([title isEqualToString:@"-1"]) {
                //收起子条件时清除主条件选中状态
                [self.conditionView reset];
                
            } else {
                if (isOver) {
                    [ConditionDisplayView hideConditionDisplayView];
                }
                
                [self.conditionView changeTitle:title index:self.mainIndex];
            }
            
        }];
        [self.view bringSubviewToFront:self.conditionView];
    }
}

#pragma mark - Handle

- (IBAction)excute:(UIButton *)sender {
    
    MJWeakSelf
    [[PublicFuntionTool sharedInstance] isHadLogin:^{
        
        if (weakSelf.selectArray.count) {
            
            [weakSelf multipleAddToShopCar];
        } else {
            [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请先添加数据" time:0 aboutType:WHShowViewMode_Text state:NO];
        }
    }];
}

- (IBAction)buyNow:(UIButton *)sender {
    
    MJWeakSelf
    [[PublicFuntionTool sharedInstance] isHadLogin:^{
        
        NSMutableArray *dataArr = [NSMutableArray array];
        for (WholeBoardModel *model in self.selectArray) {
            
            ShopCar *car = [ShopCar new];
            car.productNum = [NSNumber numberWithInteger:model.value].stringValue;
            car.type = @"整只";
            car.erjimulu = model.lvxing.name;
            car.money = [NSNumber numberWithFloat:[model.danpianzhengbanjiage floatValue]*model.value].stringValue;
            car.zhonglei = @"整板";
            car.length = model.arg3;
            car.width = model.arg2;
            car.height = model.arg1;
            
            [dataArr addObject:car];
        }
        
        
        ConfirmOrderVC *confirm = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"ConfirmOrderVC"];
        confirm.carArr = dataArr;
        confirm.fromtype = FromVCType_Buy;
        [weakSelf.navigationController pushViewController:confirm animated:YES];

    }];
}


- (IBAction)goToShopCar:(UIButton *)sender {
    
    [[PublicFuntionTool sharedInstance] isHadLogin:^{
        
        ShopCarViewController *shopcar = [[ShopCarViewController alloc] init];
        [self.navigationController pushViewController:shopcar animated:YES];
    }];
}

//- (IBAction)displayBtn:(UIButton *)sender {
//
//    MJWeakSelf
//    [DisplayView showDisplayViewWithDataSource:self.titleArray selectedIndexPath:^(NSString * _Nonnull title) {
//
//        [weakSelf scrollTopScrollView:[title integerValue]];
//
//    }];
//
//}

//- (void)scrollTopScrollView:(NSInteger)index {
//
//    WholeBoardTapView *tapV = [self.view viewWithTag:100+index];
//    [self setSelected:tapV.showButton];
//    [self.topScrollView scrollRectToVisible:CGRectMake(tapV.mj_x, tapV.mj_y, tapV.mj_w, tapV.mj_h) animated:YES];
//    self.xinghao = ((MainItemTypeModel *)[self.titleArray objectAtIndex:index]).name;
//    [self getZhengBanListCur_page:1 withXinghao:self.xinghao];
//}

#pragma mark --- Data
- (void)loadHeader {
    [self getZhengBanListCur_page:1 withXinghao:self.xinghao];
}
- (void)loadFooterMore {
    [self getZhengBanListCur_page:self.cur_page+1 withXinghao:self.xinghao];
}
- (void)getZhengBanListCur_page:(NSInteger)cur_page withXinghao:(NSString *)xinghao {
    
    NSMutableDictionary *parDic = [NSMutableDictionary dictionary];
    [parDic setObject:[NSString stringWithFormat:@"%ld", (long)cur_page] forKey:@"pageNum"];
    [parDic setObject:@"10" forKey:@"pageSize"];
    [parDic setObject:xinghao forKey:@"xinghao"];
    [parDic setObject:@"整板" forKey:@"zhonglei"];
    
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

- (void)getCateList {
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:nil imageArray:nil WithType:Interface_CateList andCookie:nil showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
        
        NSArray *dataArr = [resultDic objectForKey:@"list"];
        
        for (NSDictionary *dataDic in dataArr) {
            MainItemTypeModel *model = [[MainItemTypeModel alloc] initWithDictionary:dataDic error:nil];
//            [self.titleArray addObject:model];
        }
        
//        [self configurateTopScrollView];
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}

- (void)multipleAddToShopCar {
    
    NSMutableDictionary *parDic = [NSMutableDictionary dictionary];
    [parDic setObject:[UserData currentUser].phone forKey:@"phone"];
    NSMutableArray *dataArray = [NSMutableArray array];
    for (WholeBoardModel *model in self.selectArray) {
        
        if (model.value==0) {
            //
            continue;
        }
        
        NSMutableDictionary *subDataDic = [NSMutableDictionary dictionary];
        [subDataDic setObject:model.arg3 forKey:@"chang"];
        [subDataDic setObject:model.arg2 forKey:@"kuang"];
        [subDataDic setObject:model.arg1 forKey:@"hou"];
        [subDataDic setObject:@"整板" forKey:@"zhonglei"];
        [subDataDic setObject:@"整只" forKey:@"type"];
        [subDataDic setObject:model.lvxing.name forKey:@"erjimulu"];
        [subDataDic setObject:[NSNumber numberWithFloat:[model.danpianzhengbanjiage floatValue]*model.value].stringValue forKey:@"money"];
        [subDataDic setObject:[NSNumber numberWithInteger:model.value].stringValue forKey:@"amount"];
        
        [dataArray addObject:subDataDic];
    }
    
    [parDic setObject:[NEUSecurityUtil FormatJSONString:dataArray] forKey:@"data"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:parDic imageArray:nil WithType:Interface_batchSaveToGouwuche andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:msg time:0 aboutType:WHShowViewMode_Text state:YES];
        self.totalLabel.text = @"合计:0";
        
        [self refreshBottomViewInfo];
        [self.selectArray removeAllObjects];
        [self refreshTotalLabel];
        [self.tableView.mj_header beginRefreshing];
    } failure:^(NSString *error, NSInteger code) {
        
    }];
}

- (void)refreshBottomViewInfo {
    
    [[ShoppingCarSingle sharedShoppingCarSingle] getServerShopCarAmountAndTotalfee:^(NSString *amout, NSString *totalfee) {
        
        self.shopCarBtn.badgeValue = amout;
    }];
}

- (void)refreshTotalLabel {
    
    float totalPrice = 0.00;
    for (WholeBoardModel *model in self.selectArray) {
        
        totalPrice += ([model.danpianzhengbanjiage floatValue]*model.value);
    }
    
    self.totalLabel.text = [NSString stringWithFormat:@"合计:%@", [NSNumber numberWithFloat:totalPrice]];
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
