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
    if ([typeID isEqualToString:@"30"]) {//圆棒
        [dict setValue:self.wholeModel.arg2 forKey:@"chang"];
        [dict setValue:self.wholeModel.arg1 forKey:@"kuang"];
    }
//    if ([typeID isEqualToString:@"30"]) {//型材
//
//    }
//    if ([typeID isEqualToString:@"30"]) {//管材
//
//    }
    if ([typeID isEqualToString:@"31"]) {//整板
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
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}

- (IBAction)add:(UIButton *)sender {
    
    [ShoppingCarSingle sharedShoppingCarSingle].totalbadge += 1;
    [ShoppingCarSingle sharedShoppingCarSingle].totalPrice = [NSNumber numberWithFloat:([self.shuliangLab.text floatValue]+[ShoppingCarSingle sharedShoppingCarSingle].totalPrice.floatValue)];
    
    if (self.click) {
        self.click(@"add");
    }
}

- (void)loadData:(WholeBoardModel *)data andCliker:(ClikBlock)click {
    self.wholeModel = data;
    self.click = click;
    NSArray *array = @[data.zhuangtai,data.guige,data.gongyibiaozhun,data.leibie,data.jiazhi,data.fumo, data.baozhuang,[NSString stringWithFormat:@"%@千克",data.zhongliang],[NSString stringWithFormat:@"%@元/千克",data.butiee.length?data.butiee:@"0"],[NSString stringWithFormat:@"%@元/千克",data.jiagongfei],[NSString stringWithFormat:@"%@件",data.kucun],data.canzhaozhishu];
    
    for (NSInteger i = 0; i<array.count; i++) {
        
        UILabel *label = [self viewWithTag:100+i];
        
        label.text = [array objectAtIndex:i];
    }
}

@end
