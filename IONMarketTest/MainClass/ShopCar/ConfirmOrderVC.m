//
//  ConfirmOrderVC.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/5/16.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "ConfirmOrderVC.h"

@interface ConfirmOrderVC ()
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *amountLab;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UILabel *chicunLab;
@property (weak, nonatomic) IBOutlet UILabel *zhongleiLab;
@property (weak, nonatomic) IBOutlet UILabel *shuliangLab;
@property (weak, nonatomic) IBOutlet UILabel *jiageLab;



@end

@implementation ConfirmOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)confirmClicker:(UIButton *)sender {
    
    
}

- (IBAction)addAddress:(UIButton *)sender {
    
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
