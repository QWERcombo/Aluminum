//
//  UnitsPickerView.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/31.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UnitsPickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, strong) NSString *selectStr;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, copy) ClikBlock click;
@property (nonatomic, strong) UIViewController *superVC;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

- (instancetype)initWithFrame:(CGRect)frame withDataSource:(NSArray *)dataArr;

- (void)loadData:(NSObject *)model andClickBlock:(ClikBlock)click;


@end
