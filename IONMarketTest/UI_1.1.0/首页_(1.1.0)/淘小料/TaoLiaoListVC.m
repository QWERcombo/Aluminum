//
//  TaoLiaoListVC.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2019/2/22.
//  Copyright © 2019年 赵越. All rights reserved.
//

#import "TaoLiaoListVC.h"
#import "TaoLiaoDetailVC.h"
#import "TaoLiaoListCell.h"

@interface TaoLiaoListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *listArray;

@end

@implementation TaoLiaoListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"淘小料";
    self.listArray = [NSMutableArray array];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.hidden = YES;
    UIImageView *imgv = [[UIImageView alloc] init];
    imgv.image = IMG(@"taoliao_0");
    [self.view addSubview:imgv];
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    
    [self getListDataSource];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [TaoLiaoListCell initCell:tableView cellName:@"TaoLiaoListCell" dataObject:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 104;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TaoLiaoDetailVC *detail = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"TaoLiaoDetailVC"];
    [self.navigationController pushViewController:detail animated:YES];
}



- (void)getListDataSource {
    
    
    
    
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
