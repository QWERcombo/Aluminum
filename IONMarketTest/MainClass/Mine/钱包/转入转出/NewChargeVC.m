//
//  NewChargeVC.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/11/27.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "NewChargeVC.h"
#import "OrderPayResultVC.h"

@interface NewChargeVC ()

@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *aliButton;
@property (weak, nonatomic) IBOutlet UIButton *weixinButton;

@property (nonatomic, strong) UIButton *selectBtn;

@end

@implementation NewChargeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"钱包充值";
    
    self.submitButton.layer.cornerRadius = 5;
    self.submitButton.layer.masksToBounds = YES;
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    for (NSInteger i=0; i<6; i++) {
        
        UIButton *showBtn = [self.view viewWithTag:200+i];
        showBtn.layer.borderColor = [UIColor mianColor:2].CGColor;
        showBtn.layer.borderWidth = 0.5;
        showBtn.layer.cornerRadius = 4;
        showBtn.layer.masksToBounds = YES;
        
    }
}

- (IBAction)aliClick:(UIButton *)sender {
    [self.aliButton setSelected:YES];
    [self.weixinButton setSelected:NO];
}

- (IBAction)weixinClick:(UIButton *)sender {
    [self.aliButton setSelected:NO];
    [self.weixinButton setSelected:YES];
}

- (IBAction)submit:(UIButton *)sender {
    
    if (!self.aliButton.selected && !self.weixinButton.selected) {
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请先选择支付方式" time:0 aboutType:WHShowViewMode_Text state:NO];
        return;
    }
    
    
    if (self.aliButton.selected && !self.weixinButton.selected) {
        //支付宝
        [[ShoppingCarSingle sharedShoppingCarSingle] beginPayUserAliPayWithOrderId:@"" andTotalfee:[_selectBtn.currentTitle substringFromIndex:1] userPayMode:aliPayMode_wallet paySuccessBlock:^{
            
            OrderPayResultVC *result = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"OrderPayResultVC"];
            [self.navigationController pushViewController:result animated:YES];
            
        }];
        
    }
    if (!self.aliButton.selected && self.weixinButton.selected) {
        //微信
        [[ShoppingCarSingle sharedShoppingCarSingle] beginPayUserWeixiWithOrderId:@"" andTotalfee:[_selectBtn.currentTitle substringFromIndex:1] userPayMode:weixinPayMode_wallet paySuccessBlock:^{
            
            OrderPayResultVC *result = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"OrderPayResultVC"];
            [self.navigationController pushViewController:result animated:YES];
            
        }];
        
    }
    
}


- (IBAction)buttonClick:(UIButton *)sender {
    
    if (_selectBtn != sender) {
        _selectBtn.selected = NO;
        _selectBtn.backgroundColor = [UIColor whiteColor];
        _selectBtn = sender;
    }
    sender.selected = YES;
    sender.backgroundColor = [UIColor mianColor:2];
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
