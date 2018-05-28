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
    _bezierView = [BezierCurveView initWithFrame:CGRectMake(10, 20, SCREEN_WIGHT-20, 170)];
//    _bezierView.center = self.view.center;
//    [self.view addSubview:_bezierView];
}

- (void)setupSubviews {
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(200);
    }];
    self.tabView.backgroundColor = [UIColor mianColor:1];
}


#pragma mark ----delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataMuArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold creatCell:@"QuotationDetailCell" table:tableView deledate:self model:[self.dataMuArr objectAtIndex:indexPath.row] data:nil andCliker:^(NSDictionary *clueDic) {
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"QuotationDetailCell" data:nil model:nil indexPath:indexPath];
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return section==0?[self createSectionView]:nil;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return section==0?190:0;
//}

- (UIView *)createSectionView {
    UIView *imageview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 190)];
//    imageview.backgroundColor = [UIColor mianColor:2];
//
//    UIImageView *imagev = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 180)];
//    imagev.backgroundColor = [UIColor whiteColor];
//    imagev.image = IMG(@"");

    return imageview;
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
    //    [dataDic setValue:@"2018-01-01" forKey:@"beginDate"];
    //    [dataDic setValue:@"2018-05-21" forKey:@"endDate"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dataDic imageArray:nil WithType:Interface_PriceList andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        
        NSArray *dataArr = resultDic[@"result"];
        
        for (NSDictionary *dict in dataArr) {
            
            PriceModel *model = [[PriceModel alloc] initWithDictionary:dict error:nil];
            
            [self.dataMuArr addObject:model];
            [self.targets addObject:[self stringTransformToNSNumber:model.priceChange]];
            [self.x_names addObject:[self dateTransformToString:model.riqi]];
        }
        
        [self drawLineChart];
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
    formatter.dateFormat = @"MM-dd";
    
    return [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[dateString integerValue]/1000]];
}

////---------------------------------------------------------------
///**
// *  X轴值
// */
//-(NSMutableArray *)x_names{
//    if (!_x_names) {
//        _x_names = [NSMutableArray arrayWithArray:@[@"语文",@"数学",@"英语",@"物理",@"化学",@"生物",@"政治",@"历史",@"地理"]];
//    }
//    return _x_names;
//}
///**
// *  Y轴值
// */
//-(NSMutableArray *)targets{
//    if (!_targets) {
//        _targets = [NSMutableArray arrayWithArray:@[@20,@40,@20,@50,@30,@90,@30,@100,@70]];
//    }
//    return _targets;
//}

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
