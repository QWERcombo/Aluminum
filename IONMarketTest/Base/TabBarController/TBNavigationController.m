//
//  TBNavigationController.m
//  GoGoTree
//
//  Created by youqin on 16/8/30.
//  Copyright © 2016年 t_b. All rights reserved.
//

#import "TBNavigationController.h"
#import "UIImage+YXP.h"

@interface TBNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>
//返回block回调

@property (nonatomic, strong) id popDelegate;

@end

@implementation TBNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
}

+(void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    
//    NSArray *colors = [NSArray arrayWithObjects:[UIColor colorWithHexString:@"#6ccbf8"],[UIColor colorWithHexString:@"#7eabe6"], nil];
//    CGRect barRect = CGRectMake(0, 0, SCREEN_WIGHT, 44);
    UIImage *nav_bg_image = [UIImage imageWithColor:[UIColor whiteColor]];
    
    // 设置背景
    [bar setBackgroundImage:nav_bg_image forBarMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[[UIImage alloc] init]];

    // 设置标题文字属性
    NSMutableDictionary *barAttrs = [NSMutableDictionary dictionary];
    barAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    barAttrs[NSForegroundColorAttributeName] = [UIColor colorWithHexString:@"#333336"];
    [bar setTitleTextAttributes:barAttrs];
    
    bar.tintColor = [UIColor colorWithHexString:@"#333336"];
    
//    /** 设置UIBarButtonItem */
//    UIBarButtonItem *item = [UIBarButtonItem appearance];
//    // UIControlStateNormal
//    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
//    normalAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
//    normalAttrs[NSFontAttributeName] = [UIFont fontWithSize:18];
//    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
//
//    // UIControlStateDisabled
//    NSMutableDictionary *disabledAttrs = [NSMutableDictionary dictionary];
//    disabledAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//    [item setTitleTextAttributes:disabledAttrs forState:UIControlStateDisabled];
//
//    [item setBackButtonTitlePositionAdjustment:UIOffsetMake(7, 0) forBarMetrics:UIBarMetricsDefault];
}


-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {// 如果现在push的不是栈底控制器(最先push进来的那个控制器)
        viewController.hidesBottomBarWhenPushed = YES;
    
        //设置导航栏的按钮
        UIBarButtonItem *backButton = [self itemWithImageName:@"MGoBack_w" highImageName:@"MGoBack_w" target:self action:@selector(backAction)];
        viewController.navigationItem.leftBarButtonItems = @[backButton];

        // 就有滑动返回功能
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    [super pushViewController:viewController animated:animated];
}


- (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:target action:(SEL)action {
    UIButton *button = [[UIButton alloc] init];
    // 设置按钮的背景图片
    [button setImage:IMG(imageName) forState:UIControlStateNormal];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"#333336"] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];

    if (highImageName != nil) {
        [button setImage:IMG(highImageName) forState:UIControlStateHighlighted];
    }
    // 设置按钮的尺寸为背景图片的尺寸
    button.size = CGSizeMake(60, 44);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    button.adjustsImageWhenHighlighted = NO;
    //监听按钮的点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

/*
-(BOOL) gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count > 1;
}

// 完全展示完调用
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 如果展示的控制器是根控制器，就还原pop手势代理
    if (viewController == [self.viewControllers firstObject]) {
        self.interactivePopGestureRecognizer.delegate = self.popDelegate;
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (viewController == [self.viewControllers firstObject]) {
        
    }
}
 */

- (void)backAction{
    [self popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
