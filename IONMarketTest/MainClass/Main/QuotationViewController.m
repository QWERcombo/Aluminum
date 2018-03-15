//
//  QuotationViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/15.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "QuotationViewController.h"
#import "QuotationDetailViewController.h"

@interface QuotationViewController ()

@end

@implementation QuotationViewController {
    UIView *line_f;
    UIView *line_a;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"行情";
    [self setupSubviews];
    
}

- (void)setupSubviews {
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(60+64);
    }];
    self.view.backgroundColor = [UIColor mianColor:1];
    self.tabView.backgroundColor = [UIColor mianColor:1];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIGHT, 50)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    UIButton *favoriteBtn = [UIButton buttonWithTitle:@"关注行情" andFont:FONT_ArialMT(17) andtitleNormaColor:[UIColor mianColor:2] andHighlightedTitle:[UIColor mianColor:2] andNormaImage:nil andHighlightedImage:nil];
    [topView addSubview:favoriteBtn];
    [favoriteBtn addTarget:self action:@selector(buttonCliker:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:favoriteBtn];
    [favoriteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(17));
        make.left.equalTo(topView.mas_left).offset(60);
        make.centerY.equalTo(topView.mas_centerY);
    }];
    line_f = [UIView new];
    [topView addSubview:line_f];
    line_f.backgroundColor = [UIColor mianColor:2];
    line_f.hidden = NO;
    [line_f mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(3));
        make.left.right.equalTo(favoriteBtn);
        make.centerX.equalTo(favoriteBtn.mas_centerX);
        make.top.equalTo(favoriteBtn.mas_bottom).offset(5);
    }];
    
    UIButton *allBtn = [UIButton buttonWithTitle:@"所有行情" andFont:FONT_ArialMT(17) andtitleNormaColor:[UIColor mianColor:2] andHighlightedTitle:[UIColor mianColor:2] andNormaImage:nil andHighlightedImage:nil];
    [topView addSubview:allBtn];
    [allBtn addTarget:self action:@selector(buttonCliker:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:allBtn];
    [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(17));
        make.right.equalTo(topView.mas_right).offset(-60);
        make.centerY.equalTo(topView.mas_centerY);
    }];
    line_a = [UIView new];
    [topView addSubview:line_a];
    line_a.backgroundColor = [UIColor mianColor:2];
    line_a.hidden = YES;
    [line_a mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(3));
        make.left.right.equalTo(allBtn);
        make.centerX.equalTo(allBtn.mas_centerX);
        make.top.equalTo(favoriteBtn.mas_bottom).offset(5);
    }];
    
    self.tabView.ly_emptyView = [[PublicFuntionTool sharedInstance] getEmptyViewWithType:WHShowEmptyMode_noData withReloadAction:^{
        
    }];
    
}

#pragma mark ----delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold creatCell:@"MainItemCell" table:tableView deledate:self model:nil data:nil andCliker:^(NSDictionary *clueDic) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"MainItemCell" data:nil model:nil indexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QuotationDetailViewController *detail = [QuotationDetailViewController new];
    [self.navigationController pushViewController:detail animated:YES];
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 添加一个删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"取消关注"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了取消关注");
    }];
    // 删除一个置顶按钮
    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"置顶"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了置顶");
    }];
    topRowAction.backgroundColor = [UIColor blueColor];
    
    // 添加一个更多按钮
    UITableViewRowAction *moreRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"拖动"handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了拖动");
        
        
    }];
    moreRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    // 将设置好的按钮放到数组中返回
    return @[deleteRowAction, topRowAction, moreRowAction];
    
}



#pragma mark ---- action
- (void)buttonCliker:(UIButton *)sender {
    if ([sender.currentTitle isEqualToString:@"关注行情"]) {
        line_f.hidden = NO;
        line_a.hidden = YES;
    } else {
        line_f.hidden = YES;
        line_a.hidden = NO;
    }
    
    
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
