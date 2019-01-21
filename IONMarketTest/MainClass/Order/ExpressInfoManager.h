//
//  ExpressInfoManager.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2019/1/21.
//  Copyright © 2019年 赵越. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExpressInfoManager : NSObject

+ (void)getExpressInfo:(NSDictionary*)parameters block:(void (^) (NSInteger sucess,NSDictionary *dataDict,NSString *error))block;

+ (NSString *)getExpressCodeWithName:(NSString *)expName;

@end

NS_ASSUME_NONNULL_END
