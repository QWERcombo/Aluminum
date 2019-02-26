//
//  TaoLiaoDetailVC.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2019/2/22.
//  Copyright © 2019年 赵越. All rights reserved.
//

#import "TaoLiaoDetailVC.h"
#import "DYScrollRulerView.h"

@interface TaoLiaoDetailVC ()

//@property (nonatomic, strong)DYScrollRulerView *noneZeroRullerView;
@property (weak, nonatomic) IBOutlet UILabel *totalMoney;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *topPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *topWeightLab;
@property (weak, nonatomic) IBOutlet UILabel *lowWeightLab;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end

@implementation TaoLiaoDetailVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"淘小料";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.slider setThumbImage:[UIImage imageNamed:@"slider_btn"] forState:UIControlStateNormal];
//    [self.view addSubview:self.noneZeroRullerView];
}

//-(DYScrollRulerView *)noneZeroRullerView{
//    if (!_noneZeroRullerView) {
//        NSString *unitStr = @"%";
//        CGFloat rullerHeight = [DYScrollRulerView rulerViewHeight];
//        _noneZeroRullerView = [[DYScrollRulerView alloc]initWithFrame:CGRectMake(5, 100, SCREEN_WIGHT-20, rullerHeight) theMinValue:10 theMaxValue:100  theStep:1 theUnit:unitStr theNum:5];
//        [_noneZeroRullerView setDefaultValue:50 animated:YES];
//        _noneZeroRullerView.bgColor = [UIColor whiteColor];
//        _noneZeroRullerView.triangleColor   = [UIColor mianColor:2];
//        _noneZeroRullerView.delegate        = self;
//        _noneZeroRullerView.scrollByHand    = YES;
//    }
//    return _noneZeroRullerView;
//}
//#pragma mark - YKScrollRulerDelegate
//-(void)dyScrollRulerView:(DYScrollRulerView *)rulerView valueChange:(float)value{
//    NSLog(@"value->%.f",value);
//
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 600;
}




//下一步
- (IBAction)next:(UIButton *)sender {
    
    
    
    
}

- (IBAction)sliderChanged:(UISlider *)sender {
    NSLog(@"%f", sender.value);
    
    
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
