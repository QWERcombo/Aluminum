//
//  WholeBoardListCell.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/10/19.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "WholeBoardListCell.h"

@implementation WholeBoardListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.showView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.showView.layer.shadowOpacity = 0.3;
    self.showView.layer.shadowOffset = CGSizeMake(0, .5);
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

+ (instancetype)initCell:(UITableView *)tableView cellName:(NSString *)cellName  dataObject:(id)dataObject {
    
    WholeBoardListCell *cell = [super initCell:tableView cellName:cellName dataObject:dataObject];
    
    
    
    
    
    return cell;
}




@end
