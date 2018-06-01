//
//  OrderPayResultVC.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/6/1.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "OrderPayResultVC.h"

@interface OrderPayResultVC ()
@property (weak, nonatomic) IBOutlet UIImageView *status_imgv;
@property (weak, nonatomic) IBOutlet UILabel *status_label;

@end

@implementation OrderPayResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)doneClicker:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
