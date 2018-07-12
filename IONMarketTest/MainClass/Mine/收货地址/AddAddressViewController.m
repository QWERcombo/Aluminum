//
//  AddAddressViewController.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/21.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "AddAddressViewController.h"
#import "GFAddressPicker.h"

@interface AddAddressViewController ()<GFAddressPickerDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *holderTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;
@property (weak, nonatomic) IBOutlet UITextView *addressTextView;
@property (weak, nonatomic) IBOutlet UISwitch *setDefaultSwitch;
@property (weak, nonatomic) IBOutlet UIView *deleteView;
@property (weak, nonatomic) IBOutlet UILabel *hintLab;

@property (nonatomic, strong) GFAddressPicker *pickerView;
@property (nonatomic, strong) NSString *cityString;

@end

@implementation AddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.addressTextView.delegate = self;    
    
    if (self.mode == Mode_Set) {
        self.title = @"新增地址";
        self.deleteView.hidden = YES;
        
    } else {
        self.title = @"修改地址";
        self.deleteView.hidden = NO;
        
        [self.addressBtn setTitle:[NSString stringWithFormat:@"%@ %@ %@",self.addressModel.sheng, self.addressModel.shi, self.addressModel.qu] forState:UIControlStateNormal];
        self.holderTF.placeholder = self.addressModel.name;
        self.phoneTF.placeholder = self.addressModel.phone;
        self.addressTextView.text = self.addressModel.detailAddress;
        self.setDefaultSwitch.on = [self.addressModel.moren intValue];
        self.cityString = [NSString stringWithFormat:@"%@-%@-%@", self.addressModel.sheng, self.addressModel.shi, self.addressModel.qu];
    }
    
    CGFloat width = SCREEN_WIGHT-110-20;
    CGFloat off_left = width-self.addressBtn.imageView.width;
    self.addressBtn.imageEdgeInsets = UIEdgeInsetsMake(0, off_left, 0, -off_left);
    self.addressBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -self.addressBtn.imageView.width, 0, self.addressBtn.imageView.width);
}


- (IBAction)chooseCity:(id)sender {
//    NSLog(@"city");
    self.pickerView = [[GFAddressPicker alloc] initWithFrame:self.view.bounds];
    if (self.addressModel) {
        [self.pickerView updateAddressAtProvince:self.addressModel.sheng city:self.addressModel.shi town:self.addressModel.qu];
    } else {
        [self.pickerView updateAddressAtProvince:@"北京市" city:@"北京市" town:@"东城区"];
    }
    self.pickerView.delegate = self;
    self.pickerView.font = FONT_ArialMT(16);
    [self.view addSubview:self.pickerView];
}

- (void)GFAddressPickerCancleAction {
    [self.pickerView removeFromSuperview];
}

- (void)GFAddressPickerWithProvince:(NSString *)province
                               city:(NSString *)city area:(NSString *)area {
    [self.pickerView removeFromSuperview];
    [self.addressBtn setTitle:[NSString stringWithFormat:@"%@ %@ %@",province, city, area] forState:UIControlStateNormal];
    self.cityString = [NSString stringWithFormat:@"%@-%@-%@", province,city,area];
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
    NSString *url = @"";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    NSArray *cityArray = [self.cityString componentsSeparatedByString:@"-"];
    
    
    
    
    if (self.addressModel) {
        [dict setValue:self.addressModel.id forKey:@"addressId"];
        [dict setValue:self.phoneTF.text.length?self.phoneTF.text:self.addressModel.phone forKey:@"phone"];
        [dict setValue:self.holderTF.text.length?self.holderTF.text:self.addressModel.name forKey:@"name"];
        [dict setValue:self.addressTextView.text forKey:@"detailAddress"];
        [dict setValue:cityArray[0] forKey:@"sheng"];
        [dict setValue:cityArray[1] forKey:@"shi"];
        [dict setValue:cityArray[2] forKey:@"qu"];
        [dict setValue:SINT(self.setDefaultSwitch.on) forKey:@"moren"];
        url = Interface_UpdateAddress;
    } else {
        
        [dict setValue:[UserData currentUser].id forKey:@"userId"];
        [dict setValue:self.phoneTF.text forKey:@"phone"];
        [dict setValue:self.holderTF.text forKey:@"name"];
//        [dict setValue:[NSString stringWithFormat:@"%@\n%@", self.cityString,self.addressTextView.text] forKey:@"address"];
        [dict setValue:[NSString stringWithFormat:@"%@", self.addressTextView.text] forKey:@"detailAddress"];
        [dict setValue:cityArray[0] forKey:@"sheng"];
        [dict setValue:cityArray[1] forKey:@"shi"];
        [dict setValue:cityArray[2] forKey:@"qu"];
        
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


- (void)textViewValueChanged:(UITextView *)textView {
    
    
    
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
