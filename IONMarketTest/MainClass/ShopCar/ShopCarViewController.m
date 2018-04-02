//
//  ShopCarViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/8.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "ShopCarViewController.h"
#import "ShopCarDetailViewController.h"

@interface ShopCarViewController ()

@property (nonatomic, assign) BOOL isDisplay;//是否展开

@property (nonatomic, assign) NSInteger refreshSection;//刷新的分区

@property (nonatomic, strong) NSMutableDictionary *sortDic;

@end

@implementation ShopCarViewController {
    UILabel *priceLabel;
    UILabel *infoLabel;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self getData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sortDic = [NSMutableDictionary dictionary];
    
    [self setupSubViews];
}

- (void)setupSubViews {
    self.tabView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tabView.delegate = self;
    self.tabView.dataSource = self;
    self.tabView.showsVerticalScrollIndicator = NO;
    self.tabView.showsHorizontalScrollIndicator = NO;
    self.tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tabView.backgroundColor = [UIColor mianColor:1];
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-50-50);
    }];
    
    
    [self createBottomView];
    
    self.tabView.ly_emptyView = [[PublicFuntionTool sharedInstance] getEmptyViewWithType:WHShowEmptyMode_noData withHintText:@"购物车还是空的 快去购买" andDetailStr:@"" withReloadAction:^{
        
    }];
}

- (void)createBottomView {
    UIView *bottomView = [[UIView alloc] init];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(50));
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
    }];
    
    UIButton *excuteButton = [UIButton buttonWithTitle:@"去结算" andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    excuteButton.backgroundColor = [UIColor mianColor:2];
    [excuteButton addTarget:self action:@selector(excuteAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:excuteButton];
    [excuteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(bottomView);
        make.width.equalTo(@(140));
    }];
    
    UIButton *allButton = [UIButton buttonWithTitle:@"全选" andFont:FONT_ArialMT(13) andtitleNormaColor:[UIColor Black_WordColor] andHighlightedTitle:[UIColor Black_WordColor] andNormaImage:nil andHighlightedImage:nil];
    [allButton setImage:IMG(@"select_0") forState:UIControlStateNormal];
    [allButton addTarget:self action:@selector(allButtonCliker:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:allButton];
    [allButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(50));
        make.height.equalTo(@(50));
        make.left.equalTo(bottomView.mas_left).offset(15);
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
    CGSize titleSize = allButton.titleLabel.bounds.size;
    CGSize imageSize = allButton.imageView.bounds.size;
    //button图片的偏移量
    allButton.imageEdgeInsets = UIEdgeInsetsMake(-((allButton.bounds.size.height-imageSize.height)/2),(allButton.bounds.size.width - imageSize.width)/2, titleSize.height, 0);
    //button文字的偏移量
    allButton.titleEdgeInsets = UIEdgeInsetsMake(imageSize.height+5, -((allButton.bounds.size.width-titleSize.width)/2), 0, 0);
    
    
    priceLabel = [UILabel lableWithText:@"￥4545.00元" Font:FONT_ArialMT(15) TextColor:[UIColor Black_WordColor]];
    [bottomView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(15));
        make.left.equalTo(allButton.mas_right).offset(10);
        make.right.equalTo(excuteButton.mas_left).offset(-20);
        make.top.equalTo(bottomView.mas_top).offset(10);
    }];
    infoLabel = [UILabel lableWithText:@"1254545.00kg" Font:FONT_ArialMT(13) TextColor:[UIColor Black_WordColor]];
    [bottomView addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(13));
        make.left.equalTo(allButton.mas_right).offset(10);
        make.right.equalTo(excuteButton.mas_left).offset(-20);
        make.top.equalTo(priceLabel.mas_bottom).offset(5);
    }];
}

#pragma mark --- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataMuArr.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold creatCell:@"OrderDetailCell" table:tableView deledate:self model:[self.dataMuArr objectAtIndex:indexPath.section] data:nil andCliker:^(NSDictionary *clueDic) {
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"OrderDetailCell" data:nil model:nil indexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self createDisplayHeader:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    ShopCarDetailViewController *detail = [[ShopCarDetailViewController alloc] init];
//    [self.navigationController pushViewController:detail animated:YES];
//}


#pragma mark ----- Action

- (void)moreAction:(UIButton *)sender {
    NSLog(@"more:----%ld", sender.tag);
    ShopCarDetailViewController *detail = [[ShopCarDetailViewController alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
}


//去结算
- (void)excuteAction:(UIButton *)sender {
    
    ShopCarDetailViewController *detail = [[ShopCarDetailViewController alloc] init];
    [self.navigationController pushViewController:detail animated:YES];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@[@"15",@"16"] forKey:@"gouwucheIds"];
    [dict setValue:@"40" forKey:@"addressId"];
    [dict setValue:[UserData currentUser].phone forKey:@"phone"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_SaveFromGouwuche andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"---%@", resultDic);
        
        
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}

- (void)selectButtonCliker:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setBackgroundImage:IMG(@"select_1") forState:UIControlStateSelected];
    } else {
        [sender setBackgroundImage:IMG(@"select_0") forState:UIControlStateSelected];
    }
    
}

- (void)allButtonCliker:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        [sender setImage:IMG(@"select_1") forState:UIControlStateSelected];
    } else {
        [sender setImage:IMG(@"select_0") forState:UIControlStateSelected];
    }
    
}



#pragma mark ----- Subviews
- (UIView *)createDisplayHeader:(NSInteger)section {
    UIView *blank = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 40)];
    blank.backgroundColor = [UIColor whiteColor];
    
    UIView *ccc = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIGHT, 30)];
    ccc.backgroundColor = [UIColor whiteColor];
    [blank addSubview:ccc];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 29.5, SCREEN_WIGHT, 0.5)];
    line.backgroundColor = [UIColor lightTextColor];
    [ccc addSubview:line];
    
    ShopCar *model = [self.dataMuArr objectAtIndex:section];
    UILabel *orderLabel = [UILabel lableWithText:model.type Font:FONT_ArialMT(15) TextColor:[UIColor mianColor:2]];
    [blank addSubview:orderLabel];
    [orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ccc);
        make.left.equalTo(ccc.mas_left).offset(40);
    }];
    
    UIButton *selectButton = [UIButton buttonWithTitle:nil andFont:nil andtitleNormaColor:nil andHighlightedTitle:nil andNormaImage:IMG(@"select_0") andHighlightedImage:nil];
    [blank addSubview:selectButton];
    selectButton.tag = 300+section;
    [selectButton addTarget:self action:@selector(selectButtonCliker:) forControlEvents:UIControlEventTouchUpInside];
    [selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(20));
        make.centerY.equalTo(orderLabel.mas_centerY);
        make.left.equalTo(blank.mas_left).offset(10);
    }];
    
    UIButton *moreButton = [UIButton buttonWithTitle:nil andFont:FONT_ArialMT(17) andtitleNormaColor:[UIColor mianColor:2] andHighlightedTitle:[UIColor mianColor:2] andNormaImage:nil andHighlightedImage:nil];
    moreButton.tag = 200+section;
    [moreButton setImage:IMG(@"image_more") forState:UIControlStateNormal];
    [moreButton addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    [blank addSubview:moreButton];
    [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(30));
        make.right.equalTo(ccc.mas_right).offset(-10);
        make.centerY.equalTo(ccc.mas_centerY);
    }];
    
    
    return blank;
}



- (void)getData {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[UserData currentUser].phone forKey:@"phone"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_GetGouwucheByUser andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
//        NSLog(@"++---%@", resultDic);
        NSArray *dataSource = resultDic[@"result"];
        
        for (NSDictionary *dic in dataSource) {
            
            ShopCar *model = [[ShopCar alloc] initWithDictionary:dic error:nil];
            
            [self.dataMuArr addObject:model];
        }
        
        [self.tabView reloadData];
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
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
