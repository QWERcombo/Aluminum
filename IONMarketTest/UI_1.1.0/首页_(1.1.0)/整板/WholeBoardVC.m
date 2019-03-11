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
#import "PinLeiModel.h"
#import "QiHuoModel.h"

@interface WholeBoardVC ()<UITableViewDataSource, UITableViewDelegate,UIGestureRecognizerDelegate,SelectConditionViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *shopCarBtn;
@property (weak, nonatomic) IBOutlet UIButton *excuteBtn;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;


@property (nonatomic, strong) SelectConditionView *conditionView;

@property (nonatomic, strong) NSMutableArray *dataSource;//數據源
@property (nonatomic, strong) NSArray *titleArray;//型號數據源
@property (nonatomic, strong) NSMutableArray *selectArray;//有数量修改的数据源
@property (nonatomic, assign) NSInteger lastSelected;
@property (nonatomic, assign) NSInteger cur_page;//当前页数

@property (nonatomic, copy) NSDictionary *dataDic;
@property (nonatomic, assign) NSInteger orderMoney;

@property (nonatomic, assign) NSInteger mainIndex;
@property (nonatomic, assign) NSInteger subIndex;

@property (nonatomic, strong) PinLeiModel *pinleiModel;//品类
@property (nonatomic, strong) MainItemTypeModel *cateModel;//牌号
@property (nonatomic, copy) NSString *houDu;//厚度
@property (nonatomic, copy) NSString *zhuangTai;//状态

@property (nonatomic, copy) NSString *bianMianGongyi;//表面工艺
@property (nonatomic, copy) NSString *changJia;//厂家
@property (nonatomic, copy) NSString *fuMo;//覆膜
@property (nonatomic, copy) NSString *moreTitle;//更多

@end

#define DEFAULT_ZHUANGTAI   @"T6"

@implementation WholeBoardVC


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
            self.title = @"整件";
            self.titleArray = [NSArray arrayWithObjects:@"品类",@"牌号",@"状态",@"厚度", nil];
            break;
        case WholeBoardShowType_BanChengPin:
            self.title = @"半成品";
            self.titleArray = [NSArray arrayWithObjects:@"品类",@"牌号",@"状态",@"厚度", nil];
            break;
        case WholeBoardShowType_YueBao:
            self.title = @"期货";
            self.titleArray = [NSArray arrayWithObjects:@"牌号",@"状态",@"厚度",@"更多", nil];
            self.bottomView.hidden = YES;
            self.bottomViewHeight.constant = 0.0;
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
    
    [self getZhengBanListCur_page:1 isShowLoading:YES];
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
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WholeBoardListCell *cell = [WholeBoardListCell initCell:tableView cellName:@"WholeBoardListCell" type:[NSString stringWithFormat:@"%ld", self.showTye+1] dataObject:[self.dataSource objectAtIndex:indexPath.row]];
    
    if (self.showTye != WholeBoardShowType_YueBao) {
        
        //添加手势判断 enable为NO时 不跳转
        UITapGestureRecognizer *cell_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
        cell_tap.delegate = self;
        [cell.contentView addGestureRecognizer:cell_tap];
        
    } else {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    MJWeakSelf
    [cell showSelectedBlock:^(NSString *value){
        if ([value isEqualToString:@"0"]) {
            //有值修改的数据
            WholeBoardModel *model = [self.dataSource objectAtIndex:indexPath.row];
            if (model.value==0) {
                [weakSelf.selectArray removeObject:model];
            } else {
                if (![weakSelf.selectArray containsObject:model]) {
                    [weakSelf.selectArray addObject:model];
                }
            }
            [weakSelf refreshTotalLabel];
        } else {
            //约包
            QiHuoModel *model = [self.dataSource objectAtIndex:indexPath.row];
            
            [self qiangYueWithModel:model];
        }
        
    }];

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
    
    if (self.showTye == WholeBoardShowType_Zhengban) {
        
        WholeBoardDetailVC *detail = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"WholeBoardDetailVC"];
        
        WholeBoardModel *model = [self.dataSource objectAtIndex:indexPath.row];
        detail.wholeModel = model;
        detail.zhuangTai = self.zhuangTai.length?self.zhuangTai:DEFAULT_ZHUANGTAI;
        MJWeakSelf
        [detail setSelectValue:^(NSInteger selectNumber) {
            model.value = selectNumber;
            if (model.value==0) {
                [weakSelf.selectArray removeObject:model];
            } else {
                if (![weakSelf.selectArray containsObject:model]) {
                    [weakSelf.selectArray addObject:model];
                }
            }
            [weakSelf refreshTotalLabel];
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        
        TBNavigationController *nav = [[TBNavigationController alloc] initWithRootViewController:detail];
        [self presentViewController:nav animated:YES completion:^{
        }];
        
    }
    
}


#pragma mark - Layout
- (void)didSelectedConditionIndex:(NSInteger)index conditionTitle:(NSString *)title {
//    NSLog(@"selected-----%ld",(long)index);
    if (index == -1) {
        //收起
        [ConditionDisplayView hideConditionDisplayView];
        
    } else {
        //选中
        self.mainIndex = index;
        
        [ConditionDisplayView showConditionDisplayViewWithTitle:[self.titleArray objectAtIndex:index] parameter:@"" selectTitle:self.moreTitle.length?self.moreTitle:title selectedBlock:^(id  _Nonnull dataObject, BOOL isOver) {

            NSString *showName = @"";

            if (isOver) {
                [ConditionDisplayView hideConditionDisplayView];
            }
            
            if ([dataObject isKindOfClass:[PinLeiModel class]]) {
                
                PinLeiModel *model = (PinLeiModel *)dataObject;
                self.pinleiModel = model;
                showName = model.name;
            } else if ([dataObject isKindOfClass:[MainItemTypeModel class]]) {
                
                MainItemTypeModel *model = (MainItemTypeModel *)dataObject;
                self.cateModel = model;
                showName = model.name;
            } else if ([dataObject isKindOfClass:[NSString class]]) {
                
                NSString *number = (NSString *)dataObject;
                
                if ([number integerValue] == -1) {
                    //收起子条件时清除主条件选中状态
                    [self.conditionView reset];
                } else if ([number integerValue] == -2) {
                    //重置子条件
                    [self.conditionView changeTitle:[self.titleArray objectAtIndex:index] index:self.mainIndex];
                    [ConditionDisplayView hideConditionDisplayView];
                    
                    switch (self.mainIndex) {
                        case 0:
                            if (self.showTye == WholeBoardShowType_YueBao) {
                                self.cateModel = nil;
                            } else {
                                self.pinleiModel = nil;
                            }
                            break;
                        case 1:
                            if (self.showTye == WholeBoardShowType_YueBao) {
                                self.zhuangTai = @"";
                            } else {
                                self.cateModel = nil;
                            }
                            break;
                        case 2:
                            if (self.showTye == WholeBoardShowType_YueBao) {
                                self.houDu = @"";
                            } else {
                                self.zhuangTai = @"";
                            }
                            break;
                        case 3:
                            if (self.showTye == WholeBoardShowType_YueBao) {
                                //更多
                                self.bianMianGongyi = @"";
                                self.fuMo = @"";
                                self.changJia = @"";
                                self.moreTitle = @"";
                            } else {
                                self.houDu = @"";
                            }
                            break;
                        default:
                            break;
                    }
                } else {
                    
                    showName = number;
                    
                    if ([[self.titleArray objectAtIndex:self.mainIndex] isEqualToString:@"状态"]) {
                        
                        self.zhuangTai = number;
                        
                    } else if ([[self.titleArray objectAtIndex:self.mainIndex] isEqualToString:@"厚度"]) {
                        
                        self.houDu = number;
                        
                    } else if ([[self.titleArray objectAtIndex:self.mainIndex] isEqualToString:@"更多"]) {
                        
                        NSArray *infoArr = [number componentsSeparatedByString:@","];
                        self.moreTitle = number;
                        self.bianMianGongyi = infoArr[0];
                        self.changJia = infoArr[1];
                        self.fuMo = infoArr[2];
                        
                    } else {
                        
                    }
                    
                }
                
            } else {
            }
            
            if (showName.length) {
                [self.conditionView changeTitle:showName index:self.mainIndex];
                
                [self getZhengBanListCur_page:1 isShowLoading:YES];
            } else {
                
                if ([dataObject integerValue] == -2) {
                    //重置子条件
                    [self getZhengBanListCur_page:1 isShowLoading:YES];
                }
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
            car.zhonglei = self.pinleiModel?self.pinleiModel.name:@"整板";
            car.zhuangtai = self.zhuangTai.length?self.zhuangTai:DEFAULT_ZHUANGTAI;
            
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

//抢约
- (void)qiangYueWithModel:(QiHuoModel *)model {
    
    [[PublicFuntionTool sharedInstance] isHadLogin:^{
        
        NSString *message = @"";
        if ([model.chang integerValue]>0) {
            message = [NSString stringWithFormat:@"抢约 %@ \"%@*%@*%@\",工作人员将尽快与您联系", model.hejinpaihao, model.hou, model.kuang, model.chang];
        } else {
            message = [NSString stringWithFormat:@"抢约 %@ \"%@*%@\",工作人员将尽快与您联系", model.hejinpaihao, model.hou, model.kuang];
        }
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSMutableDictionary *parDic = [NSMutableDictionary dictionary];
            [parDic setObject:model.id forKey:@"qihuoId"];
            [parDic setObject:[UserData currentUser].user_id forKey:@"userId"];
            
            [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:parDic imageArray:nil WithType:Interface_QiHuoOrder andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
                
                [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"已抢约" time:0 aboutType:WHShowViewMode_Text state:YES];
                
            } failure:^(NSString *error, NSInteger code) {
                
            }];
            
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alert addAction:ok];
        [alert addAction:cancel];
        
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
    }];
    
}

#pragma mark --- Data
- (void)loadHeader {
    [self getZhengBanListCur_page:1 isShowLoading:YES];
}
- (void)loadFooterMore {
    [self getZhengBanListCur_page:self.cur_page+1 isShowLoading:YES];
}
- (void)getZhengBanListCur_page:(NSInteger)cur_page isShowLoading:(BOOL)isShow {
    
    NSMutableDictionary *parDic = [NSMutableDictionary dictionary];
    [parDic setObject:[NSString stringWithFormat:@"%ld", (long)cur_page] forKey:@"pageNum"];
    [parDic setObject:@"20" forKey:@"pageSize"];
    NSString *requestUrl = @"";
    
    if (self.showTye == WholeBoardShowType_Zhengban) {
        
        if (self.pinleiModel) {
            [parDic setObject:self.pinleiModel.name forKey:@"pinlei"];
        }
        if (self.cateModel) {
            [parDic setObject:self.cateModel.name forKey:@"paihao"];
        }
        if (self.zhuangTai.length) {
            [parDic setObject:self.zhuangTai forKey:@"zhuangtai"];
        }
        if (self.houDu.length) {
            [parDic setObject:self.houDu forKey:@"houdu"];
        }
        requestUrl = Interface_ZhengbanList;
        
    } else if (self.showTye == WholeBoardShowType_BanChengPin) {
        
        if (self.pinleiModel) {
            [parDic setObject:self.pinleiModel.name forKey:@"pinlei"];
        }
        if (self.cateModel) {
            [parDic setObject:self.cateModel.name forKey:@"paihao"];
        }
        if (self.zhuangTai.length) {
            [parDic setObject:self.zhuangTai forKey:@"zhuangtai"];
        }
        if (self.houDu.length) {
            [parDic setObject:self.houDu forKey:@"houdu"];
        }
        requestUrl = Interface_Banchengpin;
        
    } else if (self.showTye == WholeBoardShowType_YueBao) {
        
        if (self.cateModel) {
            [parDic setObject:self.cateModel.name forKey:@"hejinpaihao"];
        }
        if (self.zhuangTai.length) {
            [parDic setObject:self.zhuangTai forKey:@"chanpinzhuangtai"];
        }
        if (self.houDu.length) {
            [parDic setObject:self.houDu forKey:@"hou"];
        }
        if (self.bianMianGongyi.length) {
            [parDic setObject:self.bianMianGongyi forKey:@"shifoupaoguang"];
        }
        if (self.changJia.length) {
            [parDic setObject:self.changJia forKey:@"changjia"];
        }
        if (self.fuMo.length) {
            [parDic setObject:self.fuMo forKey:@"fumoleixing"];
        }
        
        
        requestUrl = Interface_QiHuo;
        
    } else {
    }
    
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:parDic imageArray:nil WithType:requestUrl andCookie:nil showAnimation:isShow success:^(NSDictionary *resultDic, NSString *msg) {
        
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
            
            if (self.showTye == WholeBoardShowType_YueBao) {
                QiHuoModel *model = [[QiHuoModel alloc] initWithDictionary:dataDic error:nil];
                [self.dataSource addObject:model];
            } else {
                WholeBoardModel *model = [[WholeBoardModel alloc] initWithDictionary:dataDic error:nil];
                [self.dataSource addObject:model];
            }
            
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
        [subDataDic setObject:self.pinleiModel?self.pinleiModel.name:@"整板" forKey:@"zhonglei"];
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
        [self getZhengBanListCur_page:1 isShowLoading:NO];
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
