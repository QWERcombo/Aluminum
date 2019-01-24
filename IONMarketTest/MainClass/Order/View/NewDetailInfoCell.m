//
//  NewDetailInfoCell.m
//  IONMarketTest
//
//  Created by 赵越 on 2019/1/19.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "NewDetailInfoCell.h"

@implementation NewDetailInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)initCell:(UITableView *)tableView cellName:(NSString *)cellName dataObject:(id)dataObject {
    
    NewDetailInfoCell *cell = [super initCell:tableView cellName:cellName dataObject:dataObject];
    
    OrderModel *model = (OrderModel *)dataObject;
    
    if ([model.ziti isEqualToString:@"自提"]) {
        cell.address.text = @"自提地址：江苏省无锡市新吴区展鸿路18号院内乐切金属";
        cell.name.text = @"联系人：乐切金属";
        cell.phone.text = @"0510-88996061";
    } else {
        cell.address.text = [NSString stringWithFormat:@"收货地址 : %@",model.address];
        cell.name.text = [NSString stringWithFormat:@"联系人 : %@", model.currentAddress[@"name"]];
        cell.phone.text = model.userPhone;
    }
    cell.address.adjustsFontSizeToFitWidth = YES;
    cell.bianhao.text = model.no;
    cell.zhifufangshi.text = model.paymethod;
    cell.wuliu.text = model.wuliufei;
    cell.jiage.text = model.totalMoney;
    cell.shuliang.text = model.zongjianshu;
    cell.zhongliang.text = [NSString stringWithFormat:@"%@kg",model.zongzhongliang];
    
    if (cell.zhifufangshi.text.length) {
        cell.show_height.constant = 126;
        cell.pay_height.constant = 58;
        cell.showView.hidden = NO;
    } else {
        cell.show_height.constant = 126-58;
        cell.pay_height.constant = 0;
        cell.showView.hidden = YES;
    }
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    dateformatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    cell.shijian.text = [dateformatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[model.createDate integerValue]/1000]];
    cell.zhifushijian.text = [dateformatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[model.payTime integerValue]/1000]];
    
    return cell;
}

@end
