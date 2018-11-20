//
//  UserData.h
//  XiYouPartner
//
//  Created by 265G on 15/8/19.
//  Copyright (c) 2015年 YXCompanion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserData : BaseModel

@property (nonatomic, copy) NSString *activeTime;
@property (nonatomic, copy) NSString *addressId;
@property (nonatomic, copy) NSString *baitiao;
@property (nonatomic, copy) NSString *balance;
@property (nonatomic, copy) NSString *commission;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *dangyuebaitiaozhangdan;
@property (nonatomic, copy) NSString *dangyuehuankuan;
@property (nonatomic, copy) NSString *deleted;
@property (nonatomic, copy) NSString *headImgUrl;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *jingyingmoshi;
@property (nonatomic, copy) NSString *lastLoginIp;
@property (nonatomic, copy) NSString *loginCount;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *no;
@property (nonatomic, copy) NSString *openid;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *promoteMoney;
@property (nonatomic, copy) NSString *promotePhone;
@property (nonatomic, copy) NSString *registerIp;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *renzheng;
@property (nonatomic, copy) NSString *renzhengTime;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *statusDate;
@property (nonatomic, copy) NSString *superior;
@property (nonatomic, copy) NSString *tuijianren;
@property (nonatomic, copy) NSString *tuijianrendianhua;
@property (nonatomic, copy) NSString *xiaofeishang;
@property (nonatomic, copy) NSString *zhifumima;
@property (nonatomic, copy) NSString *zhiwei;



//赋值
-(void)giveData:(NSDictionary *)dic;
//保存用户数据
- (void)saveMe;
//删除用户数据
- (void)removeMe;

+ (UserData *)currentUser;

@end
