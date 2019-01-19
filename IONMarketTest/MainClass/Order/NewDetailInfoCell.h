//
//  NewDetailInfoCell.h
//  IONMarketTest
//
//  Created by 赵越 on 2019/1/19.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "BaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewDetailInfoCell : BaseCell

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *zhifushijian;
@property (weak, nonatomic) IBOutlet UILabel *zhifufangshi;
@property (weak, nonatomic) IBOutlet UILabel *bianhao;
@property (weak, nonatomic) IBOutlet UILabel *shijian;
@property (weak, nonatomic) IBOutlet UILabel *zhongliang;
@property (weak, nonatomic) IBOutlet UILabel *shuliang;
@property (weak, nonatomic) IBOutlet UILabel *jiage;
@property (weak, nonatomic) IBOutlet UILabel *wuliu;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pay_height;
@property (weak, nonatomic) IBOutlet UIView *showView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *show_height;



@end

NS_ASSUME_NONNULL_END
