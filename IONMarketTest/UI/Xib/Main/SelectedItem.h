//
//  SelectedItem.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/10.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectedItem : UIView
@property (weak, nonatomic) IBOutlet UIImageView *item_imgv;
@property (weak, nonatomic) IBOutlet UILabel *item_name;
@property (nonatomic, copy) ClikBlock click;

- (void)loadData:(NSObject *)data andCliker:(ClikBlock)click;

@end
