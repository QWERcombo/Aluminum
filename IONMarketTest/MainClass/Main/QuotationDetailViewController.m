//
//  QuotationDetailViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/15.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "QuotationDetailViewController.h"
#import "BezierCurveView.h"

@interface QuotationDetailViewController ()
@property (strong,nonatomic)BezierCurveView *bezierView;
@property (strong,nonatomic)NSMutableArray *x_names;
@property (strong,nonatomic)NSMutableArray *targets;
@end

@implementation QuotationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.targets = [NSMutableArray array];
    self.x_names = [NSMutableArray array];
    [self setupSubviews];
    [self getDataSource:1];
<<<<<<< Updated upstream
    _bezierView = [BezierCurveView initWithFrame:CGRectMake(10, 20, SCREEN_WIGHT-20, 170)];
//    _bezierView.center = self.view.center;
//    [self.view addSubview:_bezierView];
=======
    
>>>>>>> Stashed changes
}

- (void)setupSubviews {
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(0);
    }];
    self.tabView.backgroundColor = [UIColor mianColor:1];
}


#pragma mark ----delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section == 1 ? self.dataMuArr.count: 0 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
<<<<<<< Updated upstream
    return [UtilsMold creatCell:@"QuotationDetailCell" table:tableView deledate:self model:[self.dataMuArr objectAtIndex:indexPath.row] data:nil andCliker:^(NSDictionary *clueDic) {
=======
    return [UtilsMold creatCell:@"MainItemCell" table:tableView deledate:self model:[self.dataMuArr objectAtIndex:indexPath.row] data:nil andCliker:^(NSDictionary *clueDic) {
>>>>>>> Stashed changes
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"MainItemCell" data:nil model:nil indexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return section == 0 ? [self createSectionView] : nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 300 : 0;
}

- (UIView *)createSectionView {
    UIView *blank = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 300)];
    _bezierView = [BezierCurveView initWithFrame:CGRectMake(15, 0, SCREEN_WIGHT, 300)];
    if (self.x_names.count) {
        [_bezierView drawLineChartViewWithX_Value_Names:self.x_names TargetValues:self.targets LineType:LineType_Curve];
    }
    [blank addSubview:_bezierView];
    return blank;
}

//画折线图
-(void)drawLineChart{
    //直线
    //    [_bezierView drawLineChartViewWithX_Value_Names:self.x_names TargetValues:self.targets LineType:LineType_Straight];
    //曲线
    [_bezierView drawLineChartViewWithX_Value_Names:self.x_names TargetValues:self.targets LineType:LineType_Curve];
}

- (void)getDataSource:(NSInteger)pageNumber {
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    //[dataDic setValue:@"2018-01-01" forKey:@"beginDate"];
    //[dataDic setValue:@"2018-05-21" forKey:@"endDate"];

    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dataDic imageArray:nil WithType:Interface_PriceList andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        
        NSArray *dataArr = resultDic[@"result"];
        
        NSInteger index = 0;
        for (NSDictionary *dict in dataArr) {
            
            PriceModel *model = [[PriceModel alloc] initWithDictionary:dict error:nil];
            
            [self.dataMuArr addObject:model];
            if (index<10) {
                [self.targets addObject:[self stringTransformToNSNumber:model.averagePrice]];
                [self.x_names addObject:[self dateTransformToString:model.riqi]];
                index++;
            }
        }
        
        //倒序
        self.x_names = (NSMutableArray *)[[self.x_names reverseObjectEnumerator] allObjects];
        self.targets = (NSMutableArray *)[[self.targets reverseObjectEnumerator] allObjects];
        [self.tabView reloadData];
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}

- (NSNumber *)stringTransformToNSNumber:(NSString *)string {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *numTemp = [numberFormatter numberFromString:string];
    
    return numTemp;
}
- (NSString *)dateTransformToString:(NSString *)dateString {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"MM/dd";
    return [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[dateString integerValue]/1000]];
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
