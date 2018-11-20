//
//  ZiZhuXiaDanViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/10/19.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "ZiZhuXiaDanViewController.h"
#import "PhotoAlertController.h"

@interface ZiZhuXiaDanViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *showImgv;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end

@implementation ZiZhuXiaDanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"自助下单";
    self.showImgv.layer.masksToBounds = YES;
}

- (IBAction)addImgv:(UIButton *)sender {
    
    PhotoAlertController *photoAlert = [PhotoAlertController initPhotoAlertControllerOnRebackImageBlock:^(UIImage *pickerImage) {
        self.showImgv.image = pickerImage;
        self.addBtn.hidden = YES;
    } andRootViewController:self];
    
    [self presentViewController:photoAlert animated:YES completion:nil];
    
}


- (IBAction)submit:(UIButton *)sender {
    
    if (self.showImgv.image) {
        
        [self uploadImage:self.showImgv.image];
    }
}

- (IBAction)reset:(UIButton *)sender {
    self.showImgv.image = nil;
    self.addBtn.hidden = NO;
}

- (void)uploadImage:(UIImage *)image {
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:nil imageArray:@[image] WithType:Interface_UserUpload andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        
        [self change:resultDic[@"path"]];
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}

- (void)change:(NSString *)imageUrl {
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setValue:[UserData currentUser].user_id forKey:@"userId"];
    [dataDic setValue:imageUrl forKey:@"file"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dataDic imageArray:nil WithType:Interface_savePicOrder andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"提交成功!请等待客服处理" time:0 aboutType:WHShowViewMode_Text state:YES];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString *error, NSInteger code) {
        
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
