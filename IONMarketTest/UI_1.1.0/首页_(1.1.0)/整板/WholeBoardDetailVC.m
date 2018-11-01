//
//  WholeBoardDetailVC.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/10/23.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "WholeBoardDetailVC.h"

@interface WholeBoardDetailVC ()

@property (weak, nonatomic) IBOutlet HYStepper *stepper;
@property (weak, nonatomic) IBOutlet UILabel *guigeLabel;
@property (weak, nonatomic) IBOutlet UILabel *paihaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhuangtaiLabel;
@property (weak, nonatomic) IBOutlet UILabel *biaozhunLabel;
@property (weak, nonatomic) IBOutlet UILabel *biaomianLabel;
@property (weak, nonatomic) IBOutlet UILabel *fumoLabel;
@property (weak, nonatomic) IBOutlet UILabel *changjiaLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhongliangLabel;
@property (weak, nonatomic) IBOutlet UILabel *shengyuLabel;
@property (weak, nonatomic) IBOutlet UILabel *danjianLabel;
@property (weak, nonatomic) IBOutlet UILabel *gongjinLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIButton *shopBtn;

@end

@implementation WholeBoardDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.shopBtn.badgeValue = @"1";
    //配置信息
    [self configurateInfo];
}

- (IBAction)close:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)shopCar:(UIButton *)sender {
    
}

- (IBAction)excute:(UIButton *)sender {
    
}

- (void)configurateInfo {
    
    self.stepper.maxValue = [_wholeModel.kucun integerValue]>10?10:[_wholeModel.kucun integerValue];
    self.stepper.value = self.selectCount;
    _guigeLabel.text = _wholeModel.guige;
    _paihaoLabel.text = _wholeModel.xinghao;
    _zhuangtaiLabel.text = _wholeModel.zhuangtai;
    _biaozhunLabel.text = _wholeModel.gongyibiaozhun;
    _biaomianLabel.text = _wholeModel.lasi;
    _fumoLabel.text = _wholeModel.fumo;
    _changjiaLabel.text = _wholeModel.canzhaozhishu;
    _zhongliangLabel.text = [NSString stringWithFormat:@"%@kg",_wholeModel.zhongliang];
    _shengyuLabel.text = [NSString stringWithFormat:@"%@件",_wholeModel.kucun];
    _danjianLabel.text = [NSString stringWithFormat:@"%@元",_wholeModel.danpianzhengbanjiage];
    _gongjinLabel.text = [NSString stringWithFormat:@"%@元/公斤", _wholeModel.danjia];
    _gongjinLabel.attributedText = [UILabel getAttributedFromRange:[_gongjinLabel.text rangeOfString:@"元/公斤"] WithColor:[UIColor Grey_OrangeColor] andFont:[UIFont systemFontOfSize:10 weight:UIFontWeightSemibold] allFullText:_gongjinLabel.text];
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
