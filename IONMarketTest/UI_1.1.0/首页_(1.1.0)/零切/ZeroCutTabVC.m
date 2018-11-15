//
//  ZeroCutTabVC.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/10/23.
//  Copyright © 2018 赵越. All rights reserved.
//

#import "ZeroCutTabVC.h"
#import "SelectThickView.h"

@interface ZeroCutTabVC ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *lengthTF;
@property (weak, nonatomic) IBOutlet UITextField *widthTF;
@property (weak, nonatomic) IBOutlet UITextField *thinTF;
@property (weak, nonatomic) IBOutlet UITextField *countTF;
@property (weak, nonatomic) IBOutlet UILabel *suqieLab;
@property (weak, nonatomic) IBOutlet UIImageView *suqieImgv;
@property (weak, nonatomic) IBOutlet UILabel *youqieLab;
@property (weak, nonatomic) IBOutlet UIImageView *youqieImgv;
@property (weak, nonatomic) IBOutlet UILabel *danjianzhongliangLab;
@property (weak, nonatomic) IBOutlet UILabel *danjianjiageLab;
@property (weak, nonatomic) IBOutlet UILabel *jianshuLab;
@property (weak, nonatomic) IBOutlet UILabel *hejiLab;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIButton *suqie_btn;
@property (weak, nonatomic) IBOutlet UIButton *youqie_btn;

@property (nonatomic, strong) NSDictionary *dataDic;//保存获取的价格信息
@property (nonatomic, copy) NSString *orderMoney;//订单价格

@end

@implementation ZeroCutTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lengthTF.delegate = self;
    self.widthTF.delegate = self;
    self.countTF.delegate = self;
    
}

#pragma mark - Table view data source
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [self placeOrder:UseType_OrderMoney];
}


#pragma mark - Handle
//速切
- (IBAction)suqie:(UIButton *)sender {
    
    if(!_dataDic) return;
    
    _label1.textColor = [UIColor mianColor:2];
    _label2.textColor = [UIColor mianColor:2];
    _label3.textColor = [UIColor Grey_WordColor];
    _label4.textColor = [UIColor Grey_WordColor];
    
    _youqieImgv.image = [UIImage imageNamed:@"select_0"];
    _youqieLab.textColor = [UIColor Grey_WordColor];
    _suqieImgv.image = [UIImage imageNamed:@"select_1"];
    _suqieLab.textColor = [UIColor Grey_OrangeColor];
    
    
    [self updateInfoView:sender];
}
//优切
- (IBAction)youqie:(UIButton *)sender {
    
    if(!_dataDic) return;
    
    _label1.textColor = [UIColor Grey_WordColor];
    _label2.textColor = [UIColor Grey_WordColor];
    _label3.textColor = [UIColor mianColor:2];
    _label4.textColor = [UIColor mianColor:2];
    
    _youqieImgv.image = [UIImage imageNamed:@"select_1"];
    _youqieLab.textColor = [UIColor Grey_OrangeColor];
    _suqieImgv.image = [UIImage imageNamed:@"select_0"];
    _suqieLab.textColor = [UIColor Grey_WordColor];
    

    [self updateInfoView:sender];
}


//选择厚度
- (IBAction)selectThin:(UIButton *)sender {
    [self.view endEditing:YES];
    [SelectThickView showSelectThickViewWithSelectShowType:SelectShowType_LingQie getInfoType:GetInfoType_GuiGe erjimulu_id:self.erjimulu_id.id parDic:@{} selectBlock:^(NSString * _Nonnull selectIndexString) {
        self.thinTF.text = selectIndexString;
        [self placeOrder:UseType_OrderMoney];
    }];
    
}


- (void)updateInfoView:(UIButton *)sender {
    [self.view endEditing:YES];
    self.infoView.hidden = NO;
    
    NSRange range1 = [self.youqieLab.text rangeOfString:@"元/公斤"];
    NSRange range2 = [self.suqieLab.text rangeOfString:@"元/公斤"];
    _jianshuLab.text = [NSString stringWithFormat:@"%@件",self.countTF.text];
    _danjianzhongliangLab.text = [NSString stringWithFormat:@"%@kg", [self.dataDic objectForKey:@"danpianzhongliang"]];
    
    if (sender == self.youqie_btn) {
        //优切
        self.youqieLab.attributedText = [UILabel getAttributedFromRange:range1 WithColor:[UIColor Grey_OrangeColor] andFont:[UIFont systemFontOfSize:10 weight:UIFontWeightSemibold] allFullText:self.youqieLab.text];
        self.suqieLab.attributedText = [UILabel getAttributedFromRange:range2 WithColor:[UIColor Grey_WordColor] andFont:[UIFont systemFontOfSize:10 weight:UIFontWeightSemibold] allFullText:self.suqieLab.text];
        
        _orderMoney = [self.dataDic objectForKey:@"orderMoney_youqie"];
        _hejiLab.text = [NSString stringWithFormat:@"￥%@", _orderMoney];
        _danjianjiageLab.text = [NSString stringWithFormat:@"%@元", [self.dataDic objectForKey:@"danpianjiage_youqie"]];
    } else {
        //速切
        self.suqieLab.attributedText = [UILabel getAttributedFromRange:range2 WithColor:[UIColor Grey_OrangeColor] andFont:[UIFont systemFontOfSize:10 weight:UIFontWeightSemibold] allFullText:self.suqieLab.text];
        self.youqieLab.attributedText = [UILabel getAttributedFromRange:range1 WithColor:[UIColor Grey_WordColor] andFont:[UIFont systemFontOfSize:10 weight:UIFontWeightSemibold] allFullText:self.youqieLab.text];
        
        _orderMoney = [self.dataDic objectForKey:@"orderMoney_kuaisu"];
        _hejiLab.text = [NSString stringWithFormat:@"￥%@", _orderMoney];
        _danjianjiageLab.text = [NSString stringWithFormat:@"%@元", [self.dataDic objectForKey:@"danpianjiage_kuaisu"]];
    }
    
    //刷新总价格
    if (self.delegate && [self.delegate respondsToSelector:@selector(refreshBottomTotalPrice:)]) {
        [self.delegate refreshBottomTotalPrice:self.hejiLab.text];
    }
}

- (void)placeOrder:(UseType)useType {
//    [self.view endEditing:YES];
    
    if (self.lengthTF.text.length && self.widthTF.text.length && self.thinTF.text.length && self.countTF.text.length) {
        
        [[PublicFuntionTool sharedInstance] placeOrderCommonInterfaceWithUseType:useType moneyWithOrderType:GetOrderType_LingQie chang:self.lengthTF.text kuan:self.widthTF.text hou:self.thinTF.text amount:self.countTF.text type:@"全部" erjimulu:self.erjimulu_id orderMoney:self.orderMoney successBlock:^(NSDictionary *dataDic) {
            
            self.dataDic = dataDic;
            
            self.youqieLab.text = [NSString stringWithFormat:@"%@元/公斤", [self.dataDic objectForKey:@"danjia_youqie"]];
            self.suqieLab.text = [NSString stringWithFormat:@"%@元/公斤", [self.dataDic objectForKey:@"danjia_kuaisu"]];

            
            NSRange range1 = [self.youqieLab.text rangeOfString:@"元/公斤"];
            NSRange range2 = [self.suqieLab.text rangeOfString:@"元/公斤"];
            self.youqieLab.attributedText = [UILabel getAttributedFromRange:range1 WithColor:[UIColor Grey_WordColor] andFont:[UIFont systemFontOfSize:10 weight:UIFontWeightSemibold] allFullText:self.youqieLab.text];
            self.suqieLab.attributedText = [UILabel getAttributedFromRange:range2 WithColor:[UIColor Grey_OrangeColor] andFont:[UIFont systemFontOfSize:10 weight:UIFontWeightSemibold] allFullText:self.suqieLab.text];
            
            //默认选中速切
            [self suqie:self.suqie_btn];
            [self updateInfoView:self.suqie_btn];
            
            if ([self.lengthTF.text integerValue]<150 && [self.widthTF.text integerValue]<150) {
                //小于150*150  不可选优切
                self.youqie_btn.hidden = YES;
                self.youqieLab.text = @"不可优切";
                
            } else {
                self.youqie_btn.hidden = NO;
            }
            
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

}


//重置信息
- (void)refreshInfoToReset {
    self.infoView.hidden = YES;
    _label1.textColor = [UIColor Grey_WordColor];
    _label2.textColor = [UIColor Grey_WordColor];
    _label3.textColor = [UIColor Grey_WordColor];
    _label4.textColor = [UIColor Grey_WordColor];
    
    _youqieImgv.image = [UIImage imageNamed:@"select_0"];
    _youqieLab.textColor = [UIColor Grey_WordColor];
    _youqieLab.text = @"";
    _suqieImgv.image = [UIImage imageNamed:@"select_0"];
    _suqieLab.textColor = [UIColor Grey_WordColor];
    _suqieLab.text = @"";
    
    self.lengthTF.text = @"";
    self.widthTF.text = @"";
    self.thinTF.text = @"";
    self.countTF.text = @"";
    self.dataDic = nil;
    
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
