//
//  SubMarktListCell.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/10/28.
//  Copyright © 2018 赵越. All rights reserved.
//

#import "SubMarktListCell.h"

@implementation SubMarktListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

+ (instancetype)initCell:(UITableView *)tableView cellName:(NSString *)cellName  dataObject:(id)dataObject {
    
    SubMarktListCell *cell = [super initCell:tableView cellName:cellName dataObject:dataObject];
    
    PriceModel *dataModel = (PriceModel *)dataObject;
    
    cell.dateLabel.text = [[NSDate dateWithTimeIntervalSince1970:[dataModel.riqi integerValue]/1000] formattedDateWithFormat:@"M-dd"];
    cell.jiageLabel.text = dataModel.priceRange;
    cell.junjiaLabel.text = dataModel.averagePrice;
    if ([[dataModel.priceChange substringToIndex:1] isEqualToString:@"-"]) {
        cell.zhangdieLabel.textColor = [UIColor Grey_GreenColor];
        cell.zhangdieLabel.text = [NSString stringWithFormat:@"↓ %@",[dataModel.priceChange substringFromIndex:1]];
    } else {
        cell.zhangdieLabel.textColor = [UIColor Grey_RedColor];
        cell.zhangdieLabel.text = [NSString stringWithFormat:@"↑ %@",dataModel.priceChange];
    }
    
    
    return cell;
}



@end
