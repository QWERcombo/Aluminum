//
//  TicketViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/14.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "TicketViewController.h"
#import "AddNewTicketViewController.h"
#import "ApplyTicketViewController.h"

@interface TicketViewController ()

#define Button_Width  100
#define Button_Margin  ((SCREEN_WIGHT-100*3)/4)

@property (nonatomic, assign) NSInteger lastSelected;

@property (nonatomic, strong) NSString *cellType;

@property (nonatomic, strong) NSIndexPath *lastIndexPath;// 选中的index

@property (nonatomic, strong) TicketModel *selectedModel;

@property (nonatomic, strong) NSMutableArray *selectOrderArr; // 选中开票的订单

@end

@implementation TicketViewController {
    UIButton *applyButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.selectOrderArr = [NSMutableArray array];
    self.cellType = @"0";
    [self getDataSource:@"0"];
    [self setupSubviews];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"RefreshFaPiaoNewData" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getData) name:@"RefreshFaPiaoNewData" object:nil];
}

- (void)getData {
    [self.dataMuArr removeAllObjects];
    [self getDataSource:self.cellType];
}

- (void)setupSubviews {
    [self.view addSubview:self.tabView];
    self.tabView.backgroundColor = [UIColor mianColor:1];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(50);
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
    }];
    
    self.tabView.ly_emptyView = [[PublicFuntionTool sharedInstance] getEmptyViewWithType:WHShowEmptyMode_noData withHintText:@"暂无订单,现在就去订购" andDetailStr:@"" withReloadAction:^{
        
    }];
        
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 50)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    NSArray *array = @[@"消费记录",@"已开发票",@"开票信息"];
    UIButton *lastButton = nil;
    for (NSInteger b=0; b<array.count; b++) {
        
        UIButton *button = [UIButton buttonWithTitle:[array objectAtIndex:b] andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor mianColor:2] andHighlightedTitle:[UIColor mianColor:2] andNormaImage:nil andHighlightedImage:nil];
        
        [button addTarget:self action:@selector(buttonCliker:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100+b;
        
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
    
    
    self.lastSelected = 100;
    
    
    
    applyButton = [UIButton buttonWithTitle:@"申请发票" andFont:FONT_ArialMT(18) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    [self.view addSubview:applyButton];
    applyButton.backgroundColor = [UIColor mianColor:2];
    [applyButton addTarget:self action:@selector(applyCliker:) forControlEvents:UIControlEventTouchUpInside];
    [applyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(50));
        make.left.right.bottom.equalTo(self.view);
    }];
    
}



#pragma mark ----- UITableViewDelegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataMuArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak typeof(self) weakself = self;
    if ([self.cellType isEqualToString:@"0"]) {
        
        OrderModel *order = nil;
        if (weakself.dataMuArr.count) {
            order = [weakself.dataMuArr objectAtIndex:indexPath.row];
        }
        TicketCell *cell = (TicketCell *)[UtilsMold creatCell:@"TicketCell" table:tableView deledate:weakself model:order data:nil andCliker:^(NSDictionary *clueDic) {
//            NSLog(@"+++%@", clueDic);
            if ([clueDic[@"key"] isEqualToString:@"1"]) {
                for (OrderModel *model in weakself.dataMuArr) {
                    if ([model.no isEqualToString:order.no]) { // 判断是否是同一订单编号
                        model.isSelectedCard = YES;
                        [weakself.selectOrderArr addObject:model];
                    }
                }
            } else if ([clueDic[@"key"] isEqualToString:@"-1"]) {
                for (OrderModel *model in weakself.dataMuArr) {
                    if ([model.no isEqualToString:order.no]) {
                        model.isSelectedCard = NO;
                        [weakself.selectOrderArr removeAllObjects];
                    }
                }
            }
            
            [weakself.tabView reloadData];
        }];
        
        return cell;
    } else if ([self.cellType isEqualToString:@"1"]) {
        
        FaPiaoModel *model = nil;
        if (self.dataMuArr.count) {
            model = [self.dataMuArr objectAtIndex:indexPath.row];
        }
        EndTicketCell *cell = (EndTicketCell *)[UtilsMold creatCell:@"EndTicketCell" table:tableView deledate:weakself model:model data:nil andCliker:^(NSDictionary *clueDic) {
            NSLog(@"+++%@", clueDic);
            
            
        }];
        
        return cell;
    } else {
        
        BillTicketModel *model = nil;
        if (weakself.dataMuArr.count) {
            model = [weakself.dataMuArr objectAtIndex:indexPath.row];
        }
        TicketInfoCell *cell = (TicketInfoCell *)[UtilsMold creatCell:@"TicketInfoCell" table:tableView deledate:weakself model:model data:nil andCliker:^(NSDictionary *clueDic) {
            NSLog(@"+++%@", clueDic);
            if ([clueDic[@"key"] isEqualToString:@"1"]) { //编辑
                
                ApplyTicketViewController *apply = [[ApplyTicketViewController alloc] initWithNibName:@"ApplyTicketViewController" bundle:nil];
                apply.mode = @"111";
                apply.billModel = [weakself.dataMuArr objectAtIndex:indexPath.row];
                [weakself.navigationController pushViewController:apply animated:YES];
                
            } else if ([clueDic[@"key"] isEqualToString:@"0"]) { //删除
                [weakself removeBillTicket:indexPath.row];
                
            } else {
            }
        }];
        
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellName = @"";
    if ([self.cellType isEqualToString:@"0"]) {
        cellName = @"TicketCell";
    } else if ([self.cellType isEqualToString:@"1"]) {
        cellName = @"EndTicketCell";
    } else {
        cellName = @"TicketInfoCell";
    }
    return [UtilsMold getCellHight:cellName data:nil model:nil indexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.cellType isEqualToString:@"2"]) {
        
    }
}



#pragma mark ----- Action

- (void)buttonCliker:(UIButton *)sender {
//    NSLog(@"%@", sender.currentTitle);
    UIView *lastLine = [self.view viewWithTag:self.lastSelected+100];
    lastLine.hidden = YES;
    
    UIView *nowLine = [self.view viewWithTag:sender.tag+100];
    nowLine.hidden = NO;
    
    self.cellType = SINT(sender.tag-100);
    self.lastSelected = sender.tag;
    [self.tabView reloadData];
    if (self.lastSelected==102) {
        [applyButton setTitle:@"新增开票信息" forState:UIControlStateNormal];
    } else {
        [applyButton setTitle:@"申请发票" forState:UIControlStateNormal];
    }
    
    [self.dataMuArr removeAllObjects];
    [self getDataSource:SINT(sender.tag-100)];
}

- (void)applyCliker:(UIButton *)sender {
    if (self.lastSelected==102) {
        ApplyTicketViewController *apply = [[ApplyTicketViewController alloc] initWithNibName:@"ApplyTicketViewController" bundle:nil];
        apply.mode = @"222";
        [self.navigationController pushViewController:apply animated:YES];
    } else {
        AddNewTicketViewController *addnew = [[AddNewTicketViewController alloc] initWithNibName:@"AddNewTicketViewController" bundle:nil];
        addnew.orderArr = self.selectOrderArr;
        
        if (!addnew.orderArr.count) {
            [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请先选择要开票的订单！" time:0 aboutType:WHShowViewMode_Text state:NO];
            return;
        }
        [self.navigationController pushViewController:addnew animated:YES];
    }
}



#pragma mark ----- DataSource
- (void)getDataSource:(NSString *)status {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSString *url = @"";
    if ([status isEqualToString:@"0"]) {
        url = Interface_OrderList;
        [dict setValue:[UserData currentUser].phone forKey:@"phone"];
        [dict setValue:@"0" forKey:@"kaipiaoStatus"];
    } else if ([status isEqualToString:@"1"]) {
        url = Interface_GetkaipiaoByUser;
        [dict setValue:[UserData currentUser].id forKey:@"userId"];
        [dict setValue:@"开票成功" forKey:@"kaipiaoStatus"];
    } else {
        url = Interface_GetFapiaoByUser;
        [dict setValue:[UserData currentUser].id forKey:@"userId"];
    }
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:url andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"+++%@", resultDic);
        
        if ([status isEqualToString:@"0"]) {
            NSArray *dataSourceArr = resultDic[@"result"];
            for (NSDictionary *dic in dataSourceArr) {
                OrderModel *model = [[OrderModel alloc] initWithDictionary:dic error:nil];
                [self.dataMuArr addObject:model];
            }
        } else if ([status isEqualToString:@"1"]) {
            NSArray *dataSourceArr = resultDic[@"result"];
            for (NSDictionary *dic in dataSourceArr) {
                FaPiaoModel *model = [[FaPiaoModel alloc] initWithDictionary:dic error:nil];
                [self.dataMuArr addObject:model];
                
            }
        } else {
            NSArray *dataSourceArr = resultDic[@"result"];
            for (NSDictionary *dic in dataSourceArr) {
                BillTicketModel *model = [[BillTicketModel alloc] initWithDictionary:dic error:nil];
                [self.dataMuArr addObject:model];
            }
        }
        
        
        [self.tabView reloadData];
        
    } failure:^(NSString *error, NSInteger code) {
        [self.tabView reloadData];
    }];
 
}

//删除发票信息
- (void)removeBillTicket:(NSInteger)fapiaoId {
    
    [[UtilsData sharedInstance] showAlertControllerWithTitle:@"提示" detail:@"是否确定删除" doneTitle:@"是" cancelTitle:@"否" haveCancel:YES doneAction:^{
        
        BillTicketModel *model = [self.dataMuArr objectAtIndex:fapiaoId];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:model.id forKey:@"fapiaoId"];
        [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_DeleteFapiao andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
            [self.dataMuArr removeObjectAtIndex:fapiaoId];
            [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:msg time:0 aboutType:WHShowViewMode_Text state:YES];
            [self.tabView reloadData];
        } failure:^(NSString *error, NSInteger code) {
            
        }];
        
        
    } controller:self];
    
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
