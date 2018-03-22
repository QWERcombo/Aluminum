//
//  LoginViewController.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/22.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}


//登陆
- (IBAction)loginAction:(UIButton *)sender {
    [[UtilsData sharedInstance] postLoginNotice];
    
    
    
}

//忘记密码
- (IBAction)forgetAction:(UIButton *)sender {
    NSLog(@"%@", sender.currentTitle);
}

//注册
- (IBAction)registerAction:(UIButton *)sender {
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
