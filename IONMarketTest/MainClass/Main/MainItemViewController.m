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

@property (nonatomic, strong) NSString *typeStr;//种类

@property (nonatomic, strong) NSString *xinghaoStr;//型号

@property (nonatomic, strong) NSString *chang;//长度

@property (nonatomic, strong) NSString *kuang;//宽度

@property (nonatomic, strong) NSString *hou;//厚度

@property (nonatomic, strong) NSString *amout;//数量

@property (nonatomic, strong) NSString *zhijing;//直径

@property (nonatomic, strong) NSString *waijing;//外径

@property (nonatomic, strong) NSString *neijing;//内径

@property (nonatomic, copy) void(^passValue)(NSString *value);//选择数据
@property (nonatomic, copy) void(^passTotalPrice)(NSString *value);//总价
@property (nonatomic, copy) void(^passWeight)(NSString *value);//重量

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
    self.typeStr = [array objectAtIndex:self.selectedNum];
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

//    NSLog(@"+++%ld", self.lastSelected);
    __weak typeof(self) weakself = self;
    
    if (self.lastSelected==100) { //零切
        MainItem__Single *single = [[MainItem__Single alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 350)];
        [single loadData:nil andCliker:^(NSString *clueStr) {
            
            if (clueStr.length == 2) {
                
                [weakself getOrderMoneyWithType:clueStr withMode:Mode_Single];
                
            } else {
                
                if ([clueStr isEqualToString:@"0"]) {
                    [weakself selectInfomationForUser:@"0"];
                    
                    weakself.passValue = ^(NSString *value) {
                        single.thinLabel.text = value;
                        weakself.hou = value;
                    };
                    
                }
                
            }
            
        }];
        self.passTotalPrice = ^(NSString *value) {//总价
            single.rightCountLabel.text = value;
        };
        
        [_sctollView setContentSize:CGSizeMake(SCREEN_WIGHT, 600)];
        [self.sctollView addSubview:single];
        
    } else if (self.lastSelected == 101) { //圆棒
        MainItemView__Pole *pole = [[MainItemView__Pole alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 350)];
        [pole loadData:nil andCliker:^(NSString *clueStr) {
            
            if (clueStr.length == 2) {
                
                [weakself getOrderMoneyWithType:clueStr withMode:Mode_Pole];
                
            } else {
                
                if ([clueStr isEqualToString:@"0"]) {
                    [weakself selectInfomationForUser:@"0"];
                    weakself.passValue = ^(NSString *value) {
                        pole.lengthLabel.text = value;
                        weakself.zhijing = value;
                    };
                }
                
                
            }
            
        }];
        [_sctollView setContentSize:CGSizeMake(SCREEN_WIGHT, pole.height)];
        [_sctollView addSubview:pole];
    } else if (self.lastSelected == 102) { //型材
        MainItemView__Tube *tube = [[MainItemView__Tube alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 400)];
        [tube loadData:nil andCliker:^(NSString *clueStr) {
            
            if (clueStr.length == 2) {
                
                [weakself getOrderMoneyWithType:clueStr withMode:Mode_Tube];
                
            } else {
                
                if ([clueStr isEqualToString:@"0"]) { //厚度
                    [weakself selectInfomationForUser:@"0"];
                    weakself.passValue = ^(NSString *value) {
                        tube.thinLabel.text = value;
                        weakself.hou = value;
                    };
                } else if ([clueStr isEqualToString:@"1"]) { //宽度
                    [weakself selectInfomationForUser:@"1"];
                    weakself.passValue = ^(NSString *value) {
                        tube.widthLabel.text = value;
                        weakself.kuang = value;
                    };
                } else {
                    
                }
                
                
            }
            
        }];
        [_sctollView setContentSize:CGSizeMake(SCREEN_WIGHT, tube.height)];
        [_sctollView addSubview:tube];
    } else {//管材
        MainItemView__Matter *matter = [[MainItemView__Matter alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 450)];
        [matter loadData:nil andCliker:^(NSString *clueStr) {
            
            if (clueStr.length == 2) {
                
                [weakself getOrderMoneyWithType:clueStr withMode:Mode_Matter];
                
            } else {
                
                if ([clueStr isEqualToString:@"0"]) { //外径
                    [weakself selectInfomationForUser:@"0"];
                    weakself.passValue = ^(NSString *value) {
                        matter.waiLabel.text = value;
                        weakself.waijing = value;
                    };
                } else if ([clueStr isEqualToString:@"1"]) { //内径
                    [weakself selectInfomationForUser:@"1"];
                    weakself.passValue = ^(NSString *value) {
                        matter.neiLabel.text = value;
                        weakself.neijing = value;
                    };
                } else {
                    
                }
                
            }
            
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
//    NSLog(@"%@", sender.currentTitle);
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
            
            self.typeStr = sender.currentTitle;
        } else {
            self.lastTypeSelected = sender.tag;
            
            MainItemTypeModel *model = [self.dataMuArr objectAtIndex:sender.tag-200];
//            NSLog(@"%@", model);
            self.xinghaoStr = model.id;

        }
        
    }
    
    [self createScrollLayoutView];
    [self.view bringSubviewToFront:bottomView];
}

//直接购买
- (void)buyAction:(UIButton *)sender {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"1000" forKey:@"chang"];
    [dict setValue:@"1000" forKey:@"kuang"];
    [dict setValue:@"100" forKey:@"hou"];
    [dict setValue:@"快速" forKey:@"type"];
    [dict setValue:@"1000" forKey:@"amount"];
    [dict setValue:@"零切" forKey:@"zhonglei"];
    [dict setValue:@"6061" forKey:@"erjimulu"];
    [dict setValue:@"6400" forKey:@"money"];
    [dict setValue:[UserData currentUser].phone forKey:@"phone"];
    [dict setValue:@"9" forKey:@"addressId"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_OrderSave andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"+++%@", resultDic);
        
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:msg time:1 aboutType:WHShowViewMode_Text state:YES];
        
    } failure:^(NSString *error, NSInteger code) {
        
        
    }];
    
}

//购物车
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
    [dict setValue:[UserData currentUser].phone forKey:@"phone"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_SaveToGouwuche andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"+++%@", resultDic);
        
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:msg time:1 aboutType:WHShowViewMode_Text state:YES];
        
    } failure:^(NSString *error, NSInteger code) {
        
        
    }];
    
}



#pragma mark ----- Data
//获取型号列表
- (void)getDataSource {
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:nil imageArray:nil WithType:Interface_CateList andCookie:nil showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
//        NSLog(@"---%@", resultDic);
        NSArray *dataArr = resultDic[@"list"];
        
        for (NSDictionary *dataDic in dataArr) {
            
            MainItemTypeModel *model = [[MainItemTypeModel alloc] initWithDictionary:dataDic error:nil];
            
            [self.dataMuArr addObject:model];
            
        }
        [self createTopActionView];//顶部选择
        self.xinghaoStr = ((MainItemTypeModel *)[self.dataMuArr firstObject]).id;
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}

//获取订单金额
- (void)getOrderMoneyWithType:(NSString *)type withMode:(GetWholeBoardMode)mode {
    
    __weak typeof(self) weakself = self;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"100" forKey:@"chang"];
    [dict setValue:@"100" forKey:@"kuang"];
    [dict setValue:@"10" forKey:@"hou"];
    [dict setValue:type forKey:@"type"]; //快速
    [dict setValue:@"10" forKey:@"amount"];
    [dict setValue:self.typeStr forKey:@"zhonglei"];  //零切
    [dict setValue:self.xinghaoStr forKey:@"erjimulu"]; //30
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_OrderMoney andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"+++%@", resultDic);
        NSString *orderMoney = [NSString stringWithFormat:@"%@", resultDic[@"orderMoney"]];
        if (weakself.passTotalPrice) {
            weakself.passTotalPrice(orderMoney);
        }
        
    } failure:^(NSString *error, NSInteger code) {
        
        
    }];
    
    if ([type isEqualToString:@"快速"] || [type isEqualToString:@"整只"]) {
        
        [self automaticateLengthByWhole:mode];
        
    }
    
}

- (void)getInfomationWithID:(NSString *)infoID {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:infoID forKey:@"id"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_FindDetail andCookie:nil showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"+++%@", resultDic);
        
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}


//选择单位
- (void)selectInfomationForUser:(NSString *)type {
    __weak typeof(self) weakself = self;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:self.typeStr forKey:@"zhonglei"];
    [dict setValue:self.xinghaoStr forKey:@"xinghao"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_GetByZhongleiAndXinghao andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
//        NSLog(@"--%@", resultDic);
        
        NSArray *dataArr = resultDic[@"houdus"];
        NSArray *sortArr = [dataArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            if ([obj2 integerValue] < [obj1 integerValue])
            {
                return NSOrderedDescending;
            }
            else
            {
                return NSOrderedAscending;
            }
        }];
        
        NSArray *dataArr1 = resultDic[@"kuangdus"];
        NSArray *sortArr1 = [dataArr1 sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            if ([obj2 integerValue] < [obj1 integerValue])
            {
                return NSOrderedDescending;
            }
            else
            {
                return NSOrderedAscending;
            }
        }];
        
        
        if (sortArr1.count || sortArr.count) {
            UnitsPickerView *pv = [[UnitsPickerView alloc] initWithFrame:self.view.bounds withDataSource:[type integerValue]==0?sortArr:sortArr1];
            [pv loadData:nil andClickBlock:^(NSString *clueStr) {
//                NSLog(@"++%@", clueStr);
                weakself.passValue(clueStr);
            }];
            [weakself.view addSubview:pv];
        } else {
            [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"暂无数据" time:0 aboutType:WHShowViewMode_Text state:NO];
        }
        
    } failure:^(NSString *error, NSInteger code) {

    }];
    
}

//下整只的时候，自动选择长度
- (void)automaticateLengthByWhole:(GetWholeBoardMode)mode {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:self.typeStr forKey:@"zhonglei"];
    [dict setValue:self.xinghaoStr forKey:@"xinghao"];
    switch (mode) {
        case Mode_Single:
            if (self.hou) {
                [dict setValue:self.hou forKey:@"hou"];
            } else {
                [self showAlert:@"厚度"];
                return;
            }
            break;
        case Mode_Pole:
            if (self.zhijing) {
                [dict setValue:self.zhijing forKey:@"zhijing"];
            } else {
                [self showAlert:@"直径"];
                return;
            }
            break;
        case Mode_Tube:
            if (self.hou) {
                [dict setValue:self.hou forKey:@"hou"];
            } else {
                [self showAlert:@"厚度"];
                return;
            }
            if (self.kuang) {
                [dict setValue:self.kuang forKey:@"kuang"];
            } else {
                [self showAlert:@"宽度"];
                return;
            }
            break;
        case Mode_Matter:
            if (self.waijing) {
                [dict setValue:self.waijing forKey:@"waijing"];
            } else {
                [self showAlert:@"外径"];
                return;
            }
            if (self.neijing) {
                [dict setValue:self.waijing forKey:@"neijing"];
            } else {
                [self showAlert:@"内径"];
                return;
            }
            break;
        default:
            break;
    }
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Inuterface_GetLengthByOthers andCookie:nil showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"++++%@", resultDic);
        
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
    
    
}


- (void)showAlert:(NSString *)text {
    [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:[NSString stringWithFormat:@"请选择%@", text] time:0 aboutType:WHShowViewMode_Text state:NO];
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
