//
//  WholeBoardTableVC.m
//  IONMarketTest
//
//  Created by 赵越 on 2019/1/17.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "WholeBoardTableVC.h"

@interface WholeBoardTableVC ()


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
@property (weak, nonatomic) IBOutlet UIImageView *show_img;

@end

@implementation WholeBoardTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configurateInfo];
}

#pragma mark - Table view data source

- (void)configurateInfo {
    
    self.stepper.maxValue = [_wholeModel.kucun integerValue]>10?10:[_wholeModel.kucun integerValue];
    self.stepper.value = _wholeModel.value;
    [self.show_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL_IMAGE_Service,_wholeModel.picture]] placeholderImage:[UIImage imageNamed:@"temp_0"]];
    self.show_img.layer.cornerRadius = 5;
    self.show_img.layer.masksToBounds = YES;
//    _guigeLabel.text = [NSString stringWithFormat:@"%@*%@*%@", _wholeModel.arg3, _wholeModel.arg2, _wholeModel.arg1];
    _guigeLabel.text = _wholeModel.guige;
    _paihaoLabel.text = _wholeModel.xinghao;
    _zhuangtaiLabel.text = _wholeModel.zhuangtai;
    _biaozhunLabel.text = _wholeModel.gongyibiaozhun;
    _biaomianLabel.text = _wholeModel.lasi;
    _fumoLabel.text = _wholeModel.fumo;
    _changjiaLabel.text = _wholeModel.canzhaozhishu;
    _zhongliangLabel.text = [NSString stringWithFormat:@"%@kg",[NSString getStringAfterTwo:_wholeModel.zhongliang]];
    _shengyuLabel.text = [NSString stringWithFormat:@"%@件",[NSString getStringAfterTwo:_wholeModel.kucun]];
    _danjianLabel.text = [NSString stringWithFormat:@"%@元",[NSString getStringAfterTwo:_wholeModel.danpianzhengbanjiage]];
    _gongjinLabel.text = [NSString stringWithFormat:@"%@元/公斤", [NSString getStringAfterTwo:_wholeModel.danjia]];
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
