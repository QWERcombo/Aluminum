//
//  WhiteBarViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/14.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "WhiteBarViewController.h"
#import "ApplyWhiteBarVC.h"

@interface WhiteBarViewController ()

@end

@implementation WhiteBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubviews];
    [self getDataSource];
}

- (void)setupSubviews {
    [self.view addSubview:self.tabView];
    self.tabView.backgroundColor = [UIColor mianColor:1];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
    }];

    UIButton *applyButton = [UIButton buttonWithTitle:@"申请开通白条" andFont:FONT_ArialMT(18) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    [self.view addSubview:applyButton];
    applyButton.backgroundColor = [UIColor mianColor:2];
    [applyButton addTarget:self action:@selector(applyCliker:) forControlEvents:UIControlEventTouchUpInside];
    [applyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(50));
        make.left.right.bottom.equalTo(self.view);
    }];
    
    self.tabView.ly_emptyView = [[PublicFuntionTool sharedInstance] getEmptyViewWithType:WHShowEmptyMode_noData withHintText:@"还未开通白条" andDetailStr:@"" withReloadAction:^{
        
    }];
    
}


- (void)applyCliker:(UIButton *)sender {
    ApplyWhiteBarVC *apply = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"ApplyWhiteBarVC"];
    [self.navigationController pushViewController:apply animated:YES];
}


- (void)getDataSource {
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setValue:[UserData currentUser].id forKey:@"userId"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dataDic imageArray:nil WithType:Interface_GetBaitiaoById andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
       
    } failure:^(NSString *error, NSInteger code) {
        
    }];
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
