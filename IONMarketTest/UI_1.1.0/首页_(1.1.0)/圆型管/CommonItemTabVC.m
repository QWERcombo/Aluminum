//
//  CommonItemTabVC.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/11/4.
//  Copyright © 2018 赵越. All rights reserved.
//

#import "CommonItemTabVC.h"
#import "SelectThickView.h"

@interface CommonItemTabVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *zhengzhi_imgv;
@property (weak, nonatomic) IBOutlet UIImageView *zidingyi_imgv;
@property (weak, nonatomic) IBOutlet UILabel *zidingyi_right_label;
@property (weak, nonatomic) IBOutlet UILabel *zhengzhi_right_label;
@property (weak, nonatomic) IBOutlet UILabel *zhengzhi_left_label;
@property (weak, nonatomic) IBOutlet UILabel *zidingyi_left_label;
@property (weak, nonatomic) IBOutlet UITextField *lengthTF;
@property (weak, nonatomic) IBOutlet UIButton *lengthBtn;
@property (weak, nonatomic) IBOutlet UITextField *amountTF;
@property (weak, nonatomic) IBOutlet UILabel *danjianzhongliang;
@property (weak, nonatomic) IBOutlet UILabel *danjianjiage;
@property (weak, nonatomic) IBOutlet UILabel *jianshu;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UITextField *guigeTF;


@property (nonatomic, copy) NSString *zhengZhi;// 1整只  2零切
@property (nonatomic, assign) BOOL isShowInfoView;

@property (nonatomic, strong) NSDictionary *dataDic;//保存获取的价格信息
@property (nonatomic, copy) NSString *orderMoney;//订单价格
@property (nonatomic, copy) NSString *zhengzhiDanJia;//整只单价
@property (nonatomic, copy) NSString *zidingyiDanJia;//自定义单价
@property (weak, nonatomic) IBOutlet UILabel *guigeLab;



@end

@implementation CommonItemTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.amountTF.delegate = self;
    self.lengthTF.delegate = self;
    self.lengthBtn.hidden = NO;
    _zhengZhi = @"1";
    switch (self.showType) {
        case ShowType_YuanBang:
            self.guigeTF.placeholder = @"请选择直径";
            self.guigeLab.text = @"直径";
            break;
        case ShowType_XingCai:
            self.guigeTF.placeholder = @"请选择规格";
            self.guigeLab.text = @"规格";
            break;
        case ShowType_GuanCai:
            self.guigeTF.placeholder = @"请选择规格";
            self.guigeLab.text = @"规格";
            break;
        default:
            break;
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self judgePlaceOrder];
}


#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            return 8;
            break;
        case 1:
            return 50;
            break;
        case 2:
            return 50;
            break;
        case 3:
            return 50;
            break;
        case 4:
            return 6;
            break;
        case 5:
            //长度
            return 50;
            break;
        case 6:
            return 60;
            break;
        case 7:
            //价格信息
            return _isShowInfoView?138:0;
            break;
        default:
            return 0;
            break;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        //获取规格数据
        SelectShowType type;
        switch (self.showType) {
            case ShowType_YuanBang:
                type = SelectShowType_YuanBang;
                break;
            case ShowType_GuanCai:
                type = SelectShowType_GuanCai;
                break;
            case ShowType_XingCai:
                type = SelectShowType_XingCai;
                break;
            default:
                break;
        }
        
        [self.view endEditing:YES];
        [SelectThickView showSelectThickViewWithSelectShowType:type getInfoType:GetInfoType_GuiGe erjimulu_id:self.erjimulu_id.id parDic:@{} selectBlock:^(NSString * _Nonnull selectIndexString) {
            switch (self.showType) {
                case ShowType_YuanBang:
                    self.guigeTF.text = selectIndexString;
                    break;
                case ShowType_GuanCai:
                    self.guigeTF.text = selectIndexString;
                    break;
                case ShowType_XingCai:
                    self.guigeTF.text = selectIndexString;
                    break;
                default:
                    break;
            }
            
            
            [self.lengthBtn setTitle:@"" forState:UIControlStateNormal];
            _lengthTF.placeholder = @"请选择长度";
            _amountTF.text = @"";
            _isShowInfoView = NO;
            [self judgePlaceOrder];
        }];
    }
}


#pragma mark - Handle
//自定义
- (IBAction)ziDingYi:(UIButton *)sender {
    
    _zhengZhi = @"2";
    _isShowInfoView = NO;
    _lengthBtn.hidden = YES;
    [_lengthBtn setTitle:@"" forState:UIControlStateNormal];
    _lengthTF.text = @"";
    _lengthTF.placeholder = @"请输入长度";
    
    self.zidingyi_imgv.image = [UIImage imageNamed:@"select_1"];
    self.zidingyi_left_label.textColor = [UIColor mianColor:2];
    self.zidingyi_right_label.textColor = [UIColor Grey_OrangeColor];
    
    self.zhengzhi_imgv.image = [UIImage imageNamed:@"select_0"];
    self.zhengzhi_left_label.textColor = [UIColor colorWithHexString:@"#202124"];
    self.zhengzhi_right_label.textColor = [UIColor Grey_WordColor];
 

    [self judgePlaceOrder];
    [self.tableView reloadData];
}

//整只
- (IBAction)zhengZhi:(UIButton *)sender {
    
    _zhengZhi = @"1";
    _isShowInfoView = NO;
    _lengthBtn.hidden = NO;
    _lengthTF.text = @"";
    _lengthTF.placeholder = @"请选择长度";
    
    self.zidingyi_imgv.image = [UIImage imageNamed:@"select_0"];
    self.zidingyi_left_label.textColor = [UIColor colorWithHexString:@"#202124"];
    self.zidingyi_right_label.textColor = [UIColor Grey_WordColor];
    
    self.zhengzhi_imgv.image = [UIImage imageNamed:@"select_1"];
    self.zhengzhi_left_label.textColor = [UIColor mianColor:2];
    self.zhengzhi_right_label.textColor = [UIColor Grey_OrangeColor];


    [self judgePlaceOrder];
    [self.tableView reloadData];
}

//整只选择长度
- (IBAction)selectLength:(UIButton *)sender {
    [self.view endEditing:YES];
    if (!self.guigeTF.text.length) {
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请先选择规格" time:0 aboutType:WHShowViewMode_Text state:NO];
        return;
    }
    if ([self.zhengZhi integerValue] == 0) {
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请先选择类型" time:0 aboutType:WHShowViewMode_Text state:NO];
        return;
    }
    
    SelectShowType type;
    NSDictionary *parDic = nil;
    //型材 管材有值
    NSArray *infoArr = [self.guigeTF.text componentsSeparatedByString:@"*"];
    switch (self.showType) {
        case ShowType_YuanBang:
            type = SelectShowType_YuanBang;
            parDic = [NSDictionary dictionaryWithObject:self.guigeTF.text forKey:@"zhijing"];
            break;
        case ShowType_XingCai:
            type = SelectShowType_XingCai;
            parDic = [NSDictionary dictionaryWithObjectsAndKeys:[infoArr firstObject],@"hou",[infoArr lastObject],@"kuang", nil];
            break;
        case ShowType_GuanCai:
            type = SelectShowType_GuanCai;
            parDic = [NSDictionary dictionaryWithObjectsAndKeys:[infoArr firstObject],@"waijing",[infoArr lastObject],@"neijing", nil];
            break;
        default:
            break;
    }
    

    [SelectThickView showSelectThickViewWithSelectShowType:type getInfoType:GetInfoType_Length erjimulu_id:self.erjimulu_id.id parDic:parDic selectBlock:^(NSString * _Nonnull selectIndexString) {
        
        [self.lengthBtn setTitle:selectIndexString forState:UIControlStateNormal];
        self.lengthTF.placeholder = @"";
        
        [self judgePlaceOrder];
    }];
    
}


- (void)judgePlaceOrder {
    [self.view endEditing:YES];
    if (self.amountTF.text.length && self.guigeTF.text.length && (self.lengthTF.text.length || self.lengthBtn.currentTitle.length)) {
        [self placeOrder:UseType_OrderMoney];
    } else {
        [self placeOrder:UseType_DanJia];
    }
}


- (void)placeOrder:(UseType)useType {
    
    NSString *showType = [_zhengZhi isEqualToString:@"1"]?@"整只":@"零切";
    
    if (useType == UseType_DanJia) {
//        showType = @"全部";
    } else {
        if (self.amountTF.text.length && self.guigeTF.text.length && (self.lengthTF.text.length || self.lengthBtn.currentTitle.length)) {
            
        } else {
            [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"参数配置不齐全" time:0 aboutType:WHShowViewMode_Text state:NO];
            return;
        }
    }
    
    GetOrderType type;
    NSString *chang = self.lengthTF.text.length?self.lengthTF.text:self.lengthBtn.currentTitle;
    NSString *kuan = @"";
    NSString *hou = nil;
    NSArray *infoArr = [self.guigeTF.text componentsSeparatedByString:@"*"];
    
    switch (self.showType) {
        case ShowType_YuanBang:
            type = GetOrderType_YuanBang;
            kuan = self.guigeTF.text;
            break;
        case ShowType_XingCai:
            type = GetOrderType_XingCai;
            hou = [infoArr firstObject];
            kuan = [infoArr lastObject];
            break;
        case ShowType_GuanCai:
            type = GetOrderType_GuanCai;
            hou = self.lengthTF.text.length?self.lengthTF.text:self.lengthBtn.currentTitle;
            chang = [infoArr firstObject];
            kuan = [infoArr lastObject];
            break;
        default:
            break;
    }
    
    
    [[PublicFuntionTool sharedInstance] placeOrderCommonInterfaceWithUseType:useType moneyWithOrderType:type chang:chang kuan:kuan hou:hou amount:self.amountTF.text type:showType erjimulu:self.erjimulu_id orderMoney:self.orderMoney successBlock:^(NSDictionary *dataDic) {
        
        self.dataDic = dataDic;
        if (useType == UseType_OrderMoney) _isShowInfoView = YES;
        if (useType == UseType_OrderMoney && !self.dataDic[@"orderMoney"]) {
            _isShowInfoView = NO;
        }
        
        if ([_zhengZhi isEqualToString:@"1"]) {
            self.zhengzhiDanJia = [NSString stringWithFormat:@"%@", [self.dataDic objectForKey:@"danjia"]];
            if ([self.dataDic objectForKey:@"danpianjiage_youqie"]) {
                self.zidingyiDanJia = [NSString stringWithFormat:@"%@", [self.dataDic objectForKey:@"danpianjiage_youqie"]];
            }
            [self updateInfoView:@"整只"];
        } else {
            self.zidingyiDanJia = [NSString stringWithFormat:@"%@", [self.dataDic objectForKey:@"danjia"]];
            [self updateInfoView:@"自定义"];
        }
        
        
        [self.tableView reloadData];
        
    } buyNowSuccessBlock:^(ShopCar *shopCar) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(goToBuyNow:)]) {
            [self.delegate goToBuyNow:shopCar];
        }
    } addCarSuccessBlock:^() {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(refreshBottomShopCarNumber)]) {
            [self.delegate refreshBottomShopCarNumber];
        }
        
        [self refreshInfoToReset];
    }];
    
}


//刷新价格信息
- (void)updateInfoView:(NSString *)type {
    
    self.danjianzhongliang.text = [NSString stringWithFormat:@"%@kg", [self.dataDic objectForKey:@"danpianzhongliang"]];
    self.jianshu.text = [NSString stringWithFormat:@"%@件", self.amountTF.text];
    
    if ([type isEqualToString:@"整只"]) {
        
        self.danjianjiage.text = [NSString stringWithFormat:@"%@元/公斤", [self.dataDic objectForKey:@"danpianjiage"]];
        self.orderMoney = [self.dataDic objectForKey:@"orderMoney"];
        if (self.orderMoney) {
            self.totalLabel.text = [NSString stringWithFormat:@"%@元", self.orderMoney];
        }
        self.zhengzhi_right_label.text = [NSString stringWithFormat:@"%@元/公斤", self.zhengzhiDanJia];
        self.zhengzhi_right_label.attributedText = [UILabel getAttributedFromRange:[self.zhengzhi_right_label.text rangeOfString:@"元/公斤"] WithColor:[UIColor Grey_OrangeColor] andFont:[UIFont systemFontOfSize:10 weight:UIFontWeightSemibold] allFullText:self.zhengzhi_right_label.text];
        self.zidingyi_right_label.text = [NSString stringWithFormat:@"%@元/公斤", self.zidingyiDanJia];
        self.zidingyi_right_label.textColor = [UIColor Grey_WordColor];
        self.zidingyi_right_label.attributedText = [UILabel getAttributedFromRange:[self.zidingyi_right_label.text rangeOfString:@"元/公斤"] WithColor:[UIColor Grey_WordColor] andFont:[UIFont systemFontOfSize:10 weight:UIFontWeightSemibold] allFullText:self.zidingyi_right_label.text];
        
    } else {
        
        self.danjianjiage.text = [NSString stringWithFormat:@"%@元/公斤", [self.dataDic objectForKey:@"danpianjiage"]];
        self.orderMoney = [self.dataDic objectForKey:@"orderMoney"];
        if (self.orderMoney) {
            self.totalLabel.text = [NSString stringWithFormat:@"%@元", self.orderMoney];
        }
        self.zidingyi_right_label.text = [NSString stringWithFormat:@"%@元/公斤", self.zidingyiDanJia];
        self.zidingyi_right_label.attributedText = [UILabel getAttributedFromRange:[self.zidingyi_right_label.text rangeOfString:@"元/公斤"] WithColor:[UIColor Grey_OrangeColor] andFont:[UIFont systemFontOfSize:10 weight:UIFontWeightSemibold] allFullText:self.zidingyi_right_label.text];
        
    }
    
    //刷新总价格
    if (self.delegate && [self.delegate respondsToSelector:@selector(refreshBottomTotalPrice:)] && self.isShowInfoView) {
        [self.delegate refreshBottomTotalPrice:self.totalLabel.text];
    }
}


- (void)refreshInfoToReset {
    _zhengZhi = @"1";
    _isShowInfoView = NO;
    self.dataDic = nil;
    self.zhengzhiDanJia = @"";
    self.zidingyiDanJia = @"";
    
    self.danjianjiage.text = @"";
    self.danjianzhongliang.text = @"";
    self.jianshu.text = @"";
    self.totalLabel.text = @"";
    
    self.amountTF.text = @"";
    self.lengthTF.text = @"";
    self.guigeTF.text = @"";
    
    self.zhengzhi_imgv.image = [UIImage imageNamed:@"select_1"];
    self.zidingyi_imgv.image = [UIImage imageNamed:@"select_0"];
    self.zhengzhi_left_label.textColor = [UIColor mianColor:2];
    self.zhengzhi_right_label.text = @"";
    self.zidingyi_left_label.textColor = [UIColor colorWithHexString:@"#202124"];
    self.zidingyi_right_label.text = @"";
    
    _lengthTF.placeholder = @"请选择长度";
    [_lengthBtn setTitle:@"" forState:UIControlStateNormal];
    
    [self.tableView reloadData];
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
