//
//  PickerView.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/24.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerView : UIView

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (nonatomic, copy) ClikBlock click;

- (void)loadData:(NSObject *)data andCliker:(ClikBlock)click;
@end
