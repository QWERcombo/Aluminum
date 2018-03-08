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
#import "MainViewController.h"
#import "OrderViewController.h"
#import "ShopCarViewController.h"
#import "MineViewController.h"

@interface TBTabBarController ()<UITabBarDelegate>

@end

@implementation TBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
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


-(void)setupchildVc:(NSObject *)model
{
    NSArray *tabBarItemImages = @[@"first",@"second",@"third",@"four"];
    NSArray *tabBarItemTitle = @[@"首页",@"账单",@"购物车",@"我的"];
    
    for (int i = 0;i < 4; i ++ ) {
        NSString *titleString = [tabBarItemTitle objectAtIndex:i];
        NSString *selectedimage = [NSString stringWithFormat:@"%@_selected",[tabBarItemImages objectAtIndex:i]];
        NSString *unselectedimage = [NSString stringWithFormat:@"%@_normal",[tabBarItemImages objectAtIndex:i]];
        BaseViewController *newVC = nil;
        if (i == 0) {
            MainViewController *main = [[MainViewController alloc] init];
            newVC = main;
        }else if (i == 1){
            OrderViewController *order = [[OrderViewController alloc] init];
            newVC = order;
        }else if (i == 2){
            ShopCarViewController *shop = [[ShopCarViewController alloc] init];
            newVC = shop;
        }else{
            MineViewController *mine = [[MineViewController alloc] init];
            newVC = mine;
        }
        
        
        newVC.titleStr = i==0?@"":titleString;
        [self setupChildVC:newVC title:titleString image:unselectedimage image1:selectedimage model:nil];
    }
}
- (void)setupChildVC:(UIViewController*)vc title:(NSString*)title image:(NSString *)normalImage image1:(NSString *)selectImage model:(BaseModel *)model
{
    
    TBNavigationController  *nav = [[TBNavigationController alloc]initWithRootViewController:vc];
    //改变位移
    //CGFloat offset = 5.0;
    //nav.tabBarItem.imageInsets = UIEdgeInsetsMake(offset, 0, -offset, 0);
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = IMG(normalImage);
    nav.tabBarItem.selectedImage = [IMG(selectImage) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
    
}


#pragma mark - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    //点这里 点这里
    //    NSLog(@"---%@",item.title);
//    if ([item.title isEqualToString:@"首页"]) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:ReloadGiftList_Main object:nil];
//    }
//    if ([item.title isEqualToString:@"圈子"]) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:ReloadGiftList_Circle object:nil];
//    }
    
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
