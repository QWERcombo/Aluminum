//
//  SettingDescribViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/14.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "SettingDescribViewController.h"

@interface SettingDescribViewController ()

@end

@implementation SettingDescribViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor mianColor:1];
    if ([self.title isEqualToString:@"关于我们"]) {
        [self createUIWithAnoutUs];
    } else {
        [self createUIWithUserDeals];
    }
}

- (void)createUIWithAnoutUs {
    
    UIImageView *logo = [UIImageView new];
    logo.image = IMG(@"");
    logo.backgroundColor = [UIColor mianColor:2];
    [self.view addSubview:logo];
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(100));
        make.center.equalTo(self.view);
    }];
    UILabel *version = [UILabel lableWithText:@"当前版本1.0.0" Font:FONT_ArialMT(17) TextColor:[UIColor mianColor:2]];
    [self.view addSubview:version];
    [version mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(17));
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(logo.mas_bottom).offset(10);
    }];
    
    UILabel *tag = [UILabel lableWithText:@"某某科技公司   版权所有" Font:FONT_ArialMT(17) TextColor:[UIColor mianColor:2]];
    [self.view addSubview:tag];
    [tag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.equalTo(@(20));
        make.bottom.equalTo(self.view.mas_bottom).offset(-10);
    }];
}

- (void)createUIWithUserDeals {
    
    
    
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
