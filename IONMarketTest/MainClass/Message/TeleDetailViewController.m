//
//  TeleDetailViewController.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/22.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "TeleDetailViewController.h"

@interface TeleDetailViewController ()

@end

@implementation TeleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)setupSubViews {
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
    
    [self createBottomView];
}

- (void)createBottomView {
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(50));
    }];
    
    
    UIButton *output = [UIButton buttonWithTitle:@"拨打热线" andFont:FONT_ArialMT(18) andtitleNormaColor:[UIColor mianColor:2] andHighlightedTitle:[UIColor mianColor:2] andNormaImage:nil andHighlightedImage:nil];
    [output addTarget:self action:@selector(outputCliker:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:output];
    [output mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(bottomView);
        make.width.equalTo(@(SCREEN_WIGHT/2));
    }];
    
    UIButton *input = [UIButton buttonWithTitle:@"客服回电话" andFont:FONT_ArialMT(18) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    input.backgroundColor = [UIColor mianColor:2];
    [input addTarget:self action:@selector(inputCliker:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:input];
    [input mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(bottomView);
        make.width.equalTo(@(SCREEN_WIGHT/2));
    }];
    
    
}

#pragma mark ----- UITableViewDelegate & DataSource
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 3;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return [UtilsMold creatCell:@"OrderListCell" table:tableView deledate:self model:nil data:nil andCliker:^(NSDictionary *clueDic) {
//
//    }];
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return [UtilsMold getCellHight:@"OrderListCell" data:nil model:nil indexPath:indexPath];
//}



#pragma mark ----- Action
- (void)inputCliker:(UIButton *)sender {
    NSLog(@"%@", sender.currentTitle);
    
}
- (void)outputCliker:(UIButton *)sender {
    NSLog(@"%@", sender.currentTitle);
    
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
