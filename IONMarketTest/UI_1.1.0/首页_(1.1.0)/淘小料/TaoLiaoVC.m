//
//  TaoLiaoVC.m
//  IONMarketTest
//
//  Created by 赵越 on 2019/2/17.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "TaoLiaoVC.h"
#import "TaoLiaoTabVC.h"
#import "ConditionDisplayView.h"
#import "SelectConditionView.h"

@interface TaoLiaoVC ()<TaoLiaoTabVCDelegate,SelectConditionViewDelegate>

@property (nonatomic, strong) TaoLiaoTabVC *tabVC;
@property (nonatomic, strong) SelectConditionView *conditionView;
@property (nonatomic, copy) NSArray *titleArray;

@property (nonatomic, assign) NSInteger mainIndex;
@property (nonatomic, assign) NSInteger subIndex;


@end

@implementation TaoLiaoVC

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
    self.title = @"淘小料";
    self.titleArray = [NSArray arrayWithObjects:@"牌号",@"状态", nil];
    
    
    [self.view addSubview:self.conditionView];
}


- (void)didSelectedConditionIndex:(NSInteger)index conditionTitle:(NSString *)title {
    NSLog(@"selected-----%ld",(long)index);
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"ZeroCutTabVC"]) {
        
        TaoLiaoTabVC *zero = segue.destinationViewController;
        self.tabVC = zero;
        self.tabVC.delegate = self;
    }
}


@end
