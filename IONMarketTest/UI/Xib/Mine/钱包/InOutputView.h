//
//  InOutputView.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/21.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InOutputView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;

@property (weak, nonatomic) IBOutlet UILabel *bankName;
@property (weak, nonatomic) IBOutlet UILabel *bankID;

@property (weak, nonatomic) IBOutlet UIView *priceTF;

@property (weak, nonatomic) IBOutlet UILabel *hintLabel;

@property (nonatomic, copy) ClikBlock click;


- (void)loadData:(NSObject *)data andCliker:(ClikBlock)click;

@end
