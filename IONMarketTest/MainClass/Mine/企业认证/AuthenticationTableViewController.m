//
//  AuthenticationTableViewController.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/4/9.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "AuthenticationTableViewController.h"
#import "AuthDetailTViewController.h"
#import "UnitsPickerView.h"

@interface AuthenticationTableViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSString *leftImageUrl;
@property (nonatomic, strong) NSString *rightImageUrl;
@property (nonatomic, assign) BOOL isUploaded;
@property (nonatomic, strong) AuthenticationModel *authModel;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UITextField *companyTF;
@property (weak, nonatomic) IBOutlet UIButton *moshiButton;
@property (weak, nonatomic) IBOutlet UITextField *contactTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UITextField *fuzerenTF;

@end

#define imageBaseUrl    @"http://118.31.35.233:8080/"

@implementation AuthenticationTableViewController {
    UIImagePickerController *_imagePickerController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"企业认证";
    [self initImagePickerController];
    self.dataSource = [NSMutableArray array];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.leftButton.layer.masksToBounds = YES;
    self.leftButton.layer.borderColor = [UIColor mianColor:2].CGColor;
    self.leftButton.layer.borderWidth = 1;
    self.leftButton.layer.cornerRadius = 5;
    self.rightButton.layer.masksToBounds = YES;
    self.rightButton.layer.borderColor = [UIColor mianColor:2].CGColor;
    self.rightButton.layer.borderWidth = 1;
    self.rightButton.layer.cornerRadius = 5;
    
    self.leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
    [self.leftButton setTitleEdgeInsets:UIEdgeInsetsMake(self.leftButton.imageView.frame.size.height ,-self.leftButton.imageView.frame.size.width, -10.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [self.leftButton setImageEdgeInsets:UIEdgeInsetsMake(-10.0, 0.0,0.0, -self.leftButton.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
    self.rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.rightButton setTitleEdgeInsets:UIEdgeInsetsMake(self.rightButton.imageView.frame.size.height ,-self.rightButton.imageView.frame.size.width, -10.0,0.0)];
    [self.rightButton setImageEdgeInsets:UIEdgeInsetsMake(-10.0, 0.0,0.0, -self.rightButton.titleLabel.bounds.size.width)];
    
    [self getData];
}

- (BOOL)checkInfo {
    [self.dataSource removeAllObjects];
    
    if (self.authModel.id.length) {
        self.companyTF.text.length?[self.dataSource addObject:self.companyTF.text]:[self.dataSource addObject:self.authModel.gongsimingchen];
        [self.dataSource addObject:self.moshiButton.currentTitle];
        self.fuzerenTF.text.length?[self.dataSource addObject:self.fuzerenTF.text]:[self.dataSource addObject:self.authModel.gongsifuzeren];
        self.contactTF.text.length?[self.dataSource addObject:self.contactTF.text]:[self.dataSource addObject:self.authModel.lianxiren];
        self.phoneTF.text.length?[self.dataSource addObject:self.phoneTF.text]:[self.dataSource addObject:self.authModel.lianxirendianhua];
        [self.dataSource addObject:self.addressLabel.text];
        [self.dataSource addObject:self.descLabel.text];
        if (!self.leftImageUrl.length) {
            self.leftImageUrl = self.authModel.fuzerenshenfenzheng;
        }
        if (!self.rightImageUrl.length) {
            self.rightImageUrl = self.authModel.yingyezhizhao;
        }
        [self.dataSource addObject:self.leftImageUrl];
        [self.dataSource addObject:self.rightImageUrl];
        
    } else {
        [self.dataSource addObject:self.companyTF.text];
        [self.dataSource addObject:self.moshiButton.currentTitle];
        [self.dataSource addObject:self.fuzerenTF.text];
        [self.dataSource addObject:self.contactTF.text];
        [self.dataSource addObject:self.phoneTF.text];
        [self.dataSource addObject:self.addressLabel.text];
        [self.dataSource addObject:self.descLabel.text];
        [self.dataSource addObject:[NSString stringWithFormat:@"%@%@", imageBaseUrl,self.leftImageUrl]];
        [self.dataSource addObject:[NSString stringWithFormat:@"%@%@", imageBaseUrl,self.rightImageUrl]];
        
    }
    
    for (NSString *string in self.dataSource) {
        if (!string.length || !self.leftImageUrl.length || !self.rightImageUrl.length) {
            return NO;
            break;
        }
    }
    
    return YES;
}


- (IBAction)doneClicker:(UIButton *)sender {
    
    if (![self checkInfo]) {
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"信息不完整！" time:0 aboutType:WHShowViewMode_Text state:NO];
        return;
    }
    
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
    
    
    
    NSString *url = @"";
    if (self.authModel.id.length) {
        url = Interface_UpdateRenzheng;
        [dict setValue:self.authModel.id forKey:@"renzhengId"];
    } else {
        url = Interface_SaveRenzheng;
        [dict setValue:[UserData currentUser].id forKey:@"userId"];
    }
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:url andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"---++%@", resultDic);
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:msg time:0 aboutType:WHShowViewMode_Text state:YES];
        
        [self.tableView reloadData];
    } failure:^(NSString *error, NSInteger code) {
        
    }];
}

- (IBAction)selectClicker:(UIButton *)sender {
    UnitsPickerView *pv = [[UnitsPickerView alloc] initWithFrame:self.view.bounds withDataSource:@[@"用户",@"经销商"]];
    __weak typeof(self) weakself = self;
    [pv loadData:weakself andClickBlock:^(NSString *clueStr) {
        [weakself.moshiButton setTitle:clueStr forState:UIControlStateNormal];
    }];
    [self.view addSubview:pv];
    
}


- (IBAction)uploadClicker:(UIButton *)sender {
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
        
        NSArray *dataArr = resultDic[@"result"];
        self.authModel = [[AuthenticationModel alloc] initWithDictionary:[dataArr firstObject] error:nil];
        self.companyTF.placeholder = self.authModel.gongsimingchen;
        [self.moshiButton setTitle:self.authModel.jingyingmoshi forState:UIControlStateNormal];
        self.fuzerenTF.placeholder = self.authModel.gongsifuzeren;
        self.contactTF.placeholder = self.authModel.lianxiren;
        self.phoneTF.placeholder = self.authModel.lianxirendianhua;
        self.addressLabel.text = self.authModel.xiangxidizhi;
        self.descLabel.text = self.authModel.gongsijieshao;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *leftImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.authModel.fuzerenshenfenzheng]]];
            UIImage *rightImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.authModel.yingyezhizhao]]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.leftButton setBackgroundImage:leftImage forState:UIControlStateNormal];
                [self.rightButton setBackgroundImage:rightImage forState:UIControlStateNormal];
            });
        });
        
        
        [self.tableView reloadData];
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
        NSArray *array = @[@"填写详细地址",@"填写公司介绍",@"联系我们"];
        AuthDetailTViewController *detail = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"AuthDetail"];
        detail.title = [array objectAtIndex:indexPath.row-5];
        
        __weak typeof(self) weakself = self;
        detail.PassValueBlock = ^(NSString *inputStr) {
            if (indexPath.row == 6) {
                weakself.descLabel.text = inputStr;
            }
            if (indexPath.row == 5) {
                weakself.addressLabel.text = inputStr;
            }
        };
        if (indexPath.row == 5) {
            detail.contentStr = self.addressLabel.text;
        }
        if (indexPath.row == 6) {
            detail.contentStr = self.descLabel.text;
        }
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
    
    if (self.isUploaded) {
        [self.leftButton setBackgroundImage:image forState:UIControlStateNormal];
        [self.leftButton setTitle:@"" forState:UIControlStateNormal];
    } else {
        [self.rightButton setBackgroundImage:image forState:UIControlStateNormal];
        [self.rightButton setTitle:@"" forState:UIControlStateNormal];
    }
    
    [self.tableView reloadData];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self uploadUserImage:image];
    }];
}


- (void)uploadUserImage:(UIImage *)userimage  {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:@[userimage] WithType:Interface_UserUpload andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"upload:   %@",resultDic);
        
        if (self.isUploaded) {
            self.leftImageUrl = [NSString stringWithFormat:@"%@%@", imageBaseUrl,resultDic[@"path"]];
        } else {
            self.rightImageUrl = [NSString stringWithFormat:@"%@%@", imageBaseUrl,resultDic[@"path"]];
        }
        
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"上传成功！" time:0.0 aboutType:WHShowViewMode_Text state:YES];
    } failure:^(NSString *error, NSInteger code) {
        
        
    }];
}






@end

