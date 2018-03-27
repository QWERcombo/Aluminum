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

@interface TicketViewController ()<RadioSelectDelegate>

#define Button_Width  100
#define Button_Margin  ((SCREEN_WIGHT-100*3)/4)

@property (nonatomic, assign) NSInteger lastSelected;

@property (nonatomic, strong) NSString *cellType;

@property (nonatomic, strong) NSIndexPath *lastIndexPath;// 选中的index

@property (nonatomic, strong) TicketModel *selectedModel;

@end

@implementation TicketViewController {
    UIButton *applyButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.cellType = @"0";
    
    [self getDataSource:@"0"];
    [self setupSubviews];
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
    NSString *cellName = @"";
    if ([self.cellType isEqualToString:@"0"]) {
        cellName = @"TicketCell";
    } else if ([self.cellType isEqualToString:@"1"]) {
        cellName = @"EndTicketCell";
    } else {
        
        TicketInfoCell *cell = (TicketInfoCell *)[UtilsMold creatCell:@"TicketInfoCell" table:tableView deledate:self model:self.dataMuArr.count?[self.dataMuArr objectAtIndex:indexPath.row]:nil data:nil andCliker:^(NSDictionary *clueDic) {
            NSLog(@"+++%@", clueDic);
        }];
        
        cell.tableView = self.tabView;
        cell.delegate = self;
        return cell;
    }
    return [UtilsMold creatCell:cellName table:tableView deledate:self model:nil data:nil andCliker:^(NSDictionary *clueDic) {
        NSLog(@"+++%@", clueDic);
        
    }];
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




#pragma mark ----- Action

- (void)buttonCliker:(UIButton *)sender {
    NSLog(@"%@", sender.currentTitle);
    
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
    
    [self getDataSource:SINT(sender.tag-100)];
}

- (void)applyCliker:(UIButton *)sender {
    if (self.lastSelected==102) {
        ApplyTicketViewController *apply = [[ApplyTicketViewController alloc] initWithNibName:@"ApplyTicketViewController" bundle:nil];
        [self.navigationController pushViewController:apply animated:YES];
    } else {
        AddNewTicketViewController *addnew = [[AddNewTicketViewController alloc] initWithNibName:@"AddNewTicketViewController" bundle:nil];
        [self.navigationController pushViewController:addnew animated:YES];
    }
}

#pragma mark - RadioSelectDelegate
- (void)radioSelectedWithIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *tempIndexPath = self.lastIndexPath;
    // 改变上一次的
    if (tempIndexPath && tempIndexPath != indexPath) {
        BaseModel *model = self.dataMuArr[tempIndexPath.row];
        model.isSelectedCard = NO;
        [self.tabView reloadRowsAtIndexPaths:@[tempIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
    // 记住这一次的
    TicketModel *model = self.dataMuArr[indexPath.row];
    model.isSelectedCard = YES;
    [self.tabView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    self.lastIndexPath = indexPath;
    //接下来可以保存你选中的做需要做的事情。
    
    self.selectedModel = model;
    
}


#pragma mark ----- DataSource

- (void)getDataSource:(NSString *)status {
    
    [self.dataMuArr removeAllObjects];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:status forKey:@"fapiaoStatus"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_CateList andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"+++%@", resultDic);
        
        NSArray *dataSourceArr = resultDic[@"list"];
        
        for (NSDictionary *dic in dataSourceArr) {
            
            TicketModel *model = [[TicketModel alloc] initWithDictionary:dic error:nil];
            
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
