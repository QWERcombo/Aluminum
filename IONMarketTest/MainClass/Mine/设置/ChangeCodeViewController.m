//
//  ChangeCodeViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/14.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "ChangeCodeViewController.h"

@interface ChangeCodeViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *oldTF;
@property (weak, nonatomic) IBOutlet UITextField *theNewTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmTF;

@property (nonatomic, strong) NSMutableString *oldCode;
@property (nonatomic, strong) NSMutableString *theNewCode;
@property (nonatomic, strong) NSMutableString *confirmCode;

@end

@implementation ChangeCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor mianColor:1];
    self.oldCode = [NSMutableString string];
    self.confirmCode = [NSMutableString string];
    self.theNewCode = [NSMutableString string];
}



#pragma mark --- tfdelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField==self.oldTF) {
        [self.oldCode replaceCharactersInRange:range withString:string];
    }
    
    if (textField==self.theNewTF) {
        [self.theNewCode replaceCharactersInRange:range withString:string];
    }
    
    if (textField==self.confirmTF) {
        [self.confirmCode replaceCharactersInRange:range withString:string];
    }
    
    return YES;
}



- (IBAction)changeCode:(id)sender {
    
    [self checkInputInfomation];
    
    __weak typeof(self) weakself = self;
    
    [[UtilsData sharedInstance] showAlertControllerWithTitle:@"提示" detail:@"是否确定修改密码" doneTitle:@"确定" cancelTitle:@"取消" haveCancel:YES doneAction:^{
        
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"修改成功!" time:2 aboutType:WHShowViewMode_Text state:YES];
        
        [weakself.navigationController popViewControllerAnimated:YES];
        
    } controller:self];
    
}

- (void)checkInputInfomation {
    NSLog(@"%@", self.oldCode);
    NSLog(@"%@", self.theNewCode);
    NSLog(@"%@", self.confirmCode);
    
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
