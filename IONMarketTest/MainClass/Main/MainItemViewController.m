//
//  MainItemViewController.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/12.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "MainItemViewController.h"
#import "SpecialMakeViewController.h"
#import "MainItem__Single.h"//零切
#import "MainItemView__Pole.h"//圆棒
#import "MainItemView__Tube.h"//型材
#import "MainItemView__Matter.h"//管材

@interface MainItemViewController ()

@property (nonatomic, assign) NSInteger lastSelected;

@property (nonatomic, assign) NSInteger lastTypeSelected;

@property (nonatomic, strong) UIScrollView *sctollView;

@end

#define ITEM_WIDTH  60

#define ITEM_HEIGHT  30

//型号间隔
#define ITEM_TYPE_MARGIN 20

#define CAR_Color  [UIColor colorWithR:97 G:177 B:225 A:1]

@implementation MainItemViewController {
    UIButton *radiusButton;
    UILabel *priceLabel;
    UILabel *infoLabel;
    UIView *bottomView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"下单";
    UIButton *rightButton = [UIButton buttonWithTitle:@"特殊定制" andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    rightButton.tag = 1010;
    [rightButton addTarget:self action:@selector(buttonCliker:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.view.backgroundColor = [UIColor mianColor:1];
    
    [self setSubviews];
}

#pragma mark --- SubViews

- (void)setSubviews {
    
    [self createTopActionView];//顶部选择
    
    [self createScrollLayoutView];//中部变化
    
    [self createBottomView];//底部购买
}

- (void)createTopActionView {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 100)];
    topView.backgroundColor = [UIColor whiteColor];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 49.5, SCREEN_WIGHT, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [topView addSubview:line];
    
    NSArray *array = @[@"零切",@"圆棒",@"型材",@"管材"];
    UIButton *lastBtn = nil;
    for (NSInteger i=0; i<array.count; i++) {
        
        UIButton *button = [UIButton buttonWithTitle:[array objectAtIndex:i] andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor mianColor:2] andHighlightedTitle:[UIColor mianColor:2] andNormaImage:nil andHighlightedImage:nil];
        
        if (i==self.selectedNum) {
            [button setBackgroundImage:IMG(@"Main_button_bg") forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        
        [button addTarget:self action:@selector(buttonCliker:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100+i;
        [topView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(ITEM_WIDTH));
            make.height.equalTo(@(ITEM_HEIGHT));
            make.top.equalTo(topView.mas_top).offset(10);
            if (lastBtn) {
                make.left.equalTo(lastBtn.mas_right).offset((SCREEN_WIGHT-ITEM_WIDTH*4)/5);
            } else {
                make.left.equalTo(topView.mas_left).offset((SCREEN_WIGHT-ITEM_WIDTH*4)/5);
            }
        }];
        
        lastBtn = button;
    }
    self.lastSelected = 100+self.selectedNum;
    [self.view addSubview:topView];
    
    
    NSArray *typeArr = @[@"6061",@"7075",@"7050",@"2A12",@"5052",@"1060",@"1526"];
    UIScrollView *typeScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50.5, SCREEN_WIGHT, 49.5)];
    
    CGFloat scroll_width = (typeArr.count+1)*ITEM_TYPE_MARGIN;
    UIButton *lastTypeButton = nil;
    for (NSInteger i=0; i<typeArr.count; i++) {
        NSString *typeName = [typeArr objectAtIndex:i];
        CGSize typeSize = [UILabel getSizeWithText:typeName andFont:FONT_ArialMT(15) andSize:CGSizeMake(0, ITEM_HEIGHT)];
        scroll_width += (typeSize.width+20);
        
        UIButton *typeButton = [UIButton buttonWithTitle:[typeArr objectAtIndex:i] andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor mianColor:2] andHighlightedTitle:[UIColor mianColor:2] andNormaImage:nil andHighlightedImage:nil];
        if (i==0) {
            [typeButton setBackgroundImage:IMG(@"Main_button_bg") forState:UIControlStateNormal];
            [typeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        
        typeButton.tag = 200+i;
        [typeButton addTarget:self action:@selector(buttonCliker:) forControlEvents:UIControlEventTouchUpInside];
        
        [typeScrollView addSubview:typeButton];
        [typeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(typeSize.width+20));
            make.height.equalTo(@(ITEM_HEIGHT));
            make.top.equalTo(typeScrollView.mas_top).offset(10);
            if (lastTypeButton) {
                make.left.equalTo(lastTypeButton.mas_right).offset(ITEM_TYPE_MARGIN);
            } else {
                make.left.equalTo(typeScrollView.mas_left).offset(ITEM_TYPE_MARGIN);
            }
        }];
        
        lastTypeButton = typeButton;
    }
    
    [typeScrollView setContentSize:CGSizeMake(scroll_width, 49.5)];
    self.lastTypeSelected = 200;
    [self.view addSubview:typeScrollView];
    
}

- (void)createScrollLayoutView {
    [self.sctollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.sctollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.sctollView];
    [_sctollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-50);
        make.top.equalTo(self.view.mas_top).offset(100);
    }];
    NSLog(@"+++%ld", self.lastSelected);
    
    if (self.lastSelected==100) {
        MainItem__Single *single = [[MainItem__Single alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 300)];
        [single loadData:nil andCliker:^(NSString *clueStr) {
            
            
        }];
        
        [_sctollView addSubview:single];
    } else if (self.lastSelected == 101) {
        MainItemView__Pole *pole = [[MainItemView__Pole alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 260)];
        [pole loadData:nil andCliker:^(NSString *clueStr) {
            
            
        }];
        
        [_sctollView addSubview:pole];
    } else if (self.lastSelected == 102) {
        MainItemView__Tube *tube = [[MainItemView__Tube alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 300)];
        [tube loadData:nil andCliker:^(NSString *clueStr) {
            
            
        }];
        
        [_sctollView addSubview:tube];
    } else {
        MainItemView__Matter *matter = [[MainItemView__Matter alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 350)];
        [matter loadData:nil andCliker:^(NSString *clueStr) {
            
            
        }];
        
        [_sctollView addSubview:matter];
    }
    
    
    [_sctollView setContentSize:CGSizeMake(SCREEN_WIGHT, SCREEN_HEIGHT)];
    
    
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




#pragma mark --- Action

- (void)buttonCliker:(UIButton *)sender {
    NSLog(@"%@", sender.currentTitle);
    if (sender.tag==1010) {
        SpecialMakeViewController *special = [SpecialMakeViewController new];
        [self.navigationController pushViewController:special animated:YES];
    } else {
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sender setBackgroundImage:IMG(@"Main_button_bg") forState:UIControlStateNormal];
        
        UIButton *lastButton = [self.view viewWithTag:sender.tag<200?self.lastSelected:self.lastTypeSelected];
        [lastButton setTitleColor:[UIColor mianColor:2] forState:UIControlStateNormal];
        [lastButton setBackgroundImage:nil forState:UIControlStateNormal];
        
        if (sender.tag<200) {
            self.lastSelected = sender.tag;
        } else {
            self.lastTypeSelected = sender.tag;
        }
        
    }
    
    [self createScrollLayoutView];
    [self.view bringSubviewToFront:bottomView];
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
