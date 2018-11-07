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
@property (weak, nonatomic) IBOutlet UILabel *guigeLabel;

@property (nonatomic, copy) NSString *zhengZhi;// 1整只  2零切
@property (nonatomic, assign) BOOL isShowInfoView;

@property (nonatomic, strong) NSDictionary *dataDic;//保存获取的价格信息

@end

@implementation CommonItemTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.amountTF.delegate = self;
    self.lengthTF.delegate = self;
    self.lengthBtn.hidden = NO;
    self.lengthTF.hidden = YES;
    _zhengZhi = @"0";
    [self.lengthBtn setTitleColor:[UIColor colorWithHexString:@"#C7C7CC"] forState:UIControlStateNormal];
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self getOrderMoney];
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
        
        [SelectThickView showSelectThickViewWithSelectShowType:type erjimulu_id:self.erjimulu_id parDic:@{} selectBlock:^(NSString * _Nonnull selectIndexString) {
            switch (self.showType) {
                case ShowType_YuanBang:
                    self.guigeLabel.text = selectIndexString;
                    break;
                case ShowType_GuanCai:
                    self.guigeLabel.text = selectIndexString;
                    break;
                case ShowType_XingCai:
                    self.guigeLabel.text = selectIndexString;
                    break;
                default:
                    break;
            }
            [self getOrderMoney];
        }];
    }
}


#pragma mark - Handle
//自定义
- (IBAction)ziDingYi:(UIButton *)sender {
    
    _zhengZhi = @"2";
    _isShowInfoView = NO;
    _lengthBtn.hidden = YES;
    _lengthTF.hidden = NO;
    _lengthTF.text = @"";
    
    self.zidingyi_imgv.image = [UIImage imageNamed:@"select_1"];
    self.zidingyi_left_label.textColor = [UIColor mianColor:2];
    
    self.zhengzhi_imgv.image = [UIImage imageNamed:@"select_0"];
    self.zhengzhi_left_label.textColor = [UIColor colorWithHexString:@"#202124"];
 
    [self.tableView reloadData];
}

//整只
- (IBAction)zhengZhi:(UIButton *)sender {
    
    _zhengZhi = @"1";
    _isShowInfoView = NO;
    _lengthBtn.hidden = NO;
    _lengthTF.hidden = YES;
    [_lengthBtn setTitle:@"请选择长度" forState:UIControlStateNormal];
    [_lengthBtn setTitleColor:[UIColor colorWithHexString:@"#C7C7C7"] forState:UIControlStateNormal];
    
    self.zidingyi_imgv.image = [UIImage imageNamed:@"select_0"];
    self.zidingyi_left_label.textColor = [UIColor colorWithHexString:@"#202124"];
    
    self.zhengzhi_imgv.image = [UIImage imageNamed:@"select_1"];
    self.zhengzhi_left_label.textColor = [UIColor mianColor:2];

    [self.tableView reloadData];
}

//整只选择长度
- (IBAction)selectLength:(UIButton *)sender {
    
    if (!self.guigeLabel.text.length) {
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请先选择规格" time:0 aboutType:WHShowViewMode_Text state:NO];
        return;
    }
    if ([self.zhengZhi integerValue] == 0) {
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请先选择类型" time:0 aboutType:WHShowViewMode_Text state:NO];
        return;
    }
    
    NSDictionary *parDic = nil;
    switch (self.showType) {
        case ShowType_YuanBang:
            parDic = [NSDictionary dictionaryWithObject:self.guigeLabel.text forKey:@"zhijing"];
            break;
        case ShowType_XingCai:
            
            break;
        case ShowType_GuanCai:
            
            break;
        default:
            break;
    }
    
    [SelectThickView showSelectThickViewWithSelectShowType:SelectShowType_Length erjimulu_id:self.erjimulu_id parDic:parDic selectBlock:^(NSString * _Nonnull selectIndexString) {
        
        [self.lengthBtn setTitle:selectIndexString forState:UIControlStateNormal];
        [self.lengthBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [self getOrderMoney];
    }];
    
}


- (void)getOrderMoney {
    
    if (self.amountTF.text.length && self.guigeLabel.text.length && (self.lengthTF.text.length || self.lengthBtn.currentTitle.length)) {
        
        [[PublicFuntionTool sharedInstance] getOrderMoneyWithOrderType:GetOrderType_YuanBang chang:self.lengthTF.text.length?self.lengthTF.text:self.lengthBtn.currentTitle kuan:self.guigeLabel.text hou:nil amount:self.amountTF.text type:[_zhengZhi isEqualToString:@"1"]?@"整只":@"零切" erjimulu_id:self.erjimulu_id successBlock:^(NSDictionary *dataDic) {
            
            self.dataDic = dataDic;
            _isShowInfoView = YES;
            if ([_zhengZhi isEqualToString:@"2"]) {
                [self updateInfoView:@"整只"];
            } else {
                [self updateInfoView:@"自定义"];
            }
            
            [self.tableView reloadData];
        }];
        
    }
    
}


//刷新价格信息
- (void)updateInfoView:(NSString *)type {
    
    
    self.danjianzhongliang.text = [NSString stringWithFormat:@"%@kg", [self.dataDic objectForKey:@"danpianzhongliang"]];
    self.jianshu.text = [NSString stringWithFormat:@"%@件", self.amountTF.text];
    
    if ([type isEqualToString:@"整只"]) {
        
        self.danjianjiage.text = [NSString stringWithFormat:@"%@元/公斤", [self.dataDic objectForKey:@"danpianjiage_youqie"]];
        self.totalLabel.text = [NSString stringWithFormat:@"%@元", [self.dataDic objectForKey:@"orderMoney_youqie"]];
        
    } else {
        
        self.danjianjiage.text = [NSString stringWithFormat:@"%@元/公斤", [self.dataDic objectForKey:@"danpianjiage_kuaisu"]];
        self.totalLabel.text = [NSString stringWithFormat:@"%@元", [self.dataDic objectForKey:@"orderMoney_kuaisu"]];
        
    }
    
}


- (void)refreshInfoToReset {
    _zhengZhi = @"0";
    _isShowInfoView = NO;
    self.dataDic = nil;
    
    self.danjianjiage.text = @"";
    self.danjianzhongliang.text = @"";
    self.jianshu.text = @"";
    self.totalLabel.text = @"";
    
    self.amountTF.text = @"";
    self.lengthTF.text = @"";
    self.guigeLabel.text = @"";
    
    self.zhengzhi_imgv.image = [UIImage imageNamed:@"select_0"];
    self.zidingyi_imgv.image = [UIImage imageNamed:@"select_0"];
    self.zhengzhi_left_label.textColor = [UIColor colorWithHexString:@"#202124"];
    self.zidingyi_left_label.textColor = [UIColor colorWithHexString:@"#202124"];
    
    [self.lengthBtn setTitleColor:[UIColor colorWithHexString:@"#C7C7C7"] forState:UIControlStateNormal];
    [self.lengthBtn setTitle:@"请选择长度" forState:UIControlStateNormal];
    
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
