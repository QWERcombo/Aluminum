//
//  MainItemView__Matter.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/19.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

//管材
@interface MainItemView__Matter : UIView <UITextFieldDelegate>

typedef void (^JudgeBlock)(MainModel *info, BOOL lengthIsChanged); // bool yes改变 no未变

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
@property (weak, nonatomic) IBOutlet UIButton *lengthBtn;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (nonatomic, copy) ClikBlock click;
@property (nonatomic, strong) MainModel *mainM;
@property (nonatomic, copy) JudgeBlock mainBlock;
@property (nonatomic, assign) BOOL lengthIsChanged;
@property (nonatomic, strong) NSMutableString *changduS;
@property (nonatomic, strong) NSMutableString *shuliangS;

- (void)loadData:(NSObject *)data andCliker:(ClikBlock)click andMainBlock:(JudgeBlock)mainB;
- (void)resetShowLabel;
@end
