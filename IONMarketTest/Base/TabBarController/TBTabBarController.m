//
//  TBTabBarController.m
//  GoGoTree
//
//  Created by youqin on 16/8/30.
//  Copyright © 2016年 t_b. All rights reserved.
//

#import "TBTabBarController.h"
#import "TBNavigationController.h"
#import "TBTabBar.h"
#import "MineViewController.h"
#import "MainViewController.h"
#import "QuotationViewController.h"
#import "LoginTVC.h"

@interface TBTabBarController ()<UITabBarDelegate,UITabBarControllerDelegate>

@end

@implementation TBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.delegate = self;
    [self setUpItem];//TabBar字体
//    [self changeTabBar];//TabBar按钮
    
}


-(void)setUpItem
{
    NSDictionary *normalDic=@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:12]};
    NSDictionary *selectDic=@{NSForegroundColorAttributeName:[UIColor mianColor:2],NSFontAttributeName:[UIFont systemFontOfSize:12]};
    UITabBarItem *item=[UITabBarItem appearance];
    [item setTitleTextAttributes:normalDic forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectDic forState:UIControlStateSelected];
}

-(void)changeTabBar{
    TBTabBar *tabBarView =  [[TBTabBar alloc]init];
    tabBarView.delegate = self;
    //tabBarView.showMiddleBTN = YES;
    [self setValue:tabBarView forKey:@"tabBar"];
}


- (void)setupchildVc:(NSObject *)model {
    NSArray *tabBarItemImages = @[@"main",@"order",@"mine"];
    NSArray *tabBarItemTitle = @[@"首页",@"行情",@"我的"];
//    image_main_0
    for (int i = 0;i < 3; i ++ ) {
        NSString *titleString = [tabBarItemTitle objectAtIndex:i];
        NSString *selectedimage = [NSString stringWithFormat:@"image_%@_1",[tabBarItemImages objectAtIndex:i]];
        NSString *unselectedimage = [NSString stringWithFormat:@"image_%@_0",[tabBarItemImages objectAtIndex:i]];
        UIViewController *newVC = nil;
        if (i == 0) {
            MainViewController *main = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainViewController"];
            newVC = main;
        }else if (i == 1){
             QuotationViewController *order = [[QuotationViewController alloc] init];
            newVC = order;
        }else if (i == 2){
            MineViewController *shop = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MineViewController"];
            newVC = shop;
        }
        
        newVC.title = titleString;
        [self setupChildVC:newVC title:titleString image:unselectedimage image1:selectedimage model:nil];
    }
    
    
}
- (void)setupChildVC:(UIViewController*)vc title:(NSString*)title image:(NSString *)normalImage image1:(NSString *)selectImage model:(BaseModel *)model
{
    TBNavigationController  *nav = [[TBNavigationController alloc] initWithRootViewController:vc];
//    改变位移
    CGFloat offset = 5.0;
    nav.tabBarItem.imageInsets = UIEdgeInsetsMake(offset, 0, -offset, 0);
    nav.title = title;
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = IMG(normalImage);
    nav.tabBarItem.selectedImage = [IMG(selectImage) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
    
}


#pragma mark - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    //点这里 点这里
//        NSLog(@"---%@",item.title);
    if ([item.title isEqualToString:@"购物车"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshNewData" object:nil];
    }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    if ([viewController.tabBarItem.title isEqualToString:@"首页"]) {

        return YES;
    } else {

        if ([UserData currentUser].phone) {

            return YES;
        } else {

            LoginTVC *login = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginTVC"];
            TBNavigationController *nav = [[TBNavigationController alloc] initWithRootViewController:login];
            [self presentViewController:nav animated:YES completion:^{

            }];

            return NO;
        }

    }
    
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
