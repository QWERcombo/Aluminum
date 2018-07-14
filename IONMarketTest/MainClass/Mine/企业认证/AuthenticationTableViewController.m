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
@property (weak, nonatomic) IBOutlet UILabel *companyLab;
@property (weak, nonatomic) IBOutlet UILabel *moshiLab;
@property (weak, nonatomic) IBOutlet UILabel *fuzerenLab;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *contactLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *descLab;
@property (weak, nonatomic) IBOutlet UILabel *lianxiwomenLab;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@property (nonatomic, assign) BOOL isScale; //图片点击放大
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
    
    self.leftButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.rightButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
//    self.leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
//    self.rightButton.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
    
    [self getData];
}

- (BOOL)checkInfo {
    [self.dataSource removeAllObjects];
    
    if (self.authModel.id.length && ![self.authModel.shenhezhuangtai isEqualToString:@"审核拒绝"]) {
        self.companyLab.text.length?[self.dataSource addObject:self.companyLab.text]:[self.dataSource addObject:self.authModel.gongsimingchen];
        [self.dataSource addObject:self.moshiLab.text];
        self.fuzerenLab.text.length?[self.dataSource addObject:self.fuzerenLab.text]:[self.dataSource addObject:self.authModel.gongsifuzeren];
        self.contactLab.text.length?[self.dataSource addObject:self.contactLab.text]:[self.dataSource addObject:self.authModel.lianxiren];
        self.phoneLab.text.length?[self.dataSource addObject:self.phoneLab.text]:[self.dataSource addObject:self.authModel.lianxirendianhua];
        [self.dataSource addObject:self.addressLab.text];
        [self.dataSource addObject:self.descLab.text];
        if (!self.leftImageUrl.length) {
            self.leftImageUrl = self.authModel.fuzerenshenfenzheng;
        }
        if (!self.rightImageUrl.length) {
            self.rightImageUrl = self.authModel.yingyezhizhao;
        }
        [self.dataSource addObject:self.leftImageUrl];
        [self.dataSource addObject:self.rightImageUrl];
        
    } else {
        [self.dataSource addObject:self.companyLab.text];
        [self.dataSource addObject:self.moshiLab.text];
        [self.dataSource addObject:self.fuzerenLab.text];
        [self.dataSource addObject:self.contactLab.text];
        [self.dataSource addObject:self.phoneLab.text];
        [self.dataSource addObject:self.addressLab.text];
        [self.dataSource addObject:self.descLab.text];
        
        
        if ([self.authModel.shenhezhuangtai isEqualToString:@"审核拒绝"]) {
            
            [self.dataSource addObject:self.leftImageUrl = @""];
            [self.dataSource addObject:self.rightImageUrl = @""];
            
        } else {
            [self.dataSource addObject:[NSString stringWithFormat:@"%@%@", imageBaseUrl,self.leftImageUrl]];
            [self.dataSource addObject:[NSString stringWithFormat:@"%@%@", imageBaseUrl,self.rightImageUrl]];
        }
        
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
        [self.navigationController popViewControllerAnimated:YES];
        [self.tableView reloadData];
    } failure:^(NSString *error, NSInteger code) {
        
    }];
}

- (void)selectClicker {
    UnitsPickerView *pv = [[UnitsPickerView alloc] initWithFrame:self.view.bounds withDataSource:@[@"用户",@"经销商"]];
    __weak typeof(self) weakself = self;
    [pv loadData:weakself andClickBlock:^(NSString *clueStr) {
        weakself.moshiLab.text = clueStr;
    }];
    [self.view addSubview:pv];
    
}


- (IBAction)uploadClicker:(UIButton *)sender {
    if (sender.tag == 220) {
        self.isUploaded = YES;
    } else {
        self.isUploaded = NO;
    }
    
    if (self.isScale) {
        //图片浏览
        [self scalePhoto];
    } else {
        //上传图片
        [self selectHeaderImage];
    }
}

- (void)getData {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[UserData currentUser].id forKey:@"userId"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_GetRenzhengByUser andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"++---%@", resultDic);
        
        NSArray *dataArr = resultDic[@"result"];
        self.authModel = [[AuthenticationModel alloc] initWithDictionary:[dataArr firstObject] error:nil];
        self.companyLab.text = self.authModel.gongsimingchen;
        self.moshiLab.text = self.authModel.jingyingmoshi;
        self.fuzerenLab.text = self.authModel.gongsifuzeren;
        self.contactLab.text = self.authModel.lianxiren;
        self.phoneLab.text = self.authModel.lianxirendianhua;
        self.addressLab.text = self.authModel.xiangxidizhi;
        self.descLab.text = self.authModel.gongsijieshao;
        self.lianxiwomenLab.text = self.authModel.lianxirendianhua;
        
        
        if (self.authModel && ![self.authModel.shenhezhuangtai isEqualToString:@"审核拒绝"]) {
            
            self.isScale = YES;
            self.confirmBtn.hidden = YES;
            
            dispatch_async(dispatch_queue_create("concurrent", DISPATCH_QUEUE_CONCURRENT), ^{
                
                [self.leftButton sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", imageBaseUrl,self.authModel.fuzerenshenfenzheng]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"White_add"]];
                [self.rightButton sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", imageBaseUrl,self.authModel.yingyezhizhao]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"White_add"]];
            });
        } else {
            
            self.isScale = NO;
            self.confirmBtn.hidden = NO;
        }
        
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:self.authModel.shenhezhuangtai time:0 aboutType:WHShowViewMode_Text state:NO];
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
    if (indexPath.row==1) {
        [self selectClicker];
    } else {
        
        NSArray *array = @[@"公司名称",@"",@"公司负责人",@"公开联系人",@"公开联系人号码",@"详细地址",@"公司介绍",@"联系我们"];
        AuthDetailTViewController *detail = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"AuthDetail"];
        detail.title = [array objectAtIndex:indexPath.row];
        
        __weak typeof(self) weakself = self;
        detail.PassValueBlock = ^(NSString *inputStr) {
            switch (indexPath.row) {
                case 0:
                    weakself.companyLab.text = inputStr;
                    break;
                case 1:
                    
                    break;
                case 2:
                    weakself.fuzerenLab.text = inputStr;
                    break;
                case 3:
                    weakself.phoneLab.text = inputStr;
                    break;
                case 4:
                    weakself.contactLab.text = inputStr;
                    break;
                case 5:
                    weakself.addressLab.text = inputStr;
                    break;
                case 6:
                    weakself.descLab.text = inputStr;
                    break;
                case 7:
                    weakself.lianxiwomenLab.text = inputStr;
                    break;
                default:
                    break;
            }
        };
        
        switch (indexPath.row) {
            case 0:
                detail.contentStr = self.companyLab.text;
                break;
            case 1:
                
                break;
            case 2:
                detail.contentStr = self.fuzerenLab.text;
                break;
            case 3:
                detail.contentStr = self.phoneLab.text;
                break;
            case 4:
                detail.contentStr = self.contactLab.text;
                break;
            case 5:
                detail.contentStr = self.addressLab.text;
                break;
            case 6:
                detail.contentStr = self.descLab.text;
                break;
            case 7:
                detail.contentStr = self.lianxiwomenLab.text;
                break;
            default:
                break;
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
        [self.leftButton setImage:image forState:UIControlStateNormal];
//        [self.leftButton setTitle:@"" forState:UIControlStateNormal];
    } else {
        [self.rightButton setImage:image forState:UIControlStateNormal];
//        [self.rightButton setTitle:@"" forState:UIControlStateNormal];
    }
    
    [self.tableView reloadData];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [self uploadUserImage:image];
    }];
}


- (void)uploadUserImage:(UIImage *)userimage  {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:@[userimage] WithType:Interface_UserUpload andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
//        NSLog(@"upload:   %@",resultDic);
        
        if (self.isUploaded) {
            self.leftImageUrl = [NSString stringWithFormat:@"%@",resultDic[@"path"]];
        } else {
            self.rightImageUrl = [NSString stringWithFormat:@"%@",resultDic[@"path"]];
        }
        
//        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"上传成功！" time:0.0 aboutType:WHShowViewMode_Text state:YES];
    } failure:^(NSString *error, NSInteger code) {
    }];
}


- (void)scalePhoto {
    
    [XLPhotoBrowser showPhotoBrowserWithImages:@[[NSString stringWithFormat:@"%@%@", imageBaseUrl, self.authModel.fuzerenshenfenzheng], [NSString stringWithFormat:@"%@%@", imageBaseUrl, self.authModel.yingyezhizhao]] currentImageIndex:0];
}



@end

