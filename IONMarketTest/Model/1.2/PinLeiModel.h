//
//  PinLeiModel.h
//  IONMarketTest
//
//  Created by 赵越 on 2019/2/18.
//  Copyright © 2019 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PinLeiModel : BaseModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *deleted;
@property (nonatomic, copy) NSString *fatherId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *ord;
@property (nonatomic, copy) NSString *picture;

@end

NS_ASSUME_NONNULL_END
