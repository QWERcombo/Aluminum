//
//  AddressViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/14.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "AddressViewController.h"
#import "AddAddressViewController.h"

@interface AddressViewController ()

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    for (NSInteger i = 0 ; i<10; i++) {
        [self.dataMuArr addObject:@"1"];
    }
    
    [self setupSubviews];
}

- (void)setupSubviews {
    [self.view addSubview:self.tabView];
    self.tabView.backgroundColor = [UIColor mianColor:1];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
    }];
    
    UIButton *applyButton = [UIButton buttonWithTitle:@"新增收货地址" andFont:FONT_ArialMT(18) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    [self.view addSubview:applyButton];
    applyButton.backgroundColor = [UIColor mianColor:2];
    [applyButton addTarget:self action:@selector(applyCliker:) forControlEvents:UIControlEventTouchUpInside];
    [applyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(50));
        make.left.right.bottom.equalTo(self.view);
    }];
    
    self.tabView.ly_emptyView = [[PublicFuntionTool sharedInstance] getEmptyViewWithType:WHShowEmptyMode_noData withHintText:@"暂无收货地址" andDetailStr:@"您可以新增收货地址以便收货" withReloadAction:^{
        
    }];
    
}

#pragma mark ----- UITableViewDelegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataMuArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak typeof(self) weakself = self;
    
    return [UtilsMold creatCell:@"AddressCell" table:tableView deledate:self model:nil data:nil andCliker:^(NSDictionary *clueDic) {
        
        NSString *key = clueDic[@"key"];
        if ([key isEqualToString:@"0"]) {
            
            AddAddressViewController *add = [[AddAddressViewController alloc] initWithNibName:@"AddAddressViewController" bundle:nil];
            add.mode = Mode_Editor;
            [weakself.navigationController pushViewController:add animated:YES];
            
            
        } else if ([key isEqualToString:@"1"]) {
            
            [weakself.dataMuArr removeObjectAtIndex:indexPath.row];
            [weakself.tabView reloadData];
            
        } else {
            
        }
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"AddressCell" data:nil model:nil indexPath:indexPath];
}



- (void)applyCliker:(UIButton *)sender {
    AddAddressViewController *add = [[AddAddressViewController alloc] initWithNibName:@"AddAddressViewController" bundle:nil];
    add.mode = Mode_Set;
    [self.navigationController pushViewController:add animated:YES];
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
