//
//  WuLiuCell.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/8/20.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "WuLiuCell.h"

@implementation WuLiuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 25;
}

+ (instancetype)WuLiuCell {
    WuLiuCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"WuLiuCell" owner:nil options:nil] firstObject];
    
    
    return cell;
}

- (void)loadData:(NSObject *)model name:(NSString *)name andCliker:(ClikBlock)click {
    
    NSString *wuliuno = (NSString *)model;
    
    self.showLabel.text = [NSString stringWithFormat:@"(%@) %@", name, wuliuno];
}
@end
