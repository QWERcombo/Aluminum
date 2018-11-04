//
//  MainViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/8.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "MainViewController.h"
#import "SelectedItem.h"
#import "MainItemViewController.h"
#import "SetOrderViewController.h"
#import "QuotationViewController.h"
#import "QuotationDetailViewController.h"
#import "MessageViewController.h"
#import "SpecialMakeViewController.h"
#import "InventoryViewController.h"

#import "DingZhiViewController.h"
#import "XunJiaViewController.h"
#import "ZiZhuXiaDanViewController.h"
#import "WholeBoardVC.h"
#import "ZeroCutVC.h"
#import "HomeListDetailVC.h"
#import "CommonItemVC.h"


@interface MainViewController ()
@property (nonatomic, assign) NSInteger pageNumber;
@end

@implementation MainViewController

#define Item_Margin  ((SCREEN_WIGHT-(48*4)-52)/3)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tabView removeFromSuperview];
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(self.view);
    }];
    self.pageNumber = 1;
    [self getDataSource:self.pageNumber];
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
//    PriceModel *model = [self.dataMuArr objectAtIndex:indexPath.row];
//    QuotationDetailViewController *detail = [QuotationDetailViewController new];
//    detail.title = model.name;
//    [self.navigationController pushViewController:detail animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *list = [HomeListDetailVC topPageVC];
    [self.navigationController pushViewController:list animated:YES];
}

#pragma mark ---- CreateSubViews
- (UIView *)createTopView {
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 311)];
    mainView.backgroundColor = [UIColor whiteColor];

    ABBannerView *bannerView = (ABBannerView *)[[UtilsMold sharedInstance] creatView:@"ABBannerView" data:nil model:@[IMG(@"Banner_0"),IMG(@"Banner_1"),IMG(@"Banner_2"),IMG(@"Banner_3")] deleGate:self andCliker:^(NSDictionary *clueDic) {
        
    }];
    
    [mainView addSubview:bannerView];
    
    
    UIView *blank = [[UIView alloc] initWithFrame:CGRectMake(0, 145, SCREEN_WIGHT, 166)];
    blank.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:blank];
    
    
    
    NSArray *nameArr = @[@"整板",@"零切",@"圆棒",@"型材",@"管材",@"特殊定制",@"自动下单",@"询价"];
    for (NSInteger i=0; i<2; i++) {
        for (NSInteger j=0; j<4; j++) {
            SelectedItem *item = [[SelectedItem alloc] initWithFrame:CGRectMake((Item_Margin+48)*j+26, ((66+19)*i), 48, 66)];
            item.item_name.text = [nameArr objectAtIndex:i*4+j];
            NSString *imageName = [NSString stringWithFormat:@"Main_item_%ld", (long)(i*4+j)];
            item.item_imgv.image = IMG(imageName);
            
            [item loadData:nil andCliker:^(NSString *clueStr) {
//                NSLog(@"%@", clueStr);
                NSString *name = [nameArr objectAtIndex:clueStr.integerValue];
                if ([name isEqualToString:@"自动下单"]) {
//                    SetOrderViewController *set = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SetOrder"];
//                    [self.navigationController pushViewController:set animated:YES];
                    ZiZhuXiaDanViewController *zizhu = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"ZiZhuXiaDanViewController"];
                    [self.navigationController pushViewController:zizhu animated:YES];
                } else if ([name isEqualToString:@"特殊定制"]) {
//                    SpecialMakeViewController *special = [SpecialMakeViewController new];
//                    [self.navigationController pushViewController:special animated:YES];
//                    [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"此项功能研发中..." time:0 aboutType:WHShowViewMode_Text state:NO];
                    DingZhiViewController *dingzhi = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"DingZhiViewController"];
                    [self.navigationController pushViewController:dingzhi animated:YES];
                    
                } else if ([name isEqualToString:@"询价"]) {
//                    MessageViewController *message = [MessageViewController new];
//                    [self.navigationController pushViewController:message animated:YES];
//                    [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"此项功能研发中..." time:0 aboutType:WHShowViewMode_Text state:NO];
                    XunJiaViewController *xunjia = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"XunJiaViewController"];
                    [self.navigationController pushViewController:xunjia animated:YES];
                    
                } else if ([name isEqualToString:@"整板"]) {
//                    InventoryViewController *inven = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"InventoryViewController"];
                    WholeBoardVC *inven = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"WholeBoardVC"];
                    [self.navigationController pushViewController:inven animated:YES];
                } else if ([name isEqualToString:@"零切"]) {
                    
                    ZeroCutVC *zero = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"ZeroCutVC"];
                    [self.navigationController pushViewController:zero animated:YES];
                }
                else if ([name isEqualToString:@"圆棒"]) {
                    
                    CommonItemVC *common = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"CommonItemVC"];
                    common.showType = ShowType_YuanBang;
                    [self.navigationController pushViewController:common animated:YES];
                }
                else if ([name isEqualToString:@"管材"]) {
                    
                    CommonItemVC *common = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"CommonItemVC"];
                    common.showType = ShowType_GuanCai;
                    [self.navigationController pushViewController:common animated:YES];
                } else if ([name isEqualToString:@"型材"]) {
                    
                    CommonItemVC *common = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"CommonItemVC"];
                    common.showType = ShowType_XingCai;
                    [self.navigationController pushViewController:common animated:YES];
                }
                else {
                    MainItemViewController *main_item = [[MainItemViewController alloc] init];
                    main_item.titleStr = name;
                    main_item.selectedNum = [clueStr integerValue]-1;
                    [self.navigationController pushViewController:main_item animated:YES];
                }
            }];
            [blank addSubview:item];
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
//    QuotationViewController *quo = [QuotationViewController new];
//    [self.navigationController pushViewController:quo animated:YES];
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

@end
