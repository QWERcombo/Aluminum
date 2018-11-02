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

+ (instancetype)initCell:(UITableView *)tableView cellName:(NSString *)cellName dataObject:(id)dataObject {
    
    WholeBoardListCell *cell = [super initCell:tableView cellName:cellName dataObject:dataObject];
    
    WholeBoardModel *dataModel = (WholeBoardModel *)dataObject;
    
    cell.guigeLabel.text = dataModel.guige;
    cell.changjiaLabel.text = [NSString stringWithFormat:@"厂家: %@", dataModel.canzhaozhishu];
    cell.priceLabel.text = [NSString stringWithFormat:@"%@元/件", dataModel.danpianzhengbanjiage];
    cell.stepper.maxValue = [dataModel.kucun integerValue]>10?10:[dataModel.kucun integerValue];
    cell.kucunLabel.text = [NSString stringWithFormat:@"(%@件)", dataModel.kucun];
    if ([dataModel.value integerValue]>0) {
        cell.addBtn.hidden = YES;
        cell.stepper.hidden = NO;
        cell.stepper.value = [dataModel.value floatValue];
    } else {
        cell.addBtn.hidden = NO;
        cell.stepper.hidden = YES;
    }
    
    NSArray *array = @[dataModel.gongyibiaozhun,dataModel.lasi,dataModel.fumo];
    
    CGFloat totalMargin = 0;
    for (NSInteger i=0; i<array.count; i++) {
        
        CGSize size = [[array objectAtIndex:i] boundingRectWithSize:CGSizeMake(0, 17) font:[UIFont systemFontOfSize:12] lineSpacing:0];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16+totalMargin+(5*i), cell.height-27, size.width+12, 17)];
        label.text = [array objectAtIndex:i];
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor colorWithHexString:@"#595E64"];
        label.backgroundColor = [UIColor colorWithHexString:@"#EDEDED"];
        label.textAlignment = NSTextAlignmentCenter;
        
        totalMargin += (size.width+12);
        [cell.contentView addSubview:label];
    }
    
    cell.danjiaLabel.text = [NSString stringWithFormat:@"￥%@元/公斤", dataModel.danjia];
    NSRange range = [cell.danjiaLabel.text rangeOfString:@"元/公斤"];
    cell.danjiaLabel.attributedText = [UILabel getAttributedFromRange:range WithColor:[UIColor colorWithHexString:@"#E8400F"] andFont:[UIFont systemFontOfSize:10 weight:UIFontWeightSemibold] allFullText:cell.danjiaLabel.text];
    
    cell.stepper.valueChanged = ^(double value) {
        NSLog(@"%f", value);
        dataModel.value = [[NSNumber numberWithDouble:value] stringValue];
    };
    
    return cell;
}

- (IBAction)add:(UIButton *)sender {
    
    if (!sender.selected) {
        
        self.addBtn.hidden = YES;
        self.stepper.hidden = NO;
        
    } else {
        
    }
    
}



@end
