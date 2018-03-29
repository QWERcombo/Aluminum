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
        
//        self.setDefaultSwitch.on = YES;
        
    } else {
        self.title = @"修改地址";
        self.deleteView.hidden = NO;
        
        self.holderTF.placeholder = self.addressModel.name;
        self.phoneTF.placeholder = self.addressModel.phone;
        self.addressTextView.text = self.addressModel.address;
        self.setDefaultSwitch.on = [self.addressModel.moren intValue];
    }
    
    
}


- (IBAction)chooseCity:(id)sender {
    NSLog(@"city");
    
}

- (IBAction)deleteAc:(id)sender {
    
    __weak typeof(self) weakself = self;
    
    [[UtilsData sharedInstance] showAlertControllerWithTitle:@"提示" detail:@"是否确定删除此收货地址" doneTitle:@"是" cancelTitle:@"否" haveCancel:YES doneAction:^{
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:self.addressModel.id forKey:@"id"];
        [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_DeleteAddress andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
            NSLog(@"%@", resultDic);
            [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:msg time:0.0 aboutType:WHShowViewMode_Text state:YES];
            [weakself.navigationController popViewControllerAnimated:YES];
            
        } failure:^(NSString *error, NSInteger code) {
            
        }];
        [weakself.navigationController popViewControllerAnimated:YES];
        
    } controller:weakself];
}
- (IBAction)setDefaultAc:(id)sender {
//    NSLog(@"%d", ((UISwitch *)sender).on);
    self.setDefaultSwitch.on = ((UISwitch *)sender).on;
    
}
- (IBAction)endEditor:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}


- (IBAction)saveAc:(id)sender {
//    [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"保存成功" time:0.0 aboutType:WHShowViewMode_Text state:YES];
//    [self.navigationController popViewControllerAnimated:YES];
    NSString *url = @"";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (self.addressModel) {
        [dict setValue:self.addressModel.id forKey:@"addressId"];
        [dict setValue:self.phoneTF.text.length?self.phoneTF.text:self.addressModel.phone forKey:@"phone"];
        [dict setValue:self.holderTF.text.length?self.holderTF.text:self.addressModel.name forKey:@"name"];
        [dict setValue:self.addressTextView.text forKey:@"address"];
        [dict setValue:SINT(self.setDefaultSwitch.on) forKey:@"moren"];
        url = Interface_UpdateAddress;
    } else {
        [dict setValue:[UserData currentUser].id forKey:@"userId"];
        [dict setValue:self.phoneTF.text forKey:@"phone"];
        [dict setValue:self.holderTF.text forKey:@"name"];
        [dict setValue:self.addressTextView.text forKey:@"address"];
        [dict setValue:SINT(self.setDefaultSwitch.on) forKey:@"moren"];
        url = Interface_SaveAddress;
    }
    
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:url andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"%@", resultDic);
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:msg time:0.0 aboutType:WHShowViewMode_Text state:YES];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
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
