//
//  MainItemView__Matter.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/19.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

//管材
@interface MainItemView__Matter : UIView

@property (weak, nonatomic) IBOutlet UILabel *neiLabel;
@property (weak, nonatomic) IBOutlet UILabel *waiLabel;
@property (weak, nonatomic) IBOutlet UITextField *lengthTF;
@property (weak, nonatomic) IBOutlet UITextField *amountTF;
@property (weak, nonatomic) IBOutlet UILabel *left_top_Label;
@property (weak, nonatomic) IBOutlet UILabel *left_down_Label;
@property (weak, nonatomic) IBOutlet UIImageView *leftImgv;
@property (weak, nonatomic) IBOutlet UILabel *right_top_Label;
@property (weak, nonatomic) IBOutlet UILabel *right_down_Label;
@property (weak, nonatomic) IBOutlet UIImageView *rightImgv;
@property (weak, nonatomic) IBOutlet UILabel *leftCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightCountLabel;

@property (nonatomic, copy) ClikBlock click;


- (void)loadData:(NSObject *)data andCliker:(ClikBlock)click;

@end
