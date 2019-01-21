//
//  PostListCell.m
//  IONMarketTest
//
//  Created by 赵越 on 2019/1/19.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "PostListCell.h"

@implementation PostListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)initCell:(UITableView *)tableView cellName:(NSString *)cellName dataObject:(id)dataObject {
    
    PostListCell *cell = [super initCell:tableView cellName:cellName dataObject:dataObject];
    
    NSDictionary *dataDic = (NSDictionary *)dataObject;
    
    cell.contentLab.text = [dataDic objectForKey:@"AcceptStation"];
    cell.dateLab.text = [dataDic objectForKey:@"AcceptTime"];
    
    return cell;
}


@end
