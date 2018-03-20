//
//  TradeListViewController.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/20.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "TradeListViewController.h"

@interface TradeListViewController ()

@end

@implementation TradeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"交易明细";
    [self setupSubviews];
}

- (void)setupSubviews {
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    
//    __weak typeof(self) weakself = self;
    self.tabView.ly_emptyView = [[PublicFuntionTool sharedInstance] getEmptyViewWithType:WHShowEmptyMode_noData withHintText:@"暂无交易明细" andDetailStr:@"" withReloadAction:^{
        
    }];
    
    UIButton *chooseButton = [UIButton buttonWithTitle:@"筛选" andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    [chooseButton addTarget:self action:@selector(chooseCliker:) forControlEvents:UIControlEventTouchUpInside];
    chooseButton.frame = CGRectMake(0, 0, 45, 15);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:chooseButton];
}


#pragma mark ----- UITableViewDelegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold creatCell:@"WallentListCell" table:tableView deledate:self model:nil data:nil andCliker:^(NSDictionary *clueDic) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"WallentListCell" data:nil model:nil indexPath:indexPath];
}


#pragma mark ----- Action
- (void)chooseCliker:(UIButton *)sneder {
    NSLog(@"%@", sneder.currentTitle);
    
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
