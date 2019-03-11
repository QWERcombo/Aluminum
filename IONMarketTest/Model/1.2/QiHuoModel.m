//
//  QiHuoModel.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2019/2/19.
//  Copyright © 2019年 赵越. All rights reserved.
//

#import "QiHuoModel.h"

@implementation QiHuoModel

- (NSString *)hou {
    NSNumber *number = [NSNumber numberWithFloat:[_hou floatValue]];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setPositiveFormat:@"###0"];

    formatter.maximumFractionDigits = 3;
    
    return [formatter stringFromNumber:number];
}

@end
