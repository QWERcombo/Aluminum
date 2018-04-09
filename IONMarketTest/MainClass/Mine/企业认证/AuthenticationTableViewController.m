//
//  AuthenticationTableViewController.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/4/9.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "AuthenticationTableViewController.h"
#import "AuthDetailTViewController.h"

@interface AuthenticationTableViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSString *leftImageUrl;
@property (nonatomic, strong) NSString *rightImageUrl;
@property (nonatomic, assign) BOOL isUploaded;
@end

@implementation AuthenticationTableViewController {
    UIImagePickerController *_imagePickerController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"企业认证";
    [self initImagePickerController];
    self.dataSource = [NSMutableArray array];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self getData];
}

- (IBAction)doneClicker:(UIButton *)sender {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:self.dataSource[0] forKey:@"gongsimingchen"];
    [dict setValue:self.dataSource[1] forKey:@"jingyingmoshi"];
    [dict setValue:self.dataSource[2] forKey:@"gongsifuzeren"];
    [dict setValue:self.dataSource[3] forKey:@"lianxiren"];
    [dict setValue:self.dataSource[4] forKey:@"lianxirendianhua"];
    [dict setValue:self.dataSource[5] forKey:@"xiangxidizhi"];
    [dict setValue:self.dataSource[6] forKey:@"gongsijieshao"];
    [dict setValue:self.dataSource[7] forKey:@"fuzerenshenfenzheng"];
    [dict setValue:self.dataSource[8] forKey:@"yingyezhizhao"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_SaveRenzheng andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"---++%@", resultDic);
        
        
        [self.tableView reloadData];
    } failure:^(NSString *error, NSInteger code) {
        
    }];
}

- (IBAction)selectClicker:(UIButton *)sender {
    NSLog(@"%ld", sender.tag);
    
}


- (IBAction)uploadClicker:(UIButton *)sender {
    NSLog(@"%ld", sender.tag);
    
    if (sender.tag == 220) {
        self.isUploaded = YES;
    } else {
        self.isUploaded = NO;
    }
    
    [self selectHeaderImage];
}

- (void)getData {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[UserData currentUser].id forKey:@"userId"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_GetRenzhengByUser andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"++---%@", resultDic);
        
        
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row>4 && indexPath.row <8) {
        NSArray *array = @[@"详细地址",@"公司介绍",@"联系我们"];
        AuthDetailTViewController *detail = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"AuthDetail"];
        detail.title = [array objectAtIndex:indexPath.row-5];
        [self.navigationController pushViewController:detail animated:YES];
    }
}


- (void)selectHeaderImage {
    UIAlertController *imageAlert = [UIAlertController alertControllerWithTitle:nil message:@"上传图片" preferredStyle:UIAlertControllerStyleActionSheet];
    __weak typeof(self) weakself = self;
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [weakself selectImageFromCamera];
    }];
    UIAlertAction *album = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [weakself selectImageFromAlbum];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [imageAlert addAction:camera];
    [imageAlert addAction:album];
    [imageAlert addAction:cancel];
    [self presentViewController:imageAlert animated:YES completion:nil];
}


- (void)initImagePickerController {
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    _imagePickerController.allowsEditing = YES;  //是否可编辑
}


#pragma mark 从摄像头获取图片或视频
- (void)selectImageFromCamera
{
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //录制视频时长，默认10s
    //    _imagePickerController.videoMaximumDuration = 15;
    
    //相机类型（拍照、录像...）字符串需要做相应的类型转换
    _imagePickerController.mediaTypes = @[(NSString *)kUTTypeMovie,(NSString *)kUTTypeImage];
    
    //视频上传质量
    _imagePickerController.videoQuality = UIImagePickerControllerQualityTypeMedium;
    
    //设置摄像头模式（拍照，录制视频）
    _imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}
#pragma mark 从相册获取图片或视频
- (void)selectImageFromAlbum
{
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:_imagePickerController animated:YES completion:nil];
}



#pragma mark ----- UIImagePickerControllerDelegate
//该代理方法仅适用于只选取图片时
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    //    NSLog(@"选择完毕----image:%@-----info:%@",image,editingInfo);
//    self.holderImage = image;

    [self.tableView reloadData];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self uploadUserImage:image];
    }];
}


- (void)uploadUserImage:(UIImage *)userimage  {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setValue:@"" forKey:@""];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:@[userimage] WithType:Interface_UserUpload andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"upload:   %@",resultDic);
        
        if (self.isUploaded) {
            self.leftImageUrl = resultDic[@"path"];
        } else {
            self.rightImageUrl = resultDic[@"path"];
        }
        
        [[UtilsData sharedInstance] showAlertTitle:@"上传成功！" detailsText:msg time:0.0 aboutType:WHShowViewMode_Text state:YES];
    } failure:^(NSString *error, NSInteger code) {
        
        
    }];
}






@end
