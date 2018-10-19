//
//  InviteNumberVC.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/10/18.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "InviteNumberVC.h"

@interface InviteNumberVC ()
@property (weak, nonatomic) IBOutlet UITextField *inviteTF;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation InviteNumberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    self.submitBtn.layer.cornerRadius = 4;
    self.submitBtn.layer.masksToBounds = YES;
    [self.inviteTF setValue:[UIFont systemFontOfSize:20 weight:UIFontWeightBold] forKeyPath:@"_placeholderLabel.font"];
    [self.inviteTF setValue:[UIColor colorWithHexString:@"#CED4DA"] forKeyPath:@"_placeholderLabel.textColor"];
}

#pragma mark - Table view data source

- (IBAction)submit:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (IBAction)close:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
