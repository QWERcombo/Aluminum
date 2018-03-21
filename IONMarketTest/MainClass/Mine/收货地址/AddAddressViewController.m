//
//  AddAddressViewController.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/21.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "AddAddressViewController.h"

@interface AddAddressViewController ()

@property (weak, nonatomic) IBOutlet UITextField *holderTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UITextView *addressTextView;
@property (weak, nonatomic) IBOutlet UISwitch *setDefaultSwitch;
@property (weak, nonatomic) IBOutlet UIView *deleteView;


@end

@implementation AddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (self.mode == Mode_Set) {
        self.title = @"新增地址";
        self.deleteView.hidden = YES;
    } else {
        self.title = @"修改地址";
        self.deleteView.hidden = NO;
    }
    
    
}


- (IBAction)chooseCity:(id)sender {
    NSLog(@"city");
    
}

- (IBAction)deleteAc:(id)sender {
    
    __weak typeof(self) weakself = self;
    
    [[UtilsData sharedInstance] showAlertControllerWithTitle:@"提示" detail:@"是否确定删除此收货地址" doneTitle:@"是" cancelTitle:@"否" haveCancel:YES doneAction:^{
        
        [weakself.navigationController popViewControllerAnimated:YES];
        
    } controller:weakself];
}
- (IBAction)setDefaultAc:(id)sender {
    NSLog(@"%d", ((UISwitch *)sender).on);
    
    
}


- (IBAction)saveAc:(id)sender {
    [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"保存成功" time:0.0 aboutType:WHShowViewMode_Text state:YES];
    [self.navigationController popViewControllerAnimated:YES];
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
