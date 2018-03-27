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


@interface MainItemViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>

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
    
    self.lastSelected = 100+self.selectedNum;
    
    [self setSubviews];
}

#pragma mark --- SubViews

- (void)setSubviews {
    
    [self getDataSource];
    
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
    
    
    UIScrollView *typeScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50.5, SCREEN_WIGHT, 49.5)];
    
    CGFloat scroll_width = (self.dataMuArr.count+1)*ITEM_TYPE_MARGIN;
    UIButton *lastTypeButton = nil;
    for (NSInteger i=0; i<self.dataMuArr.count; i++) {
        MainItemTypeModel *model = [self.dataMuArr objectAtIndex:i];
        NSString *typeName = model.name;
        
        CGSize typeSize = [UILabel getSizeWithText:typeName andFont:FONT_ArialMT(15) andSize:CGSizeMake(0, ITEM_HEIGHT)];
        scroll_width += (typeSize.width+20);
        
        UIButton *typeButton = [UIButton buttonWithTitle:typeName andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor mianColor:2] andHighlightedTitle:[UIColor mianColor:2] andNormaImage:nil andHighlightedImage:nil];
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
    self.sctollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIGHT, SCREEN_HEIGHT-150-64)];
    [self.view addSubview:self.sctollView];

    NSLog(@"+++%ld", self.lastSelected);
    
    if (self.lastSelected==100) {
        MainItem__Single *single = [[MainItem__Single alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 350)];
        [single loadData:nil andCliker:^(NSString *clueStr) {
            single.thinLabel.text = clueStr;
            [self selectInfomationForUser];
        }];
        
        [_sctollView setContentSize:CGSizeMake(SCREEN_WIGHT, 600)];
        [self.sctollView addSubview:single];
        
    } else if (self.lastSelected == 101) {
        MainItemView__Pole *pole = [[MainItemView__Pole alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 350)];
        [pole loadData:nil andCliker:^(NSString *clueStr) {
            
            
        }];
        [_sctollView setContentSize:CGSizeMake(SCREEN_WIGHT, pole.height)];
        [_sctollView addSubview:pole];
    } else if (self.lastSelected == 102) {
        MainItemView__Tube *tube = [[MainItemView__Tube alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 400)];
        [tube loadData:nil andCliker:^(NSString *clueStr) {
            
            
        }];
        [_sctollView setContentSize:CGSizeMake(SCREEN_WIGHT, tube.height)];
        [_sctollView addSubview:tube];
    } else {
        MainItemView__Matter *matter = [[MainItemView__Matter alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 450)];
        [matter loadData:nil andCliker:^(NSString *clueStr) {
            
            
        }];
        [_sctollView setContentSize:CGSizeMake(SCREEN_WIGHT, matter.height)];
        [_sctollView addSubview:matter];
    }
    
        
    
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
            
            MainItemTypeModel *model = [self.dataMuArr objectAtIndex:sender.tag-200];
            NSLog(@"%@", model);
            
            [self getInfomationWithID:model.id];
        }
        
    }
    
    [self createScrollLayoutView];
    [self.view bringSubviewToFront:bottomView];
}

- (void)buyAction:(UIButton *)sender {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"1000" forKey:@"chang"];
    [dict setValue:@"1000" forKey:@"kuang"];
    [dict setValue:@"100" forKey:@"hou"];
    [dict setValue:@"快速" forKey:@"type"];
    [dict setValue:@"1000" forKey:@"amount"];
    [dict setValue:@"零切" forKey:@"zhonglei"];
    [dict setValue:@"30" forKey:@"erjimulu"];
    [dict setValue:@"6400" forKey:@"money"];
    [dict setValue:@"18625144206" forKey:@"phone"];
//    [dict setValue:@"1" forKey:@"addressId"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_OrderSave andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"+++%@", resultDic);
        
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:msg time:1 aboutType:WHShowViewMode_Text state:YES];
        
    } failure:^(NSString *error, NSInteger code) {
        
        
    }];
    
}

- (void)carAction:(UIButton *)sender {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"1000" forKey:@"chang"];
    [dict setValue:@"1000" forKey:@"kuang"];
    [dict setValue:@"100" forKey:@"hou"];
    [dict setValue:@"快速" forKey:@"type"];
    [dict setValue:@"1" forKey:@"amount"];
    [dict setValue:@"零切" forKey:@"zhonglei"];
    [dict setValue:@"30" forKey:@"erjimulu"];
    [dict setValue:@"6400" forKey:@"money"];
    [dict setValue:@"18625144206" forKey:@"phone"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_SaveToGouwuche andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"+++%@", resultDic);
        
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:msg time:1 aboutType:WHShowViewMode_Text state:YES];
        
    } failure:^(NSString *error, NSInteger code) {
        
        
    }];
    
}

#pragma mark ----- Data
- (void)getDataSource {
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:nil imageArray:nil WithType:Interface_CateList andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"---%@", resultDic);
        NSArray *dataArr = resultDic[@"list"];
        
        for (NSDictionary *dataDic in dataArr) {
            
            MainItemTypeModel *model = [[MainItemTypeModel alloc] initWithDictionary:dataDic error:nil];
            
            [self.dataMuArr addObject:model];
            
        }
        [self ahahaha];
        [self createTopActionView];//顶部选择
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}


- (void)ahahaha {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"1000" forKey:@"chang"];
    [dict setValue:@"1000" forKey:@"kuang"];
    [dict setValue:@"1000" forKey:@"hou"];
    [dict setValue:@"快速" forKey:@"type"];
    [dict setValue:@"10" forKey:@"amount"];
    [dict setValue:@"零切" forKey:@"zhonglei"];
    [dict setValue:@"30" forKey:@"erjimulu"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_OrderMoney andCookie:nil showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"+++%@", resultDic);
        
        
        
    } failure:^(NSString *error, NSInteger code) {
        
        
    }];
    
    
}

- (void)getInfomationWithID:(NSString *)infoID {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:infoID forKey:@"id"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_FindDetail andCookie:nil showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"+++%@", resultDic);
        
        
        
    } failure:^(NSString *error, NSInteger code) {
        
        
    }];
    
}

- (void)selectInfomationForUser {
    
    
    
    
}


#pragma mark UIPickerViewDataSource 数据源方法
// 返回多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}

// 返回多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 10;
}

#pragma mark UIPickerViewDelegate 代理方法

// 返回每行的标题
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return @"2222233333";
}
// 选中行显示在label上
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
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
