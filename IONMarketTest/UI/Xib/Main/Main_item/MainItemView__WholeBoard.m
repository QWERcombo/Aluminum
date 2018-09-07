//
//  MainItemView__WholeBoard.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/17.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "MainItemView__WholeBoard.h"

@implementation MainItemView__WholeBoard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"MainItemView__WholeBoard" owner:self options:nil] firstObject];
        
        self.addButton.hidden = ![[UserData currentUser].isCheck boolValue];
        self.frame = frame;
    }
    
    return self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSMutableString *input = [[NSMutableString alloc] initWithString:textField.text];
    [input replaceCharactersInRange:range withString:string];
    
    if (input.length) {
        [self getWholeBoardOrderMoney:input];
    } else {
        self.zhongliangLab.text = @"单片重量*单价*数量";
        self.shuliangLab.text = @"总价";
    }
    return YES;
}

- (void)getWholeBoardOrderMoney:(NSString *)amount {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:self.wholeModel.zhonglei forKey:@"zhonglei"];
    [dict setValue:amount forKey:@"amount"];
    [dict setValue:@"整只" forKey:@"type"];
    NSDictionary *idDic = self.wholeModel.lvxing;
    NSString *typeID = [NSString stringWithFormat:@"%@",idDic[@"id"]];
    [dict setValue:typeID forKey:@"erjimulu"];
    if ([self.wholeModel.zhonglei isEqualToString:@"圆棒"]) {//圆棒
        [dict setValue:self.wholeModel.arg2 forKey:@"chang"];
        [dict setValue:self.wholeModel.arg1 forKey:@"kuang"];
    }
    if ([self.wholeModel.zhonglei isEqualToString:@"型材"]) {//型材
        [dict setValue:self.wholeModel.arg1 forKey:@"hou"];
        [dict setValue:self.wholeModel.arg2 forKey:@"kuang"];
        [dict setValue:self.wholeModel.arg3 forKey:@"chang"];
    }
    if ([self.wholeModel.zhonglei isEqualToString:@"管材"]) {//管材
        [dict setValue:self.wholeModel.arg1 forKey:@"waijing"];
        [dict setValue:self.wholeModel.arg2 forKey:@"neijing"];
        [dict setValue:self.wholeModel.arg3 forKey:@"chang"];
    }
    if ([self.wholeModel.zhonglei isEqualToString:@"整板"]) {//整板
        [dict setValue:self.wholeModel.arg1 forKey:@"hou"];
        [dict setValue:self.wholeModel.arg2 forKey:@"kuang"];
        [dict setValue:self.wholeModel.arg3 forKey:@"chang"];
    }
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:Interface_OrderMoney andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
//        NSLog(@"+++%@", resultDic);

        NSString *orderMoneyStr = resultDic[@"orderMoney"];
        NSString *orderMoney = [NSString stringWithFormat:@"%.2lf",  [orderMoneyStr floatValue]];
        NSString *orderWeight = [NSString stringWithFormat:@"%@", resultDic[@"rule"]];
        self.zhongliangLab.text = orderWeight;
        self.shuliangLab.text = [NSString stringWithFormat:@"%@元",orderMoney];
        self.isGetOrderMoney = YES;
        
        if (self.click) {
            self.click([NSString stringWithFormat:@"%@,%@", orderMoney,amount]);
        }
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}

- (IBAction)add:(UIButton *)sender {
    if (!self.isGetOrderMoney) {
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请先获取价格!" time:0 aboutType:WHShowViewMode_Text state:NO];
    } else {
        if (self.click) {
            self.click(@"add");
        }
    }
}

- (void)loadData:(WholeBoardModel *)data andCliker:(ClikBlock)click {
    self.wholeModel = data;
    self.click = click;
    NSArray *array = @[data.zhuangtai,data.guige,data.gongyibiaozhun,data.leibie,data.jiazhi,data.fumo, data.baozhuang,[NSString stringWithFormat:@"%@千克",data.zhongliang],[NSString stringWithFormat:@"%@元/千克",[NSString getStringAfterTwo:data.jiagongfei]],[NSString stringWithFormat:@"%@件",data.kucun],data.canzhaozhishu];
    
    for (NSInteger i = 0; i<array.count; i++) {
        
        UILabel *label = [self viewWithTag:100+i];
        
        label.text = [array objectAtIndex:i];
    }
}

@end
