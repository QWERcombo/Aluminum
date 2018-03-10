//
//  OrderListViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/10.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "OrderListViewController.h"

@interface OrderListViewController ()

@end

@implementation OrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.nameTitle;
    if ([self.nameTitle isEqualToString:@"全部"]||[self.nameTitle isEqualToString:@"待收货"]) {
        self.view.backgroundColor = [UIColor purpleColor];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
    }
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
