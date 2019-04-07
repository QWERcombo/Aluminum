//
//  CommonItemVC.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/11/4.
//  Copyright © 2018 赵越. All rights reserved.
//

#import "CommonItemVC.h"
#import "CommonItemTabVC.h"
#import "WholeBoardTapView.h"
#import "DisplayView.h"
#import "ShopCarViewController.h"
#import "ConfirmOrderVC.h"

#import "SelectConditionView.h"
#import "ConditionDisplayView.h"

@interface CommonItemVC ()<CommonItemTabVCDelegate,SelectConditionViewDelegate>

@property (nonatomic, strong) CommonItemTabVC *commonTabVC;
@property (nonatomic, strong) SelectConditionView *conditionView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSArray *titleArray;//型号数据
@property (nonatomic, copy) NSString *xinghao;//选中的型号
@property (nonatomic, assign) NSInteger lastSelected;

@property (weak, nonatomic) IBOutlet UIButton *shopcatBtn;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@property (nonatomic, assign) NSInteger mainIndex;
@property (nonatomic, assign) NSInteger subIndex;

@end

@implementation CommonItemVC

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
    switch (self.showType) {
        case ShowType_YuanBang:
            self.title = @"切圆棒";
            break;
        case ShowType_XingCai:
            self.title = @"切型材";
            break;
        case ShowType_GuanCai:
            self.title = @"切管材";
            break;
        default:
            break;
    }
    self.dataSource = [NSMutableArray array];
    self.titleArray = [NSArray arrayWithObjects:@"牌号",@"状态", nil];
    self.totalLabel.adjustsFontSizeToFitWidth = YES;
//    NSLog(@"%@", [NSString getStringAfterTwo:@"111101.2251"]);
    [self.view addSubview:self.conditionView];
    [self refreshBottomViewInfo];
}

#pragma mark - Layout
- (void)didSelectedConditionIndex:(NSInteger)index conditionTitle:(NSString *)title {
    //    NSLog(@"selected-----%ld",(long)index);
    if (index == -1) {
        //收起
        [ConditionDisplayView hideConditionDisplayView];
        
    } else {
        //选中
        self.mainIndex = index;
        
        NSString *zhonglei = @"";
        switch (self.showType) {
            case ShowType_YuanBang:
                zhonglei = @"圆棒";
                break;
            case ShowType_XingCai:
                zhonglei = @"型材";
                break;
            case ShowType_GuanCai:
                zhonglei = @"管材";
                break;
                
            default:
                break;
        }
        
        [ConditionDisplayView showConditionDisplayViewWithTitle:[self.titleArray objectAtIndex:index] parameter:@"2" selectTitle:title zhonglei:zhonglei paihao:self.commonTabVC.erjimulu_id.id zhuangtai:self.commonTabVC.zhuangTai houdu:@"" selectedBlock:^(id  _Nonnull dataObject, BOOL isOver) {
            NSString *showName = @"";
            
            if (isOver) {
                [ConditionDisplayView hideConditionDisplayView];
            }
            
            if ([dataObject isKindOfClass:[MainItemTypeModel class]]) {
                
                MainItemTypeModel *model = (MainItemTypeModel *)dataObject;
                self.commonTabVC.erjimulu_id = model;
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
                            self.commonTabVC.erjimulu_id = nil;
                            break;
                        case 1:
                            self.commonTabVC.zhuangTai = @"";
                            break;
                        
                        default:
                            break;
                    }
                } else if ([number integerValue] == -3) {
                    //全部重置
                    [self.conditionView resetAll];
                    self.commonTabVC.erjimulu_id = nil;
                    self.commonTabVC.zhuangTai = @"";
                } else {
                    
                    showName = number;
                    
                    if ([[self.titleArray objectAtIndex:self.mainIndex] isEqualToString:@"状态"]) {
                        
                        self.commonTabVC.zhuangTai = number;
                    }
                    
                }
                
            } else {
            }
            
            if (showName.length) {
                
                [self.conditionView changeTitle:showName index:self.mainIndex];
            }

            if (self.commonTabVC.zhuangTai.length && self.commonTabVC.erjimulu_id) {
                [self.commonTabVC refreshInfoToReset];
                [self refreshBottomShopCarNumber];
            }
        }];
        
        [self.view bringSubviewToFront:self.conditionView];
    }
}
- (void)changePaiHaoWhenZhuangTaiIsNoneToGetShow:(NSString *)zhuangtai {
    
    self.commonTabVC.zhuangTai = zhuangtai;
    [self.conditionView changeTitle:zhuangtai index:[self.titleArray indexOfObject:@"状态"]];
    if (self.commonTabVC.zhuangTai.length && self.commonTabVC.erjimulu_id) {
        [self.commonTabVC refreshInfoToReset];
        [self refreshBottomShopCarNumber];
    }
}


#pragma mark --- Data


- (void)refreshBottomViewInfo {
    
    [[ShoppingCarSingle sharedShoppingCarSingle] getServerShopCarAmountAndTotalfee:^(NSString *amout, NSString *totalfee) {
        
        self.shopcatBtn.badgeValue = amout;
    }];
}


#pragma mark - Handle
- (IBAction)buyNow:(UIButton *)sender {
    
    MJWeakSelf
    [[PublicFuntionTool sharedInstance] isHadLogin:^{
        
        [weakSelf.commonTabVC placeOrder:UseType_BuyNow];
    }];
}

- (IBAction)excute:(UIButton *)sender {
    
    MJWeakSelf
    [[PublicFuntionTool sharedInstance] isHadLogin:^{
        
        [weakSelf.commonTabVC placeOrder:UseType_AddShopCar];
    }];
}

//跳转购物车
- (IBAction)shopCar:(UIButton *)sender {
    [[PublicFuntionTool sharedInstance] isHadLogin:^{
        
        ShopCarViewController *shopcar = [[ShopCarViewController alloc] init];
        [self.navigationController pushViewController:shopcar animated:YES];
    }];
}


#pragma mark - Delegate

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
    if ([segue.identifier isEqualToString:@"CommonItemTabVC"]) {
        
        CommonItemTabVC *common = segue.destinationViewController;
        
        self.commonTabVC = common;
        self.commonTabVC.showType = self.showType;
        self.commonTabVC.delegate = self;
    }
}


@end
