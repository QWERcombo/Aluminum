//
//  UserInfoViewController.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/12.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoSettingViewController.h"
#import "PhotoAlertController.h"
#import <UMShare/UMShare.h>

@interface UserInfoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *userHeader;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userPhone;
@property (weak, nonatomic) IBOutlet UILabel *userCompany;
@property (weak, nonatomic) IBOutlet UILabel *userRole;
@property (weak, nonatomic) IBOutlet UILabel *weixinBind;

@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) UIImage *image;
@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人信息";
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.userHeader sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", BASE_URL_IMAGE_APP, [UserData currentUser].headImgUrl]] placeholderImage:IMG(@"head_default")];
    self.userHeader.contentMode = UIViewContentModeScaleAspectFill;
    self.userHeader.layer.masksToBounds = YES;
    self.userHeader.layer.cornerRadius = 20;
    self.userName.text = [UserData currentUser].name;
    self.userRole.text = [UserData currentUser].zhiwei;
    self.userCompany.text = [UserData currentUser].company;
    self.userPhone.text = [UserData currentUser].phone;
    self.weixinBind.text = @"未绑定";
    self.weixinBind.textColor = [UIColor colorWithHexString:@"#CED4DA"];
    
}

#pragma mark --- Delegate&DataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UserInfoSettingViewController *setting = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"UserInfoSettingViewController"];
    if (indexPath.section==0) {
        if (indexPath.row==1) {
            
            PhotoAlertController *photoAlert = [PhotoAlertController initPhotoAlertControllerOnRebackImageBlock:^(UIImage *pickerImage) {
                
                self.image = pickerImage;
                [self uploadImage:pickerImage];
                
            } andRootViewController:self];
            
            [self presentViewController:photoAlert animated:YES completion:nil];
            
        }
        if (indexPath.row==2) {
            setting.updateMode = UpdateMode_name;
            [setting setPassValueBlock:^(NSString *value) {
                self.userName.text = value;
            }];
            [self.navigationController pushViewController:setting animated:YES];
        }
        if (indexPath.row==3) {
            [setting setPassValueBlock:^(NSString *value) {
                self.userCompany.text = value;
            }];
            setting.updateMode = UpdateMode_company;
            [self.navigationController pushViewController:setting animated:YES];
        }
        if (indexPath.row==4) {
            [setting setPassValueBlock:^(NSString *value) {
                self.userRole.text = value;
            }];
            setting.updateMode = UpdateMode_role;
            [self.navigationController pushViewController:setting animated:YES];
        }
//        if (indexPath.row == 7 && [_weixinBind.text isEqualToString:@"未绑定"]) {
//            //微信绑定
//            [self bindWeiXin];
//        }
    }
    
    
}


//上传图片
- (void)uploadImage:(UIImage *)image {
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:nil imageArray:@[image] WithType:Interface_UserUpload andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        
        self.path = resultDic[@"path"];
        [self change:resultDic[@"path"]];
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}
- (void)change:(NSString *)imageUrl {
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setValue:[UserData currentUser].user_id forKey:@"userId"];
    [dataDic setValue:imageUrl forKey:@"headImgUrl"];
    [dataDic setValue:[UserData currentUser].zhiwei forKey:@"zhiwei"];
    [dataDic setValue:[UserData currentUser].company forKey:@"company"];
    [dataDic setValue:[UserData currentUser].name forKey:@"name"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dataDic imageArray:nil WithType:Interface_updateUser andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        self.userHeader.image = self.image;
        [[UserData currentUser] giveData:@{@"headImgUrl":self.path}];
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"修改成功!" time:0 aboutType:WHShowViewMode_Text state:YES];
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}

- (void)bindWeiXin {
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:self completion:^(id result, NSError *error) {
        if (error) {
            
            
        } else {
            UMSocialUserInfoResponse *resp = result;
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid);
            NSLog(@"Wechat unionid: %@", resp.unionId);
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name);
            NSLog(@"Wechat iconurl: %@", resp.iconurl);
            NSLog(@"Wechat gender: %@", resp.unionGender);
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
            self.weixinBind.text = @"已绑定";
            self.weixinBind.textColor = [UIColor mianColor:2];
        }
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
