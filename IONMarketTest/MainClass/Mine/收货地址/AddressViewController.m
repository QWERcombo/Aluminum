//
//  AddressViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/14.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "AddressViewController.h"

@interface AddressViewController ()

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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


- (void)applyCliker:(UIButton *)sender {
    
    
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
