//
//  WholeBoardModel.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/5/2.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseModel.h"


@protocol ProductCate;

@interface ProductCate : BaseModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSString *deleted;
@property (nonatomic, copy) NSString *fatherId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *ord;

@end

@interface WholeBoardModel : BaseModel

@property (nonatomic, copy) NSString *arg1;
@property (nonatomic, copy) NSString *arg2;
@property (nonatomic, copy) NSString *arg3;
@property (nonatomic, copy) NSString *baozhuang;
@property (nonatomic, copy) NSString *butiee;
@property (nonatomic, copy) NSString *canzhaozhishu;
@property (nonatomic, copy) NSString *danjia;//单价
@property (nonatomic, copy) NSString *danpianzhengbanjiage;//单片整板价格
@property (nonatomic, copy) NSString *fumo;
@property (nonatomic, copy) NSString *gongyibiaozhun;
@property (nonatomic, copy) NSString *guige;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *jiagongfei;
@property (nonatomic, copy) NSString *jiazhi;
@property (nonatomic, copy) NSString *kucun;
@property (nonatomic, copy) NSString *leibie;
@property (nonatomic, copy) NSString *lirun;
@property (nonatomic, copy) NSString *midu;
@property (nonatomic, copy) NSString *secondrate;
@property (nonatomic, copy) NSString *xinghao;
@property (nonatomic, copy) NSString *zhonglei;
@property (nonatomic, copy) NSString *zhongliang;
@property (nonatomic, copy) NSString *zhuangtai;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, copy) NSDictionary *lvxing;
@property (nonatomic, strong) ProductCate *productCate;

@end


