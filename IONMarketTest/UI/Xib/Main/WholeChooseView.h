//
//  WholeChooseView.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/6/7.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WholeChooseViewDelegate <NSObject>
@required

- (void)refreshDataWithInfo:(NSMutableDictionary *)dataDic;

@end

@interface WholeChooseView : UIView <CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UITextField *houduTF;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextField *zhijingTF;
@property (nonatomic, assign) id <WholeChooseViewDelegate> delegate;
@property (nonatomic, strong) NSMutableDictionary *dataDic;
@property (nonatomic, copy) NSString *zhonglei;
@property (nonatomic, assign) NSInteger lastSelected;
@property (weak, nonatomic) IBOutlet CustomButton *zhengbanBtn;


+ (void)show:(UIViewController *)delegateVC;

@end
