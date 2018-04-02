//
//  UnitsPickerView.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/31.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "UnitsPickerView.h"

@implementation UnitsPickerView

- (instancetype)initWithFrame:(CGRect)frame withDataSource:(NSArray *)dataArr
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"UnitsPickerView" owner:nil options:nil] firstObject];
        
        self.dataSource = [dataArr mutableCopy];
        
        self.frame = frame;
    }
    return self;
}

- (IBAction)cancel:(UIButton *)sender {
    [self removeFromSuperview];
}

- (IBAction)done:(UIButton *)sender {
    if (self.click) {
        [self removeFromSuperview];
        
        NSString *string = @"";
        if (self.selectStr.length) {
            string = self.selectStr;
        } else {
            string = [self.dataSource firstObject];
        }
        self.click(string);
    }
}



- (void)loadData:(NSObject *)model andClickBlock:(ClikBlock)click {
    self.click = click;
    
    
}

#pragma mark --- datasource & delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataSource.count;
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    NSString *string = [NSString stringWithFormat:@"%@ mm", [self.dataSource objectAtIndex:row]];
    UILabel *label = [UILabel lableWithText:string Font:FONT_ArialMT(15) TextColor:[UIColor Black_WordColor]];
    label.textAlignment = NSTextAlignmentCenter;
    
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectStr = [self.dataSource objectAtIndex:row];
}




@end
