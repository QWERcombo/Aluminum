//
//  MainViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/8.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "MainViewController.h"
#import "MainItemViewController.h"
#import "MessageViewController.h"

#import "DingZhiViewController.h"
#import "XunJiaViewController.h"
#import "ZiZhuXiaDanViewController.h"
#import "WholeBoardVC.h"
#import "ZeroCutVC.h"
#import "HomeListDetailVC.h"
#import "CommonItemVC.h"
#import "DHGuidePageHUD.h"
#import "TaoLiaoVC.h"

@interface MainViewController ()
@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, strong) NSMutableArray *bannerArray;

@end

@implementation MainViewController

#define Item_Width      55
#define Item_Margin     ((SCREEN_WIGHT-(Item_Width*4)-30)/3)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.bannerArray = [NSMutableArray array];
    [self.tabView removeFromSuperview];
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.view);
    }];
    self.pageNumber = 1;
    [self getDataSource:self.pageNumber];
    
//    [self configurateGuideView];//配置引导页
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //强制更新
    [[PublicFuntionTool sharedInstance] checkUpdateNewVersion:^(NSArray *bannerArr) {
        if (self.bannerArray.count) {
            [self.bannerArray removeAllObjects];
        }
        [self.bannerArray addObjectsFromArray:bannerArr];
        [self.tabView reloadData];
    }];
}

#pragma mark --- Delegate&DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section==2?self.dataMuArr.count:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [UtilsMold creatCell:@"MainItemCell" table:tableView deledate:self model:[self.dataMuArr objectAtIndex:indexPath.row] data:nil andCliker:^(NSDictionary *clueDic) {
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [UtilsMold getCellHight:@"MainItemCell" data:nil model:nil indexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return [self createTopView];
    } else if (section==1) {
        return [self createSectionView];
    } else if (section==2) {
        return nil;
    } else {
        return [self createBottomView];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 311;
    } else if (section==1) {
        return 72;
    } else if (section==2) {
        return 0;
    } else {
        return 40;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 2) {
        
        UIViewController *list = [HomeListDetailVC topPageVC];
        [self.navigationController pushViewController:list animated:YES];
    }
}

#pragma mark ---- CreateSubViews
- (UIView *)createTopView {
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 311)];
    mainView.backgroundColor = [UIColor whiteColor];

//    @[IMG(@"Banner_0"),IMG(@"Banner_1")]
    ABBannerView *bannerView = (ABBannerView *)[[UtilsMold sharedInstance] creatView:@"ABBannerView" data:nil model:self.bannerArray deleGate:self andCliker:^(NSDictionary *clueDic) {
        
    }];
    
    [mainView addSubview:bannerView];
    
    
    UIView *blank = [[UIView alloc] initWithFrame:CGRectMake(0, 145, SCREEN_WIGHT, 166)];
    blank.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:blank];    
    
    NSArray *nameArr = @[@"整件",@"零切",@"半成品",@"淘小料",@"期货",@"圆棒",@"型材",@"询价"];
//    NSArray *nameArr = @[@"整板",@"零切",@"圆棒",@"型材",@"管材",@"特殊定制",@"自动下单",@"询价"];
    
    for (NSInteger i=0; i<2; i++) {
        for (NSInteger j=0; j<4; j++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake((Item_Margin+Item_Width)*j+15, ((66+19)*i), Item_Width, 66);
            
            NSString *imageName = [NSString stringWithFormat:@"Main_item_%ld", (long)(i*4+j)];
            [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:13];
            [button setTitleColor:[UIColor Black_WordColor] forState:UIControlStateNormal];
            [button setTitle:[nameArr objectAtIndex:(i*4+j)] forState:UIControlStateNormal];
            
            button.tag = 1000+(i*4+j);
            [button addTarget:self action:@selector(MainViewEnterClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [blank addSubview:button];
            [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:3];
        }
    }
    
    return mainView;
}

- (UIView *)createSectionView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 72)];
    headerView.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    
    UIView *midView = [[UIView alloc] initWithFrame:CGRectMake(0, 8, SCREEN_WIGHT, 40)];
    midView.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:midView];
    
    UILabel *leftlabel = [UILabel lableWithText:@"自选关注" Font:FONT_ArialMT(14) TextColor:[UIColor Black_WordColor]];
    [midView addSubview:leftlabel];
    [leftlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(midView.mas_centerY);
        make.left.equalTo(midView.mas_left).offset(15);
    }];
    
    UIButton *rightlabel = [UIButton buttonWithTitle:@"全部" andFont:FONT_ArialMT(14) andtitleNormaColor:[UIColor Black_WordColor] andHighlightedTitle:[UIColor Black_WordColor] andNormaImage:nil andHighlightedImage:nil];
    [rightlabel setImage:IMG(@"image_more") forState:UIControlStateNormal];
    
    [rightlabel addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    [midView addSubview:rightlabel];
    [rightlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(midView.mas_centerY);
        make.right.equalTo(midView.mas_right).offset(-15);
    }];
    
    rightlabel.titleEdgeInsets = UIEdgeInsetsMake(0, -rightlabel.imageView.width, 0, rightlabel.imageView.width);
    rightlabel.imageEdgeInsets = UIEdgeInsetsMake(0, rightlabel.titleLabel.width, 0, -rightlabel.titleLabel.width-5);
    
    
    UILabel *hangqing = [UILabel lableWithText:@"行情" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
    [headerView addSubview:hangqing];
    [hangqing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView.mas_left).offset(15);
        make.top.equalTo(midView.mas_bottom).offset(6);
    }];
    
    UILabel *zhangdie = [UILabel lableWithText:@"涨跌" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
    zhangdie.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:zhangdie];
    [zhangdie mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headerView.mas_right).offset(0);
        make.top.equalTo(midView.mas_bottom).offset(6);
        make.width.equalTo(@(headerView.width/4));
    }];
    
    UILabel *zuixin = [UILabel lableWithText:@"最新" Font:FONT_ArialMT(12) TextColor:[UIColor Grey_WordColor]];
    [headerView addSubview:zuixin];
    zuixin.textAlignment = NSTextAlignmentCenter;
    [zuixin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(zhangdie.mas_left).offset(0);
        make.top.equalTo(midView.mas_bottom).offset(6);
        make.width.equalTo(@(headerView.width/4));
    }];
    
    return headerView;
}

- (UIView *)createBottomView {
    
    UIView *blank = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 40)];
    blank.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    
    UIImageView *imgv = [[UIImageView alloc] init];
    imgv.image = IMG(@"main_bottom");
    [blank addSubview:imgv];
    [imgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(blank.mas_centerY);
        make.centerX.equalTo(blank.mas_centerX);
    }];
    
    
    return blank;
}


#pragma mark ---- Action

- (void)moreAction:(UIButton *)sender {
    UIViewController *list = [HomeListDetailVC topPageVC];
    [self.navigationController pushViewController:list animated:YES];
}

#pragma mark ----- DataSource
- (void)getDataSource:(NSInteger)pageNumber {
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:nil imageArray:nil WithType:Interface_getLastestPrice andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        
        NSArray *dataArr = resultDic[@"result"];
        
        for (NSDictionary *dict in dataArr) {
            
            PriceModel *model = [[PriceModel alloc] initWithDictionary:dict error:nil];
            
            [self.dataMuArr addObject:model];
        }
        
        [self.tabView reloadData];
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}

- (NSString *)getTodayDateString {
    
    NSDate *todayDate = [NSDate date];
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyyy-MM-dd";
    
    return [formatter stringFromDate:todayDate];
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
- (void)configurateGuideView {
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:BOOLFORKEY]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:BOOLFORKEY];
        // 在这里写初始化图片数组和DHGuidePageHUD库引导页的代码
        // 静态引导图片数组初始化
        NSArray *imageNameArray = @[@"guideImage1",@"guideImage2",@"guideImage3"];
        DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:MY_WINDOW.frame imageNameArray:imageNameArray buttonIsHidden:YES];
        
        [MY_WINDOW addSubview:guidePage];
    }
    
}

- (void)MainViewEnterClick:(UIButton *)sender {
//    NSArray *nameArr = @[@"整件",@"零切",@"半成品",@"淘小料",@"期货",@"圆棒",@"型材",@"询价"];
    if (sender.tag == 1000) {
        //整件
        WholeBoardVC *inven = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"WholeBoardVC"];
        inven.showTye = WholeBoardShowType_Zhengban;
        [self.navigationController pushViewController:inven animated:YES];
    }
    else if (sender.tag == 1001) {
        //零切
        ZeroCutVC *zero = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"ZeroCutVC"];
        [self.navigationController pushViewController:zero animated:YES];
    }
    else if (sender.tag == 1002) {
        //半成品
        WholeBoardVC *inven = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"WholeBoardVC"];
        inven.showTye = WholeBoardShowType_BanChengPin;
        [self.navigationController pushViewController:inven animated:YES];
    }
    else if (sender.tag == 1003) {
        //淘小料
        TaoLiaoVC *taoliao = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"TaoLiaoVC"];
        [self.navigationController pushViewController:taoliao animated:YES];
        
    } else if (sender.tag == 1004) {
        //期货
        WholeBoardVC *inven = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"WholeBoardVC"];
        inven.showTye = WholeBoardShowType_YueBao;
        [self.navigationController pushViewController:inven animated:YES];
    }
    else if (sender.tag == 1005) {
        //切圆棒
        CommonItemVC *common = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"CommonItemVC"];
        common.showType = ShowType_YuanBang;
        [self.navigationController pushViewController:common animated:YES];
    } else if (sender.tag == 1006) {
        //切型材
        CommonItemVC *common = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"CommonItemVC"];
        common.showType = ShowType_XingCai;
        [self.navigationController pushViewController:common animated:YES];
    }
//    else if (sender.tag == 1004) {
//        //切型材
//        CommonItemVC *common = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"CommonItemVC"];
//        common.showType = ShowType_GuanCai;
//        [self.navigationController pushViewController:common animated:YES];
//    }
//    else if (sender.tag == 1007) {
//        //特殊定制
//        DingZhiViewController *dingzhi = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"DingZhiViewController"];
//        [self.navigationController pushViewController:dingzhi animated:YES];
//    } else if (sender.tag == 1008) {
//        //自助下单
//        ZiZhuXiaDanViewController *zizhu = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"ZiZhuXiaDanViewController"];
//        [self.navigationController pushViewController:zizhu animated:YES];
//    }
        else if (sender.tag == 1007) {
        //询价
        XunJiaViewController *xunjia = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"XunJiaViewController"];
        [self.navigationController pushViewController:xunjia animated:YES];
    } else {
    }
    
}



@end
