//
//  MainItemViewController.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/12.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    Mode_Single, //零切
    Mode_Pole, //圆棒
    Mode_Tube, //型材
    Mode_Matter, //管材
} GetWholeBoardMode;


@interface MainItemViewController : BaseViewController

@property (nonatomic, assign) NSInteger selectedNum;

@end
