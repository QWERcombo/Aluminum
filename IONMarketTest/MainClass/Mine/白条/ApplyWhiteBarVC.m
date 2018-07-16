//
//  ApplyWhiteBarVC.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/5/17.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "ApplyWhiteBarVC.h"
#import "PhotoAlertController.h"

@interface ApplyWhiteBarVC ()
@property (weak, nonatomic) IBOutlet UIImageView *zhizhaoImage;
@property (weak, nonatomic) IBOutlet UIImageView *farenImage;
@property (weak, nonatomic) IBOutlet UIImageView *yinhangImage;
@property (weak, nonatomic) IBOutlet UIImageView *hetongImage;
@property (weak, nonatomic) IBOutlet UILabel *shenhe1;
@property (weak, nonatomic) IBOutlet UILabel *shenhe2;
@property (weak, nonatomic) IBOutlet UILabel *shenhe3;
@property (weak, nonatomic) IBOutlet UILabel *shenhe4;

@property (nonatomic, strong) NSString *zhizhaoUrl;
@property (nonatomic, strong) NSString *farenUrl;
@property (nonatomic, strong) NSString *yinhangUrl;
@property (nonatomic, strong) NSString *hetongUrl;
@end

@implementation ApplyWhiteBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zhizhaoImage.layer.borderColor = [UIColor mianColor:2].CGColor;
    self.zhizhaoImage.layer.borderWidth = 1;
    self.zhizhaoImage.layer.cornerRadius = 5;
    self.zhizhaoImage.layer.masksToBounds = YES;
    self.farenImage.layer.borderColor = [UIColor mianColor:2].CGColor;
    self.farenImage.layer.borderWidth = 1;
    self.farenImage.layer.cornerRadius = 5;
    self.farenImage.layer.masksToBounds = YES;
    self.yinhangImage.layer.borderColor = [UIColor mianColor:2].CGColor;
    self.yinhangImage.layer.borderWidth = 1;
    self.yinhangImage.layer.cornerRadius = 5;
    self.yinhangImage.layer.masksToBounds = YES;
    self.hetongImage.layer.borderColor = [UIColor mianColor:2].CGColor;
    self.hetongImage.layer.borderWidth = 1;
    self.hetongImage.layer.cornerRadius = 5;
    self.hetongImage.layer.masksToBounds = YES;
    
}

- (IBAction)buttonClicker:(UIButton *)sender {
    
    PhotoAlertController *photoAlert = [PhotoAlertController initPhotoAlertControllerOnRebackImageBlock:^(UIImage *pickerImage) {
        
        switch (sender.tag-100) {
            case 0:
                self.zhizhaoImage.image = pickerImage;
                break;
            case 1:
                self.farenImage.image = pickerImage;
                break;
            case 2:
                self.yinhangImage.image = pickerImage;
                break;
            case 3:
                self.hetongImage.image = pickerImage;
                break;
            default:
                break;
        }
        
        
        [self uploadImageSingle:pickerImage byTag:sender.tag];
        [sender setImage:[UIImage new] forState:UIControlStateNormal];
        
    } andRootViewController:self];
    
    [self presentViewController:photoAlert animated:YES completion:nil];
}


//多张传
- (IBAction)applyClicker:(UIButton *)sender {
    
    if (!self.yinhangImage.image || !self.farenImage.image || !self.zhizhaoImage.image || !self.hetongImage.image) {
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请先上传图片!" time:0 aboutType:WHShowViewMode_Text state:NO];
        return;
    }
    
    [self apply:nil];
    //先上传图片
//    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:nil imageArray:@[self.zhizhaoImage.image, self.farenImage.image, self.yinhangImage.image, self.hetongImage.image] WithType:Interface_UserUpload andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
//        [self apply:resultDic[@"path"]];
//    } failure:^(NSString *error, NSInteger code) {
//
//    }];
}


//单张传
- (void)uploadImageSingle:(UIImage *)image byTag:(NSInteger)tag {
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:nil imageArray:@[image] WithType:Interface_UserUpload andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        
        NSString *imageurl = resultDic[@"path"];
        
        switch (tag) {
            case 100:
                self.zhizhaoUrl = imageurl;
                break;
            case 101:
                self.farenUrl = imageurl;
                break;
            case 102:
                self.yinhangUrl = imageurl;
                break;
            case 103:
                self.hetongUrl = imageurl;
                break;
            default:
                break;
        }
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
    
}

- (void)apply:(NSArray *)imagePathArr {
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    NSString *url = @"";
    if (self.baitiaoID.length) {
        [dataDic setValue:self.baitiaoID forKey:@"baitiaoId"];
        url = Interface_UpdateBaitiao;
    } else {
        [dataDic setValue:[UserData currentUser].id forKey:@"userId"];
        url = Interface_SaveBaitiao;
    }
    
    
//    [dataDic setValue:imagePathArr[0] forKey:@"yingyezhizhao"];
//    [dataDic setValue:imagePathArr[1] forKey:@"farenshenfenzheng"];
//    [dataDic setValue:imagePathArr[2] forKey:@"yinhangliushui"];
//    [dataDic setValue:imagePathArr[3] forKey:@"zulinhetong"];
    [dataDic setValue:self.zhizhaoUrl forKey:@"yingyezhizhao"];
    [dataDic setValue:self.farenUrl forKey:@"farenshenfenzheng"];
    [dataDic setValue:self.yinhangUrl forKey:@"yinhangliushui"];
    [dataDic setValue:self.hetongUrl forKey:@"zulinhetong"];

    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dataDic imageArray:nil WithType:url andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"提交申请成功!" time:0 aboutType:WHShowViewMode_Text state:YES];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
