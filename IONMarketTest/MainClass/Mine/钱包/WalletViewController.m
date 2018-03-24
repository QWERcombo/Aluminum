//
//  WalletViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/14.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "WalletViewController.h"
#import "TradeListViewController.h"
#import "RemainExplainViewController.h"
#import "InputViewController.h"

@interface WalletViewController ()

@end

@implementation WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubviews];
}

- (void)setupSubviews {
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
    }];
    
//    __weak typeof(self) weakself = self;
    self.tabView.ly_emptyView = [[PublicFuntionTool sharedInstance] getEmptyViewWithType:WHShowEmptyMode_noData withHintText:@"暂无交易明细" andDetailStr:@"" withReloadAction:^{
        
    }];
    
    [self createBottomView];
}

- (void)createBottomView {
    UIView *bottomView = [[UIView alloc] init];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(50));
    }];
    
    UIButton *output = [UIButton buttonWithTitle:@"转出" andFont:FONT_ArialMT(18) andtitleNormaColor:[UIColor mianColor:2] andHighlightedTitle:[UIColor mianColor:2] andNormaImage:nil andHighlightedImage:nil];
    [output addTarget:self action:@selector(outputCliker:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:output];
    [output mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(bottomView);
        make.width.equalTo(@(SCREEN_WIGHT/2));
    }];
    
    UIButton *input = [UIButton buttonWithTitle:@"转入" andFont:FONT_ArialMT(18) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    input.backgroundColor = [UIColor mianColor:2];
    [input addTarget:self action:@selector(inputCliker:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:input];
    [input mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(bottomView);
        make.width.equalTo(@(SCREEN_WIGHT/2));
    }];
}


#pragma mark ----- UITableViewDelegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section==1?10:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold creatCell:@"WallentListCell" table:tableView deledate:self model:nil data:nil andCliker:^(NSDictionary *clueDic) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"WallentListCell" data:nil model:nil indexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return section==0?[self createMainSectionView]:nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section==0?180:0;
}

#pragma mark ----- Subviews
- (UIView *)createMainSectionView {
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 180)];
    mainView.backgroundColor = [UIColor mianColor:2];
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor clearColor];
    topView.layer.cornerRadius = 10;
    topView.layer.masksToBounds = YES;
    [mainView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainView.mas_left).offset(10);
        make.top.equalTo(mainView.mas_top).offset(10);
        make.right.equalTo(mainView.mas_right).offset(-10);
        make.bottom.equalTo(mainView.mas_bottom).offset(-50);
    }];
    UIImageView *image_bg = [[UIImageView alloc] init];
    image_bg.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    image_bg.image = IMG(@"Mine_wallent_bg");
    [topView addSubview:image_bg];
    [image_bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.top.equalTo(topView);
    }];
    
    
    UILabel *hint = [UILabel lableWithText:@"当前余额" Font:FONT_ArialMT(15) TextColor:[UIColor mianColor:3]];
    [topView addSubview:hint];
    [hint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_top).offset(10);
        make.left.equalTo(topView.mas_left).offset(10);
    }];
    
    UIButton *termButton = [UIButton buttonWithTitle:@"余额说明" andFont:FONT_ArialMT(13) andtitleNormaColor:[UIColor mianColor:3] andHighlightedTitle:[UIColor mianColor:3] andNormaImage:nil andHighlightedImage:nil];
    [termButton setImage:IMG(@"Mine_term") forState:UIControlStateNormal];
    [termButton addTarget:self action:@selector(termButtonCliker:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:termButton];
    [termButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(hint.mas_centerY);
        make.right.equalTo(topView.mas_right).offset(-10);
    }];
    termButton.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
    
    UILabel *remainLab = [UILabel lableWithText:@"564.25 元" Font:FONT_ArialMT(25) TextColor:[UIColor mianColor:2]];
    [topView addSubview:remainLab];
    [remainLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topView.mas_centerY).offset(15);
        make.centerX.equalTo(topView.mas_centerX);
    }];
    
    
    
    //------------------------------------------------------------
    UIView *downView = [[UIView alloc] init];
    downView.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:downView];
    [downView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(40));
        make.left.bottom.right.equalTo(mainView);
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor lightGrayColor];
    [downView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(1));
        make.left.right.bottom.equalTo(downView);
    }];
    
    UILabel *label3 = [UILabel lableWithText:@"交易明细" Font:FONT_ArialMT(17) TextColor:[UIColor mianColor:3]];
    [downView addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(downView.mas_centerY);
        make.left.equalTo(downView.mas_left).offset(10);
    }];
    
    UIButton *paywayButton = [UIButton buttonWithTitle:@"查看全部" andFont:FONT_ArialMT(17) andtitleNormaColor:[UIColor mianColor:3] andHighlightedTitle:[UIColor mianColor:3] andNormaImage:nil andHighlightedImage:nil];
    [paywayButton setImage:IMG(@"image_more") forState:UIControlStateNormal];
    [paywayButton addTarget:self action:@selector(payCliker:) forControlEvents:UIControlEventTouchUpInside];
    [downView addSubview:paywayButton];
    [paywayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(downView.mas_centerY);
        make.right.equalTo(downView.mas_right).offset(-10);
    }];
    paywayButton.titleEdgeInsets = UIEdgeInsetsMake(0, -paywayButton.imageView.bounds.size.width, 0, paywayButton.imageView.bounds.size.width);
    paywayButton.imageEdgeInsets = UIEdgeInsetsMake(0, paywayButton.titleLabel.bounds.size.width, 0, -paywayButton.titleLabel.bounds.size.width);
    
    
    
    return mainView;
}


#pragma mark ----- Action
- (void)inputCliker:(UIButton *)sender {
    InputViewController *input = [InputViewController new];
    input.mode_way = Mode_Input;
    [self.navigationController pushViewController:input animated:YES];
}
- (void)outputCliker:(UIButton *)sender {
    InputViewController *input = [InputViewController new];
    input.mode_way = Mode_Output;
    [self.navigationController pushViewController:input animated:YES];
}

- (void)payCliker:(UIButton *)sender {
    TradeListViewController *list = [[TradeListViewController alloc] init];
    [self.navigationController pushViewController:list animated:YES];
}

- (void)termButtonCliker:(UIButton *)sender {
    NSLog(@"%@", sender.currentTitle);
    RemainExplainViewController *explain = [[RemainExplainViewController alloc] init];
    [self.navigationController pushViewController:explain animated:YES];
    
}

#pragma mark ----- DataSource

- (void)getDataSource {
    
    
    
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
