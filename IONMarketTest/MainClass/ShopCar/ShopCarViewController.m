//
//  ShopCarViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/8.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "ShopCarViewController.h"

@interface ShopCarViewController ()

@property (nonatomic, assign) BOOL isDisplay;//是否展开

@property (nonatomic, assign) NSInteger refreshSection;//刷新的分区

@property (nonatomic, strong) NSMutableDictionary *sortDic;

@end

@implementation ShopCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.sortDic = [NSMutableDictionary dictionary];
    [self.sortDic setValue:@[@"1",@"2",@"3",@"4",@"5"] forKey:@"1"];
    [self.sortDic setValue:@[@"1",@"2",@"3",@"4",@"5"] forKey:@"2"];
    [self.sortDic setValue:@[@"1",@"2",@"3",@"4",@"5"] forKey:@"3"];
    self.dataMuArr = [self.sortDic allKeys];
    
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
    self.tabView.ly_emptyView = [[PublicFuntionTool sharedInstance] getEmptyViewWithType:WHShowEmptyMode_noData withReloadAction:^{
        
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
    
}

#pragma mark --- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataMuArr.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.sortDic[[self.dataMuArr objectAtIndex:section]];
    if (self.isDisplay) {
        return arr.count;
    } else {
        return 3;
    }
//    if (section==self.refreshSection) {
//        if (self.isDisplay) {
//            return 5;
//        } else {
//            return 3;
//        }
//    } else {
//        return 3;
//    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold creatCell:@"OrderDetailCell" table:tableView deledate:self model:nil data:nil andCliker:^(NSDictionary *clueDic) {
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"OrderDetailCell" data:nil model:nil indexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [self createDisplayHeader:section];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self createDisplayFooter:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


#pragma mark ----- Action
- (void)displayAction:(UIButton *)sender {
//    NSLog(@"display:----%ld", sender.tag);
//    self.refreshSection = sender.tag-100;
//    self.isDisplay = !self.isDisplay;
//    NSIndexSet *set = [[NSIndexSet alloc] initWithIndex:sender.tag-100];
//    [self.tabView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)moreAction:(UIButton *)sender {
    NSLog(@"more:----%ld", sender.tag);
    
    
}

- (void)excuteAction:(UIButton *)sender {
    NSLog(@"%@", sender.currentTitle);
    
    
}

#pragma mark ----- Subviews
- (UIView *)createDisplayFooter:(NSInteger)section {
    UIView *vvv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 40)];
    vvv.backgroundColor = [UIColor whiteColor];
    
    UIButton *displayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    displayButton.tag = 100+section;
    [displayButton setTitle:@"展开" forState:UIControlStateNormal];
    [displayButton setImage:IMG(@"display_0") forState:UIControlStateNormal];
    
    if (self.refreshSection == section) {
        if (self.isDisplay) {
            [displayButton setTitle:@"收起" forState:UIControlStateNormal];
            [displayButton setImage:IMG(@"display_1") forState:UIControlStateNormal];
        }
    }
    [displayButton setTitleColor:[UIColor Black_WordColor] forState:UIControlStateNormal];
    displayButton.titleLabel.font = FONT_ArialMT(15);
//    displayButton.imageEdgeInsets = UIEdgeInsetsMake(5, 40, 5, 10);
    [displayButton addTarget:self action:@selector(displayAction:) forControlEvents:UIControlEventTouchUpInside];
    [vvv addSubview:displayButton];
    [displayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(vvv);
        make.width.equalTo(@(100));
        make.height.equalTo(@(30));
    }];
    
    
    return vvv;
}


- (UIView *)createDisplayHeader:(NSInteger)section {
    UIView *blank = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 40)];
    blank.backgroundColor = [UIColor mianColor:1];
    
    UIView *ccc = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIGHT, 30)];
    ccc.backgroundColor = [UIColor mianColor:3];
    [blank addSubview:ccc];
    
    
    UILabel *orderLabel = [UILabel lableWithText:@"订单编号:123424242" Font:FONT_ArialMT(15) TextColor:[UIColor mianColor:2]];
    [blank addSubview:orderLabel];
    [orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ccc);
        make.left.equalTo(ccc.mas_left).offset(50);
    }];
    
    UIButton *moreButton = [UIButton buttonWithTitle:@">" andFont:FONT_ArialMT(17) andtitleNormaColor:[UIColor mianColor:2] andHighlightedTitle:[UIColor mianColor:2] andNormaImage:nil andHighlightedImage:nil];
    moreButton.tag = 200+section;
    [moreButton addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    [blank addSubview:moreButton];
    [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(30));
        make.right.equalTo(ccc.mas_right).offset(-20);
        make.centerY.equalTo(ccc.mas_centerY);
    }];
    
    
    return blank;
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
