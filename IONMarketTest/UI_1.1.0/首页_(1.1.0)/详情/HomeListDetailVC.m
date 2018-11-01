//
//  HomeListDetailVC.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/10/27.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "HomeListDetailVC.h"
#import "SubMarketVC.h"


@interface HomeListDetailVC ()<YNPageViewControllerDelegate, YNPageViewControllerDataSource>

@end

@implementation HomeListDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"行情";

}


+ (instancetype)topPageVC {
    
    YNPageConfigration *configration = [YNPageConfigration defaultConfig];
    configration.pageStyle = YNPageStyleTop;
    configration.headerViewCouldScale = YES;
    configration.headerViewScaleMode = YNPageHeaderViewScaleModeTop;
    configration.showTabbar = NO;
    configration.showNavigation = YES;
    configration.scrollMenu = NO;
    configration.aligmentModeCenter = NO;
    configration.lineWidthEqualFontWidth = YES;
    configration.showBottomLine = NO;
    
    configration.lineColor = [UIColor mianColor:2];
    configration.normalItemColor = [UIColor Grey_WordColor];
    configration.selectedItemColor = [UIColor mianColor:2];
    
    
    HomeListDetailVC *vc = [HomeListDetailVC pageViewControllerWithControllers:[self getArrayVCs]
                                                              titles:[self getArrayTitles]
                                                              config:configration];
    vc.dataSource = vc;
    vc.delegate = vc;
    
    
    return vc;
}


+ (NSArray *)getArrayVCs {
    
    NSArray *array = @[@"长江有色",@"上海现货",@"南海灵通",@"LME伦敦"];
    SubMarketVC *vc_1 = [[SubMarketVC alloc] init];
    vc_1.title = array[0];
    SubMarketVC *vc_2 = [[SubMarketVC alloc] init];
    vc_2.title = array[1];
    SubMarketVC *vc_3 = [[SubMarketVC alloc] init];
    vc_3.title = array[2];
    SubMarketVC *vc_4 = [[SubMarketVC alloc] init];
    vc_4.title = array[3];
    
    return @[vc_1, vc_2, vc_3, vc_4];
}

+ (NSArray *)getArrayTitles {
    return @[@"长江有色",@"上海现货",@"南海灵通",@"LME伦敦"];
}

#pragma mark - YNPageViewControllerDataSource
- (UIScrollView *)pageViewController:(YNPageViewController *)pageViewController pageForIndex:(NSInteger)index {
    SubMarketVC *baseVC = pageViewController.controllersM[index];
    return [baseVC tableView];
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
