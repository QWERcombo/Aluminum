//
//  SubMarketVC.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/10/27.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "SubMarketVC.h"
#import "AAChartKit.h"
#import "SubMarktListCell.h"

@interface SubMarketVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) AAChartModel *aaChartModel;
@property (nonatomic, strong) AAChartView  *aaChartView;
@property (nonatomic, assign) NSInteger cur_page;
@property (nonatomic, strong) NSArray *chartArray;

@end

@implementation SubMarketVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    self.cur_page = 1;
    self.dataSource = [NSMutableArray array];
    self.chartArray = [NSArray array];

    [[UtilsData sharedInstance] MJRefreshAutoNormalFooterTarget:self table:self.tableView actionSelector:@selector(loadFooterMore)];
    [[UtilsData sharedInstance] MJRefreshNormalHeaderTarget:self table:self.tableView actionSelector:@selector(loadHeader)];
    
    [self getDataSource:1];
    
}
- (void)createTableViewHeaderView {
    
    self.aaChartView = [[AAChartView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 200)];
    self.aaChartView.scrollEnabled = NO;
    self.aaChartView.contentHeight = self.aaChartView.frame.size.height;
    
    self.aaChartModel = [self configureTheChartModel:AAChartTypeArea];
    [self.aaChartView aa_drawChartWithChartModel:_aaChartModel];
    
    self.tableView.tableHeaderView = self.aaChartView;
}
- (AAChartModel *)configureTheChartModel:(NSString *)chartType  {
    
    NSDictionary *gradientColorDic =
    @{
      @"linearGradient": @{
              @"x1": @0,
              @"y1": @1,
              @"x2": @0,
              @"y2": @0
              },
      @"stops": @[@[@0,@"rgba(0,100,255,0)"],
                  @[@1,@"rgba(0,100,255,0.4)"]]//颜色字符串设置支持十六进制类型和 rgba 类型
      };
    
    //单位
    NSString *unitString = [NSString stringWithFormat:@"单位 (%@)",((PriceModel *)[self.chartArray firstObject]).unit];
    //X轴
    NSMutableArray *dateArr = [NSMutableArray array];
    //Y轴
    NSMutableArray *dataArr = [NSMutableArray array];
    
    for (PriceModel *dataObject in self.chartArray) {
        
        NSString *riqi = [[NSDate dateWithTimeIntervalSince1970:[dataObject.riqi integerValue]/1000] formattedDateWithFormat:@"M月dd日"];
        NSNumber *number = [[NSNumber alloc] initWithInteger:[[dataObject.averagePrice substringFromIndex:1] integerValue]];
        
        [dateArr addObject:riqi];
        [dataArr addObject:number];
    }
    
    AAChartModel *aaChartModel = AAChartModel.new
    .chartTypeSet(AAChartTypeArea)
    .titleSet(@"")
    .markerRadiusSet(@0)//设置折线连接点宽度为0,即是隐藏连接点
    .subtitleSet(unitString)
    .subtitleFontSizeSet(@12)
    .subtitleFontColorSet(@"#595E64")
    .xAxisLabelsEnabledSet(true)
    .xAxisLabelsFontSizeSet(@10)
    .xAxisLabelsFontColorSet(@"#8D959D")
    .xAxisGridLineWidthSet(@.5)
    .yAxisTitleSet(@"")
    .xAxisCrosshairDashStyleTypeSet(AALineDashSyleTypeDot)
    .legendEnabledSet(NO)
    .categoriesSet(dateArr)
    .yAxisGridLineWidthSet(@.5)
    .seriesSet(@[AASeriesElement.new
                 .nameSet(self.title)
//                 .colorSet((id)gradientColorDic)
                 .dataSet(dataArr)
                 .lineWidthSet(@3)
                 .fillColorSet((id)gradientColorDic)]);
    
    return aaChartModel;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SubMarktListCell *cell = [SubMarktListCell initCell:tableView cellName:@"SubMarktListCell" dataObject:[self.dataSource objectAtIndex:indexPath.row]];
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section==0?self.dataSource.count:0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section==0?47:0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *blank = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 47)];
    blank.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 15, SCREEN_WIGHT, 32)];
    subView.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
    
    NSArray *titleArr = @[@"日期",@"价格区间",@"均价",@"涨跌"];
    
    for (NSInteger i=0; i<titleArr.count; i++) {
        
        UILabel *label = [UILabel lableWithText:[titleArr objectAtIndex:i] Font:[UIFont fontWithSize:14] TextColor:[UIColor Grey_WordColor]];
        label.textAlignment = NSTextAlignmentCenter;
        switch (i) {
            case 0:
                label.frame = CGRectMake(0, 0, (SCREEN_WIGHT*2/12.0), 32);
                break;
            case 1:
                label.frame = CGRectMake((SCREEN_WIGHT*2/12.0), 0, (SCREEN_WIGHT*4/12.0), 32);
                break;
            case 2:
                label.frame = CGRectMake((SCREEN_WIGHT*6/12.0), 0, (SCREEN_WIGHT*3/12.0), 32);
                break;
            case 3:
                label.frame = CGRectMake((SCREEN_WIGHT*9/12.0), 0, (SCREEN_WIGHT*3/12.0), 32);
                break;
            default:
                break;
        }
        
        [subView addSubview:label];
    }
    
    
    [blank addSubview:subView];
    
    
    return section==0?blank:nil;
}


- (void)loadHeader {
    [self getDataSource:1];
}

- (void)loadFooterMore {
    [self getDataSource:self.cur_page+1];
}

- (void)getDataSource:(NSInteger)pageNumber {
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setValue:[NSString stringWithFormat:@"%ld", pageNumber] forKey:@"pageNum"];
    [dataDic setValue:@"15" forKey:@"pageSize"];
    [dataDic setValue:@"2018-01-01" forKey:@"beginDate"];
    [dataDic setValue:[[NSDate date] formattedDateWithFormat:@"yyyy-MM-dd"] forKey:@"endDate"];
    [dataDic setValue:self.title forKey:@"source"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dataDic imageArray:nil WithType:Interface_PricePageList andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        
        NSArray *dataArr = resultDic[@"result"];
        
        if (pageNumber == 1) {
            [self.dataSource removeAllObjects];
            [self.tableView.mj_header endRefreshing];
            self.cur_page = 1;
        } else {
            if (dataArr.count) {
                [self.tableView.mj_footer endRefreshing];
            } else {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            self.cur_page++;
        }
        
        for (NSDictionary *dict in dataArr) {
            
            PriceModel *model = [[PriceModel alloc] initWithDictionary:dict error:nil];
            
            [self.dataSource addObject:model];
        }
        if (pageNumber == 1) {
            //构建折线图
            self.chartArray = [[[self.dataSource subarrayWithRange:NSMakeRange(0, 5)] reverseObjectEnumerator] allObjects];
            [self createTableViewHeaderView];
        }
        
        [self.tableView reloadData];
    } failure:^(NSString *error, NSInteger code) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
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
