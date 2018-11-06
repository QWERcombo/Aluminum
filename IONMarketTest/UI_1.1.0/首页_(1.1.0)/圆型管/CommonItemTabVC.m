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
@property (weak, nonatomic) IBOutlet UITextField *amountTF;
@property (weak, nonatomic) IBOutlet UILabel *danjianzhongliang;
@property (weak, nonatomic) IBOutlet UILabel *danjianjiage;
@property (weak, nonatomic) IBOutlet UILabel *jianshu;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *guigeLabel;

@property (nonatomic, assign) BOOL isShowLength;
@property (nonatomic, assign) BOOL isShowInfoView;

@property (nonatomic, strong) NSDictionary *dataDic;//保存获取的价格信息

@end

@implementation CommonItemTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.amountTF.delegate = self;
    self.lengthTF.delegate = self;
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
            return _isShowLength?50:0;
            break;
        case 6:
            return 60;
            break;
        case 7:
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
        
        [SelectThickView showSelectThickViewWithSelectShowType:type erjimulu_id:self.erjimulu_id selectBlock:^(NSString * _Nonnull selectIndexString) {
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
    
    if (!self.dataDic) return;
    
    _isShowLength = YES;
    _isShowInfoView = YES;
    
    self.zidingyi_imgv.image = [UIImage imageNamed:@"select_1"];
    self.zidingyi_left_label.textColor = [UIColor mianColor:2];
    self.zidingyi_right_label.textColor = [UIColor Grey_OrangeColor];
    self.zidingyi_right_label.text = @"20.50元/公斤";
    self.zidingyi_right_label.attributedText = [UILabel getAttributedFromRange:[self.zidingyi_right_label.text rangeOfString:@"元/公斤"] WithColor:[UIColor Grey_OrangeColor] andFont:[UIFont systemFontOfSize:10] allFullText:self.zidingyi_right_label.text];
    
    self.zhengzhi_imgv.image = [UIImage imageNamed:@"select_0"];
    self.zhengzhi_left_label.textColor = [UIColor colorWithHexString:@"#202124"];
    self.zhengzhi_right_label.textColor = [UIColor Grey_WordColor];
    self.zhengzhi_right_label.text = @"19.50元/公斤";
    self.zhengzhi_right_label.attributedText = [UILabel getAttributedFromRange:[self.zhengzhi_right_label.text rangeOfString:@"元/公斤"] WithColor:[UIColor Grey_WordColor] andFont:[UIFont systemFontOfSize:10] allFullText:self.zhengzhi_right_label.text];
    
    [self updateInfoView:@"自定义"];
    [self.tableView reloadData];
}

//整只
- (IBAction)zhengZhi:(UIButton *)sender {
    
    if (!self.dataDic) return;
    
    _isShowLength = NO;
    _isShowInfoView = YES;
    
    self.zidingyi_imgv.image = [UIImage imageNamed:@"select_0"];
    self.zidingyi_left_label.textColor = [UIColor colorWithHexString:@"#202124"];
    self.zidingyi_right_label.textColor = [UIColor Grey_WordColor];
    self.zidingyi_right_label.text = @"20.50元/公斤";
    self.zidingyi_right_label.attributedText = [UILabel getAttributedFromRange:[self.zidingyi_right_label.text rangeOfString:@"元/公斤"] WithColor:[UIColor Grey_WordColor] andFont:[UIFont systemFontOfSize:10] allFullText:self.zidingyi_right_label.text];
    
    self.zhengzhi_imgv.image = [UIImage imageNamed:@"select_1"];
    self.zhengzhi_left_label.textColor = [UIColor mianColor:2];
    self.zhengzhi_right_label.textColor = [UIColor Grey_OrangeColor];
    self.zhengzhi_right_label.text = [NSString stringWithFormat:@"%@元/公斤", [self.dataDic objectForKey:@""]];
    self.zhengzhi_right_label.attributedText = [UILabel getAttributedFromRange:[self.zhengzhi_right_label.text rangeOfString:@"元/公斤"] WithColor:[UIColor Grey_OrangeColor] andFont:[UIFont systemFontOfSize:10] allFullText:self.zhengzhi_right_label.text];
    
    [self updateInfoView:@"整只"];
    [self.tableView reloadData];
}


- (void)getOrderMoney {
    
    if (self.amountTF.text.length && self.guigeLabel.text.length && self.lengthTF.text.length) {
        
        [[PublicFuntionTool sharedInstance] getOrderMoneyWithOrderType:GetOrderType_YuanBang chang:self.lengthTF.text kuan:self.guigeLabel.text hou:nil amount:self.amountTF.text type:_isShowLength?@"零切":@"整只" erjimulu_id:self.erjimulu_id successBlock:^(NSDictionary *dataDic) {
            
            self.dataDic = dataDic;
            
            
            
        }];
        
    }
    
}


//刷新价格信息
- (void)updateInfoView:(NSString *)type {
    
    
    self.danjianzhongliang.text = [NSString stringWithFormat:@"%@kg", [self.dataDic objectForKey:@""]];
    self.jianshu.text = [NSString stringWithFormat:@"%@件", self.amountTF.text];
    
    if ([type isEqualToString:@"整只"]) {
        
        self.danjianjiage.text = [NSString stringWithFormat:@"%@元/公斤", [self.dataDic objectForKey:@""]];
        self.totalLabel.text = [NSString stringWithFormat:@"%@元", [self.dataDic objectForKey:@""]];
        
    } else {
        
        self.danjianjiage.text = [NSString stringWithFormat:@"%@元/公斤", [self.dataDic objectForKey:@""]];
        self.totalLabel.text = [NSString stringWithFormat:@"%@元", [self.dataDic objectForKey:@""]];
        
    }
    
}


- (void)refreshInfoToReset {
    _isShowLength = NO;
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
    self.zhengzhi_right_label.text = @"";
    self.zidingyi_right_label.text = @"";
    self.zhengzhi_left_label.textColor = [UIColor colorWithHexString:@"#202124"];
    self.zidingyi_left_label.textColor = [UIColor colorWithHexString:@"#202124"];
    
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
