//
//  UserInfoSettingViewController.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/12.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "UserInfoSettingViewController.h"

@interface UserInfoSettingViewController ()
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;
@property (weak, nonatomic) IBOutlet UITextField *inputTF;

@end

@implementation UserInfoSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    switch (self.updateMode) {
        case UpdateMode_name:
            self.title = @"修改姓名";
            self.inputTF.placeholder = @"姓名";
            break;
        case UpdateMode_company:
            self.title = @"修改公司";
            self.inputTF.placeholder = @"公司";
            break;
        case UpdateMode_role:
            self.title = @"修改职位";
            self.inputTF.placeholder = @"职位";
            break;
            
        default:
            break;
    }
}

- (IBAction)doneClicker:(UIButton *)sender {
    
    if (!self.inputTF.text.length) {
        
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请正确填写修改信息!" time:0 aboutType:WHShowViewMode_Text state:NO];
        return;
    }
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setValue:[UserData currentUser].id forKey:@"userId"];
    switch (self.updateMode) {
        case UpdateMode_name:
            [dataDic setValue:self.inputTF.text forKey:@"name"];
            [dataDic setValue:[UserData currentUser].company forKey:@"company"];
            [dataDic setValue:[UserData currentUser].zhiwei forKey:@"zhiwei"];
            [dataDic setValue:[UserData currentUser].headImgUrl forKey:@"headImgUrl"];
            break;
        case UpdateMode_company:
            [dataDic setValue:self.inputTF.text forKey:@"company"];
            [dataDic setValue:[UserData currentUser].name forKey:@"name"];
            [dataDic setValue:[UserData currentUser].zhiwei forKey:@"zhiwei"];
            [dataDic setValue:[UserData currentUser].headImgUrl forKey:@"headImgUrl"];
            break;
        case UpdateMode_role:
            [dataDic setValue:self.inputTF.text forKey:@"zhiwei"];
            [dataDic setValue:[UserData currentUser].company forKey:@"company"];
            [dataDic setValue:[UserData currentUser].name forKey:@"name"];
            [dataDic setValue:[UserData currentUser].headImgUrl forKey:@"headImgUrl"];
            break;
        default:
            break;
    }
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dataDic imageArray:nil WithType:Interface_updateUser andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        
        if (self.passValueBlock) {
            self.passValueBlock(self.inputTF.text);
        }
        
        switch (self.updateMode) {
            case UpdateMode_name:
                [[UserData currentUser] giveData:@{@"name":self.inputTF.text}];
                break;
            case UpdateMode_company:
                [[UserData currentUser] giveData:@{@"company":self.inputTF.text}];
                break;
            case UpdateMode_role:
                [[UserData currentUser] giveData:@{@"zhiwei":self.inputTF.text}];
                break;
            default:
                break;
        }
        
        
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"修改成功!" time:0 aboutType:WHShowViewMode_Text state:YES];
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
