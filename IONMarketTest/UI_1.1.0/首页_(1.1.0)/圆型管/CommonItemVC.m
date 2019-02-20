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
//@property (strong, nonatomic) UIScrollView *topScrollView;
@property (nonatomic, strong) SelectConditionView *conditionView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSArray *titleArray;//型号数据
@property (nonatomic, copy) NSString *xinghao;//选中的型号
@property (nonatomic, assign) NSInteger lastSelected;

@property (weak, nonatomic) IBOutlet UIButton *shopcatBtn;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@property (nonatomic, assign) NSInteger mainIndex;
@property (nonatomic, assign) NSInteger subIndex;
@property (nonatomic, copy) NSString *zhuangTai;//状态


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
            self.title = @"圆棒";
            break;
        case ShowType_XingCai:
            self.title = @"型材";
            break;
        case ShowType_GuanCai:
            self.title = @"管材";
            break;
        default:
            break;
    }
    self.dataSource = [NSMutableArray array];
    self.titleArray = [NSArray arrayWithObjects:@"牌号",@"状态", nil];
    self.totalLabel.adjustsFontSizeToFitWidth = YES;
    
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
        
        [ConditionDisplayView showConditionDisplayViewWithTitle:[self.titleArray objectAtIndex:index] parameter:@"" selectTitle:title selectedBlock:^(id  _Nonnull dataObject, BOOL isOver) {
            NSLog(@"----%@", title);
            if ([title isEqualToString:@"-1"]) {
                //收起子条件时清除主条件选中状态
                [self.conditionView reset];
                
            } else {
                if (isOver) {
                    [ConditionDisplayView hideConditionDisplayView];
                }
                
                [self.conditionView changeTitle:title index:self.mainIndex];
            }
            
        }];
        
        [self.view bringSubviewToFront:self.conditionView];
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
