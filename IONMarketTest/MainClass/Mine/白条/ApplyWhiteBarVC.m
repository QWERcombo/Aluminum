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

@end

@implementation ApplyWhiteBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
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
        [sender setImage:[UIImage new] forState:UIControlStateNormal];
        
    } andRootViewController:self];
    
    [self presentViewController:photoAlert animated:YES completion:nil];
}

- (IBAction)applyClicker:(UIButton *)sender {
    
    if (!self.yinhangImage.image || !self.farenImage.image || !self.zhizhaoImage.image || !self.hetongImage.image) {
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请先上传图片!" time:0 aboutType:WHShowViewMode_Text state:NO];
        return;
    }
    
    //先上传图片
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:nil imageArray:@[self.zhizhaoImage.image, self.farenImage.image, self.yinhangImage.image, self.hetongImage.image] WithType:Interface_MultiUpload andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        [self apply:resultDic[@"path"]];
    } failure:^(NSString *error, NSInteger code) {
        
    }];
}

- (void)apply:(NSArray *)imagePathArr {
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setValue:[UserData currentUser].id forKey:@"userId"];
    [dataDic setValue:imagePathArr[0] forKey:@"yingyezhizhao"];
    [dataDic setValue:imagePathArr[1] forKey:@"farenshenfenzheng"];
    [dataDic setValue:imagePathArr[2] forKey:@"yinhangliushui"];
    [dataDic setValue:imagePathArr[3] forKey:@"zulinhetong"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dataDic imageArray:nil WithType:Interface_SaveBaitiao andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"申请成功!" time:0 aboutType:WHShowViewMode_Text state:YES];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
