//
//  MainViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/8.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "MainViewController.h"
#import "SelectedItem.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MainViewController

#define Item_Margin  ((SCREEN_WIGHT-40*4)/5)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


#pragma mark --- Delegate&DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section==0?0:10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold creatCell:@"MainItemCell" table:tableView deledate:self model:nil data:nil andCliker:^(NSDictionary *clueDic) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"MainItemCell" data:nil model:nil indexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return section==0?[self createTopView]:[self createSectionView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section==0?340:40;
}

#pragma mark ---- CreateSubViews
- (UIView *)createTopView {
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 340)];
    mainView.backgroundColor = [UIColor whiteColor];
    ABBannerView *bannerView = (ABBannerView *)[[UtilsMold sharedInstance] creatView:@"ABBannerView" data:nil model:@[[UIImage imageWithColor:[UIColor purpleColor]],[UIImage imageWithColor:[UIColor mianColor:2]]] deleGate:self andCliker:^(NSDictionary *clueDic) {
        
    }];
    bannerView.frame = CGRectMake(0, 0, SCREEN_WIGHT, 140);
    [mainView addSubview:bannerView];
    
    NSArray *nameArr = @[@"整板",@"零切",@"圆棒",@"型材",@"管材",@"特殊定制",@"自动下单",@"询价"];
    for (NSInteger i=0; i<2; i++) {
        for (NSInteger j=0; j<4; j++) {
            SelectedItem *item = [[SelectedItem alloc] initWithFrame:CGRectMake((Item_Margin+40)*j+Item_Margin, ((65+(70/3))*i)+140+35, 40, 65)];
            item.item_name.text = [nameArr objectAtIndex:i*4+j];
            [item loadData:nil andCliker:^(NSString *clueStr) {
                NSLog(@"---%@", [nameArr objectAtIndex:clueStr.integerValue]);
            }];
            [mainView addSubview:item];
        }
    }
    
    
    return mainView;
}

- (UIView *)createSectionView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 40)];
    UILabel *leftlabel = [UILabel lableWithText:@"自选关注" Font:FONT_ArialMT(15) TextColor:[UIColor mianColor:2]];
    [headerView addSubview:leftlabel];
    [leftlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView.mas_centerY);
        make.left.equalTo(headerView.mas_left).offset(15);
        make.height.equalTo(@(15));
    }];
    
    UIButton *rightlabel = [UIButton buttonWithTitle:@"查看全部 >" andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor mianColor:2] andHighlightedTitle:[UIColor mianColor:2] andNormaImage:nil andHighlightedImage:nil];
    [rightlabel addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:rightlabel];
    [rightlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(15));
        make.centerY.equalTo(headerView.mas_centerY);
        make.right.equalTo(headerView.mas_right).offset(-15);
    }];
    
    
    return headerView;
}

#pragma mark ---- Action

- (IBAction)GoIntoMessage:(UIBarButtonItem *)sender {
    NSLog(@"message");
}

- (void)moreAction:(UIButton *)sender {
    NSLog(@"查看更多");
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
