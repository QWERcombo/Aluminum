//
//  ImageShowViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/10/7.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "ImageShowViewController.h"
#import <UShareUI/UShareUI.h>
#import "ABBannerView.h"

@interface ImageShowViewController ()

@end

@implementation ImageShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"材质证明";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *recordBtn = [UIButton buttonWithTitle:@"分享" andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    recordBtn.frame = CGRectMake(0, 0, 40, 40);
    [recordBtn addTarget:self action:@selector(payCliker:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:recordBtn];
    
    if (!self.imageUrlArray.count) {
        
        UILabel *label = [UILabel lableWithText:@"暂无材质证明" Font:FONT_ArialMT(15) TextColor:[UIColor Black_WordColor]];
        label.frame = CGRectMake(0, 0, 100, 45);
        label.textAlignment = NSTextAlignmentCenter;
        label.center = self.view.center;
        [self.view addSubview:label];
    } else {
        
//        [XLPhotoBrowser showPhotoBrowserWithImages:self.imageUrlArray currentImageIndex:0];
        ABBannerView *bannerView = [[ABBannerView alloc] initPageViewFrame:CGRectMake(0, 0, SCREEN_WIGHT, SCREEN_HEIGHT-100) webImageStr:self.imageUrlArray titleStr:nil didSelectPageViewAction:^(NSInteger index) {
            NSLog(@"click---%ld", index);
        }];
        
        bannerView.duration = 6000;
        bannerView.selfBackgroundColor = [UIColor whiteColor];
        bannerView.pageIndicatorTintColor = [UIColor grayColor];
        bannerView.currentPageColor = [UIColor mianColor:2];
        
        [self.view addSubview:bannerView];
    }
}

- (void)payCliker:(UIButton *)sender {
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_QQ)]];
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        
        [self shareWebPageToPlatformType:platformType];
    }];
    
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    //    NSString* thumbURL =  IMG(@"App_Logo");
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"材质证明" descr:@"欢迎使用乐切App" thumImage:IMG(@"App_Logo")];
    //设置网页地址
    shareObject.webpageUrl = self.imageUrlArray.count?[self.imageUrlArray firstObject]:Share_URL;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
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

@end
