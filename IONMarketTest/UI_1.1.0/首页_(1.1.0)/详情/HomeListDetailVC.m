//
//  HomeListDetailVC.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/10/27.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "HomeListDetailVC.h"
#import "ZJScrollPageView.h"
#import "SubMarketVC.h"

@interface HomeListDetailVC ()<UIGestureRecognizerDelegate>

@end

@implementation HomeListDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"行情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    //显示滚动条
    style.showLine = YES;
    style.scrollLineColor = [UIColor mianColor:2];
    style.normalTitleColor = [UIColor Grey_WordColor];
    style.selectedTitleColor = [UIColor mianColor:2];
    style.segmentHeight = 40;
    // 设置子控制器 --- 注意子控制器需要设置title, 将用于对应的tag显示title
    NSArray *childVcs = [NSArray arrayWithArray:[self setupChildVcAndTitle]];
    // 初始化
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) segmentStyle:style childVcs:childVcs parentViewController:self];


    [self.view addSubview:scrollPageView];

//    UITapGestureRecognizer *ttt = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(aaa)];
//    ttt.delegate = self;
//    [self.view addGestureRecognizer:ttt];
    
//    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 100, 50)];
//    tf.backgroundColor = [UIColor purpleColor];
//    [self.view addSubview:tf];
}
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
//    
//    if ([touch.view isKindOfClass:[UIScrollView class]]) {
//        return NO;
//    } else {
//        return YES;
//    }
//    
//}
//- (void)aaa {
//    
//}

- (NSArray *)setupChildVcAndTitle {
    
    
    NSArray *titleArray = @[@"长江有色",@"上海现货",@"南海灵通",@"LME伦敦"];
//    NSMutableArray *array = [NSMutableArray array];
//    for (NSInteger i=0; i<titleArray.count; i++) {
//
//        SubMarketVC *subVC = [SubMarketVC new];
//        subVC.title = [titleArray objectAtIndex:i];
//        subVC.view.backgroundColor = [UIColor cyanColor];
//        [array addObject:subVC];
//    }
    SubMarketVC *vc1 = [SubMarketVC new];
    vc1.view.backgroundColor = [UIColor redColor];
    vc1.title = titleArray[0];
    SubMarketVC *vc2 = [SubMarketVC new];
    vc2.view.backgroundColor = [UIColor yellowColor];
    vc2.title = titleArray[1];
    SubMarketVC *vc3 = [SubMarketVC new];
    vc3.view.backgroundColor = [UIColor purpleColor];
    vc3.title = titleArray[2];
    SubMarketVC *vc4 = [SubMarketVC new];
    vc4.view.backgroundColor = [UIColor cyanColor];
    vc4.title = titleArray[3];
    
    NSArray *childVcs = [NSArray arrayWithObjects:vc1, vc2, vc3, vc4, nil];
    return childVcs;
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
