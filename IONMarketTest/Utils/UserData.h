//
//  UserData.h
//  XiYouPartner
//
//  Created by 265G on 15/8/19.
//  Copyright (c) 2015年 YXCompanion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : BaseModel

@property (nonatomic,strong)NSString        *id;//
@property (nonatomic,strong)NSString        *lastLoginIp;//
@property (nonatomic,strong)NSString        *company;//
@property (nonatomic,strong)NSString        *balance;//
@property (nonatomic,strong)NSString        *commission;//
@property (nonatomic,strong)NSString        *addressId;//
@property (nonatomic,strong)NSString        *baitiao;//
@property (nonatomic,strong)NSString        *deleted;//
@property (nonatomic,strong)NSString        *headImgUrl;//
@property (nonatomic,strong)NSString        *phone;

@property (nonatomic,strong)NSString        *jingyingmoshi;
@property (nonatomic,strong)NSString        *name;
@property (nonatomic,strong)NSString        *no;
@property (nonatomic,strong)NSString        *openid;
@property (nonatomic,strong)NSString        *remark;
@property (nonatomic,strong)NSString        *renzheng;
//@property (nonatomic,strong)NSString        *renzhengTime;
@property (nonatomic,strong)NSString        *tuijianren;
@property (nonatomic,strong)NSString        *tuijianrendianhua;
@property (nonatomic,strong)NSString        *xiaofeishang;
@property (nonatomic,strong)NSString        *zhiwei;
@property (nonatomic,strong)NSString        *nickname;
@property (nonatomic,strong)NSString        *baitiaoprocess;// 0未申请 1审核中 2通过

//赋值
-(void)giveData:(NSDictionary *)dic;
//保存用户数据
- (void)saveMe;
//删除用户数据
- (void)removeMe;

+ (UserData *)currentUser;

@end
