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

@interface ZeroCutVC ()<WholeBoardTapViewDelegate,ZeroCutTabVCDelegate,SelectConditionViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIButton *shopcarBtn;

//@property (strong, nonatomic) UIScrollView *topScrollView;
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

//- (UIScrollView *)topScrollView {
//    if (!_topScrollView) {
//        _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT-40, 40)];
//        _topScrollView.showsHorizontalScrollIndicator = NO;
//        [self.view addSubview:_topScrollView];
//    }
//    return _topScrollView;
//}
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
//    [self getCateList];
    [self refreshBottomViewInfo];
}


#pragma mark - Layout
//- (void)configurateTopScrollView {
//
//    CGFloat contentSizeWidth = 0;
//    for (NSInteger i=0; i<_titleArray.count; i++) {
//
//        MainItemTypeModel *title = [_titleArray objectAtIndex:i];
//
//        CGSize rect = [title.name boundingRectWithSize:CGSizeMake(0, 38) font:[UIFont systemFontOfSize:14] lineSpacing:0];
//        WholeBoardTapView *tapView = [[WholeBoardTapView alloc] initWithFrame:CGRectMake(contentSizeWidth, 0, rect.width+40, 40)];
//        tapView.tag = 200+i;
//        tapView.delegate = self;
//        [tapView.showButton setTitle:title.name forState:UIControlStateNormal];
//
//        contentSizeWidth += (rect.width+40);
//
//        [self.topScrollView addSubview:tapView];
//
//        if (i==0) {
//            //默认选中第一个
//            [tapView selectedStatus:YES];
//            self.lastSelected = tapView.tag;
//            self.xinghao = title.name;
//            self.zeroTabVC.erjimulu_id = title;
//
//        }
//    }
//
//    [self.topScrollView setContentSize:CGSizeMake(contentSizeWidth, 40)];
//
//}
//- (void)setSelected:(UIButton *)selectedButton {
//    
//    WholeBoardTapView *currentTap = (WholeBoardTapView *)(selectedButton.superview);
//    [currentTap selectedStatus:YES];
//    
//    WholeBoardTapView *lastTap = [self.view viewWithTag:self.lastSelected];
//    [lastTap selectedStatus:NO];
//    
//    self.lastSelected = currentTap.tag;
//    MainItemTypeModel *model = [self.titleArray objectAtIndex:self.lastSelected-200];
//    self.zeroTabVC.erjimulu_id = model;
//    [self.zeroTabVC refreshInfoToReset];
//}


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

//- (IBAction)display:(UIButton *)sender {
//
//    MJWeakSelf
//    [DisplayView showDisplayViewWithDataSource:_titleArray selectedIndexPath:^(NSString * _Nonnull title) {

//        [weakSelf scrollTopScrollView:[title integerValue]];
        
//    }];

//}
//- (void)scrollTopScrollView:(NSInteger)index {

//    WholeBoardTapView *tapV = [self.view viewWithTag:200+index];
//    [self setSelected:tapV.showButton];
//    [self.topScrollView scrollRectToVisible:CGRectMake(tapV.mj_x, tapV.mj_y, tapV.mj_w, tapV.mj_h) animated:YES];
//
//}

- (void)didSelectedConditionIndex:(NSInteger)index conditionTitle:(NSString *)title {
    NSLog(@"selected-----%ld",(long)index);
    if (index == -1) {
        //收起
        [ConditionDisplayView hideConditionDisplayView];
        
    } else {
        //选中
        self.mainIndex = index;
        
        [ConditionDisplayView showConditionDisplayViewWithTitle:[self.titleArray objectAtIndex:index] parameter:@"" selectTitle:title selectedBlock:^(NSString * _Nonnull title, BOOL isOver) {
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
//- (void)getCateList {
//
//    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:nil imageArray:nil WithType:Interface_CateList andCookie:nil showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
//
//        NSArray *dataArr = [resultDic objectForKey:@"list"];
//
//        for (NSDictionary *dataDic in dataArr) {
//            MainItemTypeModel *model = [[MainItemTypeModel alloc] initWithDictionary:dataDic error:nil];
//            [self.titleArray addObject:model];
//        }
        
//        [self configurateTopScrollView];
//    } failure:^(NSString *error, NSInteger code) {
//
//    }];

//}


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
