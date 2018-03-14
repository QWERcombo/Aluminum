//
//  ChangeCodeViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/14.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "ChangeCodeViewController.h"

@interface ChangeCodeViewController ()

@end

@implementation ChangeCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = @"";
    self.view.backgroundColor = [UIColor mianColor:1];
}

- (IBAction)changeCode:(id)sender {
    
    [[UtilsData sharedInstance] showAlertControllerWithTitle:@"提示" detail:@"是否确定修改密码" doneTitle:@"确定" cancelTitle:@"取消" haveCancel:YES doneAction:^{
        
    } controller:self];
    
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
