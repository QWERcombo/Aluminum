//
//  UserData.m
//  XiYouPartner
//
//  Created by 265G on 15/8/19.
//  Copyright (c) 2015年 YXCompanion. All rights reserved.
//

#import "UserData.h"

@interface UserData ()

@end
@implementation UserData

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self=[super init])
    {
        _uid =[aDecoder decodeObjectForKey:@"uid"];
        _bindTime=[aDecoder decodeObjectForKey:@"bindTime"];
        _createTime=[aDecoder decodeObjectForKey:@"createTime"];
        _mobileNumber=[aDecoder decodeObjectForKey:@"mobileNumber"];
        _modifyTime=[aDecoder decodeObjectForKey:@"modifyTime"];
        _option=[aDecoder decodeObjectForKey:@"option"];
        _password=[aDecoder decodeObjectForKey:@"password"];
        _readName=[aDecoder decodeObjectForKey:@"readName"];
        _userName=[aDecoder decodeObjectForKey:@"userName"];
        _userReadNameFlag=[aDecoder decodeObjectForKey:@"userReadNameFlag"];
        _userStatus=[aDecoder decodeObjectForKey:@"userStatus"];
        _userToken=[aDecoder decodeObjectForKey:@"userToken"];
        _agentId=[aDecoder decodeObjectForKey:@"agentId"];
        _referenceId=[aDecoder decodeObjectForKey:@"referenceId"];
        _isPartner=[aDecoder decodeObjectForKey:@"isPartner"];
        _Random_Key=[aDecoder decodeObjectForKey:@"Random_Key"];
        _Active_Head=[aDecoder decodeObjectForKey:@"Active_Head"];
        _isCheck=[aDecoder decodeObjectForKey:@"isCheck"];
        _version=[aDecoder decodeObjectForKey:@"version"];
        _availablentegral=[aDecoder decodeObjectForKey:@"availablentegral"];
        
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    if(_uid) [aCoder encodeObject:_uid forKey:@"uid"];
    if(_bindTime) [aCoder encodeObject:_bindTime forKey:@"bindTime"];
    if(_createTime) [aCoder encodeObject:_createTime forKey:@"createTime"];
    if(_mobileNumber) [aCoder encodeObject:_mobileNumber forKey:@"mobileNumber"];
    if(_modifyTime) [aCoder encodeObject:_modifyTime forKey:@"modifyTime"];
    if(_option) [aCoder encodeObject:_option forKey:@"option"];
    if(_password) [aCoder encodeObject:_password forKey:@"password"];
    if(_userName) [aCoder encodeObject:_userName forKey:@"userName"];
    if(_userReadNameFlag) [aCoder encodeObject:_userReadNameFlag forKey:@"userReadNameFlag"];
    if(_userStatus) [aCoder encodeObject:_userStatus forKey:@"userStatus"];
    if(_userToken) [aCoder encodeObject:_userToken forKey:@"userToken"];
    if(_readName) [aCoder encodeObject:_readName forKey:@"readName"];
    if(_agentId) [aCoder encodeObject:_agentId forKey:@"agentId"];
    if(_referenceId) [aCoder encodeObject:_referenceId forKey:@"referenceId"];
    if(_isPartner) [aCoder encodeObject:_isPartner forKey:@"isPartner"];
    if(_Random_Key) [aCoder encodeObject:_Random_Key forKey:@"Random_Key"];
    if(_Active_Head) [aCoder encodeObject:_Active_Head forKey:@"Active_Head"];
    if(_isCheck) [aCoder encodeObject:_isCheck forKey:@"isCheck"];
    if(_version) [aCoder encodeObject:_version forKey:@"version"];
    if(_availablentegral) [aCoder encodeObject:_availablentegral forKey:@"availablentegral"];
 }

-(void)giveData:(NSDictionary *)dic{
    UserData *user = [self initWithDictionary:dic error:nil];
    [self removeMe];
    [user saveMe];
}

+ (UserData *)currentUser
{
    if([self conformsToProtocol:@protocol(NSCoding)])
    {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@",NSStringFromClass([self class])]];
        id obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (obj) {
            return obj;
        }else{
            return [UserData new];
        }
    }
    return nil;
}

- (void)saveMe
{
    if ([self conformsToProtocol:@protocol(NSCoding)]) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:[NSString stringWithFormat:@"%@",NSStringFromClass([self class])]];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)removeMe
{
//    NSString *userToken = self.userToken;
    NSString *version = self.version;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:[NSString stringWithFormat:@"%@",NSStringFromClass([self class])]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if ([self conformsToProtocol:@protocol(NSCoding)]) {
        UserData *uData = [[UserData alloc] init];
//        uData.userToken = userToken;
        uData.version = version;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:uData];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:[NSString stringWithFormat:@"%@",NSStringFromClass([self class])]];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}


@end
