//
//  NewDetailListCell.m
//  IONMarketTest
//
//  Created by 赵越 on 2019/1/19.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "NewDetailListCell.h"

@implementation NewDetailListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (instancetype)initCell:(UITableView *)tableView cellName:(NSString *)cellName dataObject:(id)dataObject {
    
    NewDetailListCell *cell = [super initCell:tableView cellName:cellName dataObject:dataObject];
    
    ShopCar *dataM = (ShopCar *)dataObject;
    
    cell.jiage.text = [NSString stringWithFormat:@"%@元", [NSString getStringAfterTwo:dataM.money]];
    if ([dataM.height floatValue]>0) {
        cell.guige.text = [NSString stringWithFormat:@"%@x%@x%@",dataM.height, dataM.width, dataM.length];
    } else {
        cell.guige.text = [NSString stringWithFormat:@"规格：%@x%@", dataM.width, dataM.length];
    }
    cell.jianshu.text = [NSString stringWithFormat:@"共%@件",dataM.productNum];
    cell.xinghao.text = [NSString stringWithFormat:@"%@-%@", dataM.erjimulu, dataM.zhuangtai];
    cell.zhongliang.text = [NSString stringWithFormat:@"%@kg",dataM.zongzhongliang];
    
    if ([dataM.type isEqualToString:@"整只"]) {
        cell.show_img.image = IMG(@"order_整板");
    } else if ([dataM.type isEqualToString:@"快速"]) {
        cell.show_img.image = IMG(@"order_速切");
    } else if ([dataM.type isEqualToString:@"零切"]) {
        cell.show_img.image = IMG(@"order_速切");
    } else if ([dataM.type isEqualToString:@"半成品铝板"]) {
        cell.show_img.image = IMG(@"order_半成品");
    } else {
        cell.show_img.image = IMG(@"order_优切");
    }
    
    return cell;
}

@end
