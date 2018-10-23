//
//  WholeBoardDetailVC.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/10/23.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "WholeBoardDetailVC.h"

@interface WholeBoardDetailVC ()

@property (weak, nonatomic) IBOutlet HYStepper *stepper;
@property (weak, nonatomic) IBOutlet UILabel *guigeLabel;
@property (weak, nonatomic) IBOutlet UILabel *paihaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhuangtaiLabel;
@property (weak, nonatomic) IBOutlet UILabel *biaozhunLabel;
@property (weak, nonatomic) IBOutlet UILabel *biaomianLabel;
@property (weak, nonatomic) IBOutlet UILabel *fumoLabel;
@property (weak, nonatomic) IBOutlet UILabel *changjiaLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhongliangLabel;
@property (weak, nonatomic) IBOutlet UILabel *shengyuLabel;
@property (weak, nonatomic) IBOutlet UILabel *danjianLabel;
@property (weak, nonatomic) IBOutlet UILabel *gongjinLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIButton *shopBtn;

@end

@implementation WholeBoardDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.stepper.value = 5;
    self.shopBtn.badgeValue = @"1";
}

- (IBAction)close:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)shopCar:(UIButton *)sender {
    
}

- (IBAction)excute:(UIButton *)sender {
    
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
