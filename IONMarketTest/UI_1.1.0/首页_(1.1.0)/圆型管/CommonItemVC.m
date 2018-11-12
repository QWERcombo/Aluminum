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

@interface CommonItemVC ()<CommonItemTabVCDelegate,WholeBoardTapViewDelegate>

@property (nonatomic, strong) CommonItemTabVC *commonTabVC;
@property (strong, nonatomic) UIScrollView *topScrollView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *titleArray;//型号数据
@property (nonatomic, copy) NSString *xinghao;//选中的型号
@property (nonatomic, assign) NSInteger lastSelected;

@property (weak, nonatomic) IBOutlet UIButton *shopcatBtn;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;


@end

@implementation CommonItemVC

- (UIScrollView *)topScrollView {
    if (!_topScrollView) {
        _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT-40, 40)];
        _topScrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_topScrollView];
    }
    return _topScrollView;
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
    self.titleArray = [NSMutableArray array];
    self.totalLabel.adjustsFontSizeToFitWidth = YES;
    
    
    [self getCateList];
    [self refreshBottomViewInfo];
}

#pragma mark - Layout
- (void)configurateTopScrollView {
    
    CGFloat contentSizeWidth = 0;
    for (NSInteger i=0; i<_titleArray.count; i++) {
        
        MainItemTypeModel *title = [_titleArray objectAtIndex:i];
        
        CGSize rect = [title.name boundingRectWithSize:CGSizeMake(0, 38) font:[UIFont systemFontOfSize:14] lineSpacing:0];
        WholeBoardTapView *tapView = [[WholeBoardTapView alloc] initWithFrame:CGRectMake(contentSizeWidth, 0, rect.width+40, 40)];
        tapView.tag = 200+i;
        tapView.delegate = self;
        [tapView.showButton setTitle:title.name forState:UIControlStateNormal];
        
        contentSizeWidth += (rect.width+40);
        
        [self.topScrollView addSubview:tapView];
        
        if (i==0) {
            //默认选中第一个
            [tapView selectedStatus:YES];
            self.lastSelected = tapView.tag;
            self.xinghao = title.name;
            self.commonTabVC.erjimulu_id = title;
            
        }
    }
    
    [self.topScrollView setContentSize:CGSizeMake(contentSizeWidth, 40)];
    
}
- (void)setSelected:(UIButton *)selectedButton {
    
    WholeBoardTapView *currentTap = (WholeBoardTapView *)(selectedButton.superview);
    [currentTap selectedStatus:YES];
    
    WholeBoardTapView *lastTap = [self.view viewWithTag:self.lastSelected];
    [lastTap selectedStatus:NO];
    
    self.lastSelected = currentTap.tag;
    MainItemTypeModel *model = [self.titleArray objectAtIndex:self.lastSelected-200];
    self.commonTabVC.erjimulu_id = model;
    [self.commonTabVC refreshInfoToReset];
}

- (void)scrollTopScrollView:(NSInteger)index {
    
    WholeBoardTapView *tapV = [self.view viewWithTag:200+index];
    [self setSelected:tapV.showButton];
    [self.topScrollView scrollRectToVisible:CGRectMake(tapV.mj_x, tapV.mj_y, tapV.mj_w, tapV.mj_h) animated:YES];
}

#pragma mark --- Data
- (void)getCateList {
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:nil imageArray:nil WithType:Interface_CateList andCookie:nil showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
        
        NSArray *dataArr = [resultDic objectForKey:@"list"];
        
        for (NSDictionary *dataDic in dataArr) {
            MainItemTypeModel *model = [[MainItemTypeModel alloc] initWithDictionary:dataDic error:nil];
            [self.titleArray addObject:model];
        }
        
        [self configurateTopScrollView];
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}

- (void)refreshBottomViewInfo {
    
    [[ShoppingCarSingle sharedShoppingCarSingle] getServerShopCarAmountAndTotalfee:^(NSString *amout, NSString *totalfee) {
        
        self.shopcatBtn.badgeValue = amout;
    }];
}


#pragma mark - Handle

- (IBAction)display:(UIButton *)sender {
    
    MJWeakSelf
    [DisplayView showDisplayViewWithDataSource:_titleArray selectedIndexPath:^(NSString * _Nonnull title) {
        
        [weakSelf scrollTopScrollView:[title integerValue]];
        
    }];
}

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
