//
//  QuotationDetailViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/15.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "QuotationDetailViewController.h"

@interface QuotationDetailViewController ()

@end

@implementation QuotationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubviews];
    self.title = @"佛山A00";
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
    return section==0?0:10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold creatCell:@"QuotationDetailCell" table:tableView deledate:self model:nil data:nil andCliker:^(NSDictionary *clueDic) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"QuotationDetailCell" data:nil model:nil indexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return section==0?[self createSectionView]:nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section==0?190:0;
}

- (UIView *)createSectionView {
    UIView *imageview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 190)];
    imageview.backgroundColor = [UIColor mianColor:2];
    
    UIImageView *imagev = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 180)];
    imagev.backgroundColor = [UIColor whiteColor];
    imagev.image = IMG(@"");
    
    return imageview;
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
