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
//@property (nonatomic,strong)NSString        *activeTime;//
//@property (nonatomic,strong)NSString        *createDate;//
@property (nonatomic,strong)NSString        *deleted;//
@property (nonatomic,strong)NSString        *headImgUrl;//


//赋值
-(void)giveData:(NSDictionary *)dic;
//保存用户数据
- (void)saveMe;
//删除用户数据
- (void)removeMe;

+ (UserData *)currentUser;

@end
