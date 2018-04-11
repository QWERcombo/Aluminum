//
//  WholeBoardViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/19.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "WholeBoardViewController.h"
#import "MainItemView__WholeBoard.h"

#define CAR_Color  [UIColor colorWithR:97 G:177 B:225 A:1]
@interface WholeBoardViewController ()

@end

@implementation WholeBoardViewController {
    UIButton *radiusButton;
    UILabel *priceLabel;
    UILabel *infoLabel;
    UIView *bottomView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"下单";
    [self createScrollLayoutView];
    [self createBottomView];
}

- (void)createScrollLayoutView {
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, SCREEN_HEIGHT-50)];
    [self.view addSubview:scrollView];
    
    MainItemView__WholeBoard *single = [[MainItemView__WholeBoard alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, SCREEN_HEIGHT)];
    [single loadData:nil andCliker:^(NSString *clueStr) {
        
    }];
    
    [scrollView setContentSize:CGSizeMake(SCREEN_WIGHT, SCREEN_HEIGHT)];
    [scrollView addSubview:single];
//    [self.view addSubview:single];
}



- (void)createBottomView {
    bottomView = [[UIView alloc] init];
    [self.view addSubview:bottomView];
    bottomView.backgroundColor = [UIColor whiteColor];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(50));
        make.bottom.left.right.equalTo(self.view);
    }];
    
    
    UIButton *buyButton = [UIButton buttonWithTitle:@"立即购买" andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:IMG(@"Main_buy") andHighlightedImage:IMG(@"Main_buy")];
    [buyButton addTarget:self action:@selector(buyAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:buyButton];
    [buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(bottomView);
        make.width.equalTo(@(100));
    }];
    UIButton *carButton = [UIButton buttonWithTitle:@"加入购物车" andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:IMG(@"Main_shop_car") andHighlightedImage:IMG(@"Main_shop_car")];
    [carButton addTarget:self action:@selector(carAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:carButton];
    [carButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(bottomView);
        make.width.equalTo(@(100));
        make.right.equalTo(buyButton.mas_left);
    }];
    
    radiusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    radiusButton.backgroundColor = CAR_Color;
    radiusButton.layer.cornerRadius = 25;
    radiusButton.layer.masksToBounds = YES;
    [bottomView addSubview:radiusButton];
    [radiusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(50));
        make.left.equalTo(bottomView.mas_left).offset(5);
        make.bottom.equalTo(bottomView.mas_bottom).offset(-20);
    }];
    radiusButton.badgeValue = @"21";
    radiusButton.badgeFont = FONT_ArialMT(13);
    radiusButton.badgeBGColor = [UIColor mianColor:2];
    radiusButton.badgeOriginX = 35;
    
    priceLabel = [UILabel lableWithText:@"￥7676.00" Font:FONT_ArialMT(15) TextColor:[UIColor mianColor:2]];
    [bottomView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(radiusButton.mas_right).offset(10);
        make.top.equalTo(bottomView.mas_top).offset(10);
    }];
    infoLabel = [UILabel lableWithText:@"76766kg" Font:FONT_ArialMT(13) TextColor:[UIColor mianColor:2]];
    [bottomView addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(priceLabel.mas_left);
        make.top.equalTo(priceLabel.mas_bottom);
    }];
    
    
}


- (void)buyAction:(UIButton *)sender {
    NSLog(@"%@", sender.currentTitle);
    
}

- (void)carAction:(UIButton *)sender {
    NSLog(@"%@", sender.currentTitle);
    
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
