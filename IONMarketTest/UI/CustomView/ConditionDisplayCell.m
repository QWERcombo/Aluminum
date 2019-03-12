//
//  ConditionDisplayCell.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2019/2/14.
//  Copyright © 2019年 赵越. All rights reserved.
//

#import "ConditionDisplayCell.h"
#import "PinLeiModel.h"
#import "MainItemTypeModel.h"


@implementation ConditionDisplayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.showButton.layer.cornerRadius = 2;
    self.showButton.layer.masksToBounds = YES;
    self.showButton.titleLabel.adjustsFontSizeToFitWidth = YES;
}


- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    if (selected) {
        self.showButton.backgroundColor = [[UIColor mianColor:2] colorWithAlphaComponent:0.1];
        self.showButton.layer.borderColor = [UIColor mianColor:2].CGColor;
        self.showButton.layer.borderWidth = 1;
        [self.showButton setTitleColor:[UIColor mianColor:2] forState:UIControlStateNormal];
    } else {
        self.showButton.layer.borderColor = nil;
        self.showButton.layer.borderWidth = 0;
        self.showButton.backgroundColor = [UIColor mianColor:1];
        [self.showButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
}


- (void)setButtonTitle:(NSString *)title selectTitle:(NSString *)selectTitle dataObject:(id)dataObject {
    
    NSString *showName = @"";
    if ([title isEqualToString:@"品类"]) {
        
//        PinLeiModel *model = (PinLeiModel *)dataObject;
//        showName = model.name;
        NSString *string = (NSString *)dataObject;
        showName = string;
    } else if ([title isEqualToString:@"牌号"]) {
        
        if ([dataObject isKindOfClass:[NSString class]]) {
            NSString *string = (NSString *)dataObject;
            showName = string;
        } else {
            MainItemTypeModel *model = (MainItemTypeModel *)dataObject;
            showName = model.name;
        }
        
    } else if ([title isEqualToString:@"状态"]) {
        
        NSString *string = (NSString *)dataObject;
        showName = string;
    } else if ([title isEqualToString:@"厚度"]) {
        
        NSString *string = (NSString *)dataObject;
        showName = [NSString stringWithFormat:@"%@mm", string];
    } else if ([title isEqualToString:@"更多"]) {
        
        NSString *string = (NSString *)dataObject;
        showName = string;
    } else {
        
    }
    
    [self.showButton setTitle:showName forState:UIControlStateNormal];
    
    if ([[showName stringByReplacingOccurrencesOfString:@"mm" withString:@""] isEqualToString:selectTitle]) {
        [self setSelected:YES];
    } else {
        [self setSelected:NO];
    }
    
}


@end
