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
@property (nonatomic, strong) NSMutableArray *selectArr; //选中的数据
@property (nonatomic, assign) CGFloat totoal; //选中的总价
@end

@implementation ShopCarViewController {
    UILabel *priceLabel;
    UILabel *infoLabel;
    UIButton *allButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.selectArr = [NSMutableArray array];
    [self getData];
    [self setupSubViews];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"RefreshNewData" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getData) name:@"RefreshNewData" object:nil];
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
    
    allButton = [UIButton buttonWithTitle:@"全选" andFont:FONT_ArialMT(13) andtitleNormaColor:[UIColor Black_WordColor] andHighlightedTitle:[UIColor Black_WordColor] andNormaImage:nil andHighlightedImage:nil];
    [allButton setImage:IMG(@"select_0") forState:UIControlStateNormal];
    [allButton setImage:IMG(@"select_1") forState:UIControlStateSelected];
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
    
    
    priceLabel = [UILabel lableWithText:@"￥0.00元" Font:FONT_ArialMT(15) TextColor:[UIColor Black_WordColor]];
    [bottomView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(15));
        make.left.equalTo(allButton.mas_right).offset(10);
        make.right.equalTo(excuteButton.mas_left).offset(-20);
        make.top.equalTo(bottomView.mas_top).offset(10);
    }];
    infoLabel = [UILabel lableWithText:@"0.00kg" Font:FONT_ArialMT(13) TextColor:[UIColor Black_WordColor]];
    [bottomView addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(13));
        make.left.equalTo(allButton.mas_right).offset(10);
        make.right.equalTo(excuteButton.mas_left).offset(-20);
        make.top.equalTo(priceLabel.mas_bottom).offset(5);
    }];
}

#pragma mark --- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataMuArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakself = self;
    return [UtilsMold creatCell:@"ShopCarListCell" table:tableView deledate:self model:[self.dataMuArr objectAtIndex:indexPath.row] data:nil andCliker:^(NSDictionary *clueDic) {
        if ([clueDic[@"key"] isEqualToString:@"1"]) {
            [weakself.selectArr addObject:[weakself.dataMuArr objectAtIndex:indexPath.row]];
        } else if ([clueDic[@"key"] isEqualToString:@"-1"]) {
            [weakself.selectArr removeObject:[weakself.dataMuArr objectAtIndex:indexPath.row]];
        } else {
            
        }
        
        weakself.totoal = 0.f;
        if (self.selectArr.count) {
            allButton.selected = YES;
            for (ShopCar *car in weakself.selectArr) {
                weakself.totoal += [car.money floatValue];
            }
            priceLabel.text = [NSString stringWithFormat:@"%.2lf元", weakself.totoal];
        } else {
            allButton.selected = NO;
            priceLabel.text = @"0.00元";
        }
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"ShopCarListCell" data:nil model:nil indexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}


#pragma mark ----- Action

- (void)moreAction:(UIButton *)sender {
//    NSLog(@"more:----%ld", (long)sender.tag);
//    ShopCarDetailViewController *detail = [[ShopCarDetailViewController alloc] init];
//    [self.navigationController pushViewController:detail animated:YES];
}


//去结算
- (void)excuteAction:(UIButton *)sender {
    
    ShopCarDetailViewController *detail = [[ShopCarDetailViewController alloc] init];
    detail.shopCarArr = self.selectArr;
    if (!detail.shopCarArr.count) {
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请先选择要结算的订单！" time:0 aboutType:WHShowViewMode_Text state:NO];
        return;
    }
    [self.navigationController pushViewController:detail animated:YES];
        
}

- (void)allButtonCliker:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        CGFloat totoal = 0;
        for (ShopCar *car in self.dataMuArr) {
            car.isSelectedCard = YES;
            totoal += [car.money floatValue];
        }
        [self.selectArr addObjectsFromArray:self.dataMuArr];
        priceLabel.text = [NSString stringWithFormat:@"%.2lf元", totoal];  //更新价格
    } else {
        for (ShopCar *car in self.dataMuArr) {
            car.isSelectedCard = NO;
        }
        [self.selectArr removeAllObjects];
        priceLabel.text = @"0.00元";
    }
    [self.tabView reloadData];
}


- (void)getData {
    allButton.selected = NO;
    [self.dataMuArr removeAllObjects];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:[UserData currentUser].phone forKey:@"phone"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_GetGouwucheByUser andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"++---%@", resultDic);
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
