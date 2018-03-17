//
//  MainItemViewController.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/12.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "MainItemViewController.h"
#import "SpecialMakeViewController.h"

@interface MainItemViewController ()
@property (nonatomic, assign) NSInteger lastSelected;
@end

#define ITEM_WIDTH  60
#define ITEM_HEIGHT  30

@implementation MainItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"下单";
    
    UIButton *rightButton = [UIButton buttonWithTitle:@"特殊定制" andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    rightButton.tag = 1010;
    [rightButton addTarget:self action:@selector(buttonCliker:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.view.backgroundColor = [UIColor mianColor:1];
    
    [self setSubviews];
}

#pragma mark --- SubViews

- (void)setSubviews {
    
    [self createTopActionView];
    
    [self createScrollLayoutView];
}

- (void)createTopActionView {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 100)];
    topView.backgroundColor = [UIColor whiteColor];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 49.5, SCREEN_WIGHT, 1)];
    line.backgroundColor = [UIColor lightTextColor];
    [topView addSubview:line];
    
    NSArray *array = @[@"整板",@"零切",@"圆棒",@"型材",@"管材"];
    UIButton *lastBtn = nil;
    for (NSInteger i=0; i<5; i++) {
        
        UIButton *button = [UIButton buttonWithTitle:[array objectAtIndex:i] andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor mianColor:2] andHighlightedTitle:[UIColor mianColor:2] andNormaImage:nil andHighlightedImage:nil];
        
        if (i==self.selectedNum) {
            button.backgroundColor = [UIColor mianColor:2];
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
                make.left.equalTo(lastBtn.mas_right).offset((SCREEN_WIGHT-ITEM_WIDTH*5)/6);
            } else {
                make.left.equalTo(topView.mas_left).offset((SCREEN_WIGHT-ITEM_WIDTH*5)/6);
            }
        }];
        
        lastBtn = button;
    }
    self.lastSelected = 100+self.selectedNum;
    
    
    [self.view addSubview:topView];
}

- (void)createScrollLayoutView {
    
    
    
}

#pragma mark --- Action

- (void)buttonCliker:(UIButton *)sender {
    NSLog(@"%@", sender.currentTitle);
    if (sender.tag==1010) {
        SpecialMakeViewController *special = [SpecialMakeViewController new];
        [self.navigationController pushViewController:special animated:YES];
    } else {
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sender.backgroundColor = [UIColor mianColor:2];
        
        UIButton *lastButton = [self.view viewWithTag:self.lastSelected];
        [lastButton setTitleColor:[UIColor mianColor:2] forState:UIControlStateNormal];
        lastButton.backgroundColor = [UIColor whiteColor];
        
        self.lastSelected = sender.tag;
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
