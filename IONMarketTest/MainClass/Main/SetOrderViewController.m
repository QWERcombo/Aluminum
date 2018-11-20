//
//  SetOrderViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/15.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "SetOrderViewController.h"
#import "PhotoAlertController.h"

@interface SetOrderViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *order_imgv;
@property (nonatomic, assign) BOOL isUpload;
@end

@implementation SetOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor mianColor:1];
    self.order_imgv.layer.masksToBounds = YES;
    self.order_imgv.contentMode = UIViewContentModeScaleAspectFill;
}


#pragma mark ---- Action
- (IBAction)uploadButton:(UIButton *)sender {
    if (self.isUpload) {
        
        [self uploadImage:self.order_imgv.image];
        
    } else {
        PhotoAlertController *photoAlert = [PhotoAlertController initPhotoAlertControllerOnRebackImageBlock:^(UIImage *pickerImage) {
            self.order_imgv.image = pickerImage;
            self.isUpload = YES;
            
            [sender setTitle:@"确定" forState:UIControlStateNormal];
        } andRootViewController:self];
        [self presentViewController:photoAlert animated:YES completion:nil];
    }
}

//上传图片
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
