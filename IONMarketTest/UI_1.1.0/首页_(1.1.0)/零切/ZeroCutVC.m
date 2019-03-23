//
//  ZeroCutVC.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/10/23.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "ZeroCutVC.h"
#import "DisplayView.h"
#import "WholeBoardTapView.h"
#import "ZeroCutTabVC.h"
#import "ShopCarViewController.h"
#import "ConfirmOrderVC.h"
#import "SelectConditionView.h"
#import "ConditionDisplayView.h"

@interface ZeroCutVC ()<ZeroCutTabVCDelegate,SelectConditionViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIButton *shopcarBtn;

@property (nonatomic, strong) SelectConditionView *conditionView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger lastSelected;
@property (nonatomic, strong) ZeroCutTabVC *zeroTabVC;
@property (nonatomic, copy) NSArray *titleArray;//型号数据
@property (nonatomic, copy) NSString *xinghao;//选中的型号

@property (nonatomic, assign) NSInteger mainIndex;
@property (nonatomic, assign) NSInteger subIndex;


@end

@implementation ZeroCutVC

- (SelectConditionView *)conditionView {
    if (!_conditionView) {
        _conditionView = [[SelectConditionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 40) titleArray:self.titleArray];
        _conditionView.delegate = self;
    }
    return _conditionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"零切";
    self.dataSource = [NSMutableArray array];
    self.titleArray = [NSArray arrayWithObjects:@"牌号",@"状态",@"厚度", nil];
    self.totalLabel.adjustsFontSizeToFitWidth = YES;
    
    [self.view addSubview:self.conditionView];
    [self refreshBottomViewInfo];
}

#pragma mark - Handle

- (IBAction)shopCar:(UIButton *)sender {
    [[PublicFuntionTool sharedInstance] isHadLogin:^{
        
        ShopCarViewController *shopcar = [[ShopCarViewController alloc] init];
        [self.navigationController pushViewController:shopcar animated:YES];
    }];
}

- (IBAction)addCar:(UIButton *)sender {
    
    MJWeakSelf
    [[PublicFuntionTool sharedInstance] isHadLogin:^{
        
        [weakSelf.zeroTabVC placeOrder:UseType_AddShopCar];
    }];
}

- (IBAction)buyNow:(UIButton *)sender {
    
    MJWeakSelf
    [[PublicFuntionTool sharedInstance] isHadLogin:^{
        
        [weakSelf.zeroTabVC placeOrder:UseType_BuyNow];
    }];
}


- (void)didSelectedConditionIndex:(NSInteger)index conditionTitle:(NSString *)title {
//    NSLog(@"selected-----%ld",(long)index);
    if (index == -1) {
        //收起
        [ConditionDisplayView hideConditionDisplayView];
        
    } else {
        //选中
        self.mainIndex = index;
        
        [ConditionDisplayView showConditionDisplayViewWithTitle:[self.titleArray objectAtIndex:index] parameter:@"2" selectTitle:title zhonglei:@"零切" paihao:self.zeroTabVC.erjimulu_id.id zhuangtai:self.zeroTabVC.zhuangTai houdu:self.zeroTabVC.houDu selectedBlock:^(id  _Nonnull dataObject, BOOL isOver) {
            
            NSString *showName = @"";
            
            if (isOver) {
                [ConditionDisplayView hideConditionDisplayView];
            }
            
            if ([dataObject isKindOfClass:[MainItemTypeModel class]]) {
                
                MainItemTypeModel *model = (MainItemTypeModel *)dataObject;
                self.zeroTabVC.erjimulu_id = model;
                showName = model.name;
                
            } else if ([dataObject isKindOfClass:[NSString class]]) {
                
                NSString *number = (NSString *)dataObject;
                
                if ([number integerValue] == -1) {
                    //收起子条件时清除主条件选中状态
                    [self.conditionView reset];
                } else if ([number integerValue] == -2) {
                    //重置子条件
                    [self.conditionView changeTitle:[self.titleArray objectAtIndex:index] index:self.mainIndex];
                    [ConditionDisplayView hideConditionDisplayView];
                    
                    switch (self.mainIndex) {
                        case 0:
                            self.zeroTabVC.erjimulu_id = nil;
                            break;
                        case 1:
                            self.zeroTabVC.zhuangTai = @"";
                            break;
                        case 2:
                            self.zeroTabVC.houDu = @"";
                            break;
                        default:
                            break;
                    }
                } else {
                    
                    showName = number;
                    
                    if ([[self.titleArray objectAtIndex:self.mainIndex] isEqualToString:@"状态"]) {
                        
                        self.zeroTabVC.zhuangTai = number;
                    } else if ([[self.titleArray objectAtIndex:self.mainIndex] isEqualToString:@"厚度"]) {
                        
                        self.zeroTabVC.houDu = number;
                    } else {
                    }
                    
                }
                
            } else {
            }
            
            if (showName.length) {
                [self.conditionView changeTitle:showName index:self.mainIndex];

            }
            
        }];
        [self.view bringSubviewToFront:self.conditionView];
    }
}
- (void)changePaiHaoWhenZhuangTaiIsNoneToGetShow:(NSString *)zhuangtai {
    
    self.zeroTabVC.zhuangTai = zhuangtai;
    [self.conditionView changeTitle:zhuangtai index:[self.titleArray indexOfObject:@"状态"]];
    
}
- (void)resetTitleInfomationWithIndex:(NSInteger)index {
    
    if (index == 0) {
        //修改牌号
        self.zeroTabVC.houDu = @"";
        self.zeroTabVC.zhuangTai = @"";
        [self.zeroTabVC refreshInfoToReset];
    } else if (index == 1) {
        //修改状态
        self.zeroTabVC.houDu = @"";
        [self.zeroTabVC refreshInfoToReset];
    } else {
        //修改厚度
//        [self.zeroTabVC placeOrder:UseType_OrderMoney];
        [self.zeroTabVC refreshInfoToReset];
    }
    
}

#pragma mark - Delegate
- (void)refreshBottomViewInfo {
    
    [[ShoppingCarSingle sharedShoppingCarSingle] getServerShopCarAmountAndTotalfee:^(NSString *amout, NSString *totalfee) {
        
        self.shopcarBtn.badgeValue = amout;
    }];
}

- (void)refreshBottomTotalPrice:(NSString *)total {
    
    self.totalLabel.text = [NSString stringWithFormat:@"合计:%@", total];
}

- (void)refreshBottomShopCarNumber {
    [self refreshBottomViewInfo];
    self.totalLabel.text = @"合计:0.00元";
}

- (void)goToBuyNow:(ShopCar *)shopCar {
    
    ConfirmOrderVC *confirm = [[UIStoryboard storyboardWithName:@"Mine" bundle:nil] instantiateViewControllerWithIdentifier:@"ConfirmOrderVC"];
    confirm.carArr = @[shopCar];
    confirm.fromtype = FromVCType_Buy;
    [self.navigationController pushViewController:confirm animated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"ZeroCutTabVC"]) {
        
        ZeroCutTabVC *zero = segue.destinationViewController;
        self.zeroTabVC = zero;
        self.zeroTabVC.delegate = self;
    }
    
}


@end
