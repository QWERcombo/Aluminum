//
//  WhiteBarViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/14.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "WhiteBarViewController.h"
#import "ApplyWhiteBarVC.h"
#import "WhiteBarVC.h"
#import "TradeListViewController.h"

@interface WhiteBarViewController ()
@property (nonatomic, assign) BOOL isReject; //审核拒绝
@property (nonatomic, strong) NSString *baitiaoID;
@end

@implementation WhiteBarViewController {
    UIButton *applyButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getDataSource];
}

- (void)setupSubviews:(NSString *)title {
    [self.view addSubview:self.tabView];
    self.tabView.backgroundColor = [UIColor mianColor:1];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        if (SCREEN_WIGHT==812) {
            make.bottom.equalTo(self.view.mas_bottom).offset(-84);
        } else {
            make.bottom.equalTo(self.view.mas_bottom).offset(-50);
        }
    }];

    NSString *buttonTitle = @"";
    NSString *emptyTitle = @"";
    if ([title isEqualToString:@"申请开通"]) {
        buttonTitle = @"申请开通";
        emptyTitle = @"白条还未开通";
    } else if ([title isEqualToString:@"待审核"]) {
        buttonTitle = @"审核中";
        emptyTitle = @"审核中";
    } else if ([title isEqualToString:@"审核通过"]) {

    } else if ([title isEqualToString:@"审核拒绝"]) {
        buttonTitle = @"重新申请";
        emptyTitle = @"审核拒绝，请重新申请";
        self.isReject = YES;
    } else {
        
    }
    applyButton = [UIButton buttonWithTitle:buttonTitle andFont:FONT_ArialMT(18) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    [self.view addSubview:applyButton];
    applyButton.backgroundColor = [UIColor mianColor:2];
    if (![title isEqualToString:@"待审核"]) {
        [applyButton addTarget:self action:@selector(applyCliker:) forControlEvents:UIControlEventTouchUpInside];
    }
    [applyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(50));
        make.left.right.equalTo(self.view);
        if (SCREEN_HEIGHT==812) {
            make.bottom.equalTo(self.view.mas_bottom).offset(-34);
        } else {
            make.bottom.equalTo(self.view);
        }
    }];
    
    
    self.tabView.ly_emptyView = [[PublicFuntionTool sharedInstance] getEmptyViewWithType:WHShowEmptyMode_noData withHintText:emptyTitle andDetailStr:@"" withReloadAction:^{
        
    }];
    
}


- (void)applyCliker:(UIButton *)sender {
    ApplyWhiteBarVC *apply = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"ApplyWhiteBarVC"];
    if (self.isReject) {
        apply.baitiaoID = self.baitiaoID;
    }
    [self.navigationController pushViewController:apply animated:YES];
}


- (void)getDataSource {
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setValue:[UserData currentUser].user_id forKey:@"userId"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dataDic imageArray:nil WithType:Interface_GetBaitiaoById andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
       
        NSArray *dataArr = resultDic[@"result"];
        if (dataArr.count) {
            
            NSDictionary *dataDic = [dataArr firstObject];
            self.baitiaoID = [dataDic[@"id"] stringValue];
            if ([dataDic[@"status"] isEqualToString:@"审核通过"]) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    WhiteBarVC *white = [[UIStoryboard storyboardWithName:@"Common" bundle:nil] instantiateViewControllerWithIdentifier:@"WhiteBarVC"];
                    [self addChildViewController:white];
                    [white didMoveToParentViewController:self];
                    [white.view setFrame:self.view.bounds];
                    [self.view addSubview:white.view];
                    
                    UIButton *recordBtn = [UIButton buttonWithTitle:@"还款记录" andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
                    recordBtn.frame = CGRectMake(0, 0, 70, 40);
                    [recordBtn addTarget:self action:@selector(payCliker:) forControlEvents:UIControlEventTouchUpInside];
                    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:recordBtn];
                });
                
            } else {
                
                [self setupSubviews:dataDic[@"status"]];
                
            }
            
        } else {
            //未申请
            [self setupSubviews:@"申请开通"];
        }
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
}

- (void)payCliker:(UIButton *)sender {
    
    TradeListViewController *list = [[TradeListViewController alloc] init];
    list.listType = ListType_huankuan;
    [self.navigationController pushViewController:list animated:YES];
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
