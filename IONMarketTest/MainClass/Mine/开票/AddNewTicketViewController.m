//
//  AddNewTicketViewController.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/21.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "AddNewTicketViewController.h"
#import "AddressViewController.h"

@interface AddNewTicketViewController ()

@end

@implementation AddNewTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"申请发票";
    [self setupSubviews];
}

- (void)setupSubviews {
    [self.view addSubview:self.tabView];
    self.tabView.scrollEnabled = NO;
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(100);
        make.bottom.equalTo(self.view.mas_bottom).offset(-80);
        make.left.right.equalTo(self.view);
    }];
    
}


#pragma mark ----- UITableViewDelegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold creatCell:@"EndTicketCell" table:tableView deledate:self model:nil data:nil andCliker:^(NSDictionary *clueDic) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"EndTicketCell" data:nil model:nil indexPath:indexPath];
}




- (IBAction)addAc:(UIButton *)sender {
    AddressViewController *address = [AddressViewController new];
    [self.navigationController pushViewController:address animated:YES];
}

- (IBAction)doneAc:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
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
