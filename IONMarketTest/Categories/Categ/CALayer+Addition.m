//
//  CALayer+Addition.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/24.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "CALayer+Addition.h"

@implementation CALayer (Addition)

- (void)setBorderColorFromUIColor:(UIColor *)color {
    
    self.borderColor = color.CGColor;
    
}


@end
