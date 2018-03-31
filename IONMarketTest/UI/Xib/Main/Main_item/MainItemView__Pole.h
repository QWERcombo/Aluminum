//
//  MainItemView__Pole.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/19.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainItemView__Pole : UIView

@property (weak, nonatomic) IBOutlet UILabel *lengthLabel;

@property (weak, nonatomic) IBOutlet UITextField *lengthTF;
@property (weak, nonatomic) IBOutlet UITextField *amountTF;
@property (weak, nonatomic) IBOutlet UILabel *left_top_Label;
@property (weak, nonatomic) IBOutlet UILabel *left_down_Label;
@property (weak, nonatomic) IBOutlet UIImageView *leftImgv;
@property (weak, nonatomic) IBOutlet UILabel *right_top_Label;
@property (weak, nonatomic) IBOutlet UILabel *right_down_Label;
@property (weak, nonatomic) IBOutlet UIImageView *rightImgv;
@property (weak, nonatomic) IBOutlet UILabel *rightCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftCountLabel;

@property (nonatomic, copy) ClikBlock click;


- (void)loadData:(NSObject *)data andCliker:(ClikBlock)click;
@end
