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
    
    //↑ ↓
    cell.junjiaLabel.textColor = [UIColor Grey_RedColor];
    cell.zhangdieLabel.textColor = [UIColor Grey_GreenColor];
    cell.zhangdieLabel.text = @"↑ 777";
    
    return cell;
}



@end
