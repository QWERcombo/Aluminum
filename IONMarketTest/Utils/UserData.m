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
        _id =[aDecoder decodeObjectForKey:@"id"];
        _lastLoginIp=[aDecoder decodeObjectForKey:@"lastLoginIp"];
        _company=[aDecoder decodeObjectForKey:@"company"];
        _balance=[aDecoder decodeObjectForKey:@"balance"];
        _commission=[aDecoder decodeObjectForKey:@"commission"];
        _deleted=[aDecoder decodeObjectForKey:@"deleted"];
        _headImgUrl=[aDecoder decodeObjectForKey:@"headImgUrl"];
        _phone=[aDecoder decodeObjectForKey:@"phone"];
        
        _name=[aDecoder decodeObjectForKey:@"name"];
        _no=[aDecoder decodeObjectForKey:@"no"];
        _nickname=[aDecoder decodeObjectForKey:@"nickname"];
        _jingyingmoshi=[aDecoder decodeObjectForKey:@"jingyingmoshi"];
        _tuijianren=[aDecoder decodeObjectForKey:@"tuijianren"];
        _tuijianrendianhua=[aDecoder decodeObjectForKey:@"tuijianrendianhua"];
        _openid=[aDecoder decodeObjectForKey:@"openid"];
        _remark=[aDecoder decodeObjectForKey:@"remark"];
        _renzheng=[aDecoder decodeObjectForKey:@"renzheng"];
//        _renzhengTime=[aDecoder decodeObjectForKey:@"renzhengTime"];
        _xiaofeishang=[aDecoder decodeObjectForKey:@"xiaofeishang"];
        _zhiwei=[aDecoder decodeObjectForKey:@"zhiwei"];
        
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    if(_id) [aCoder encodeObject:_id forKey:@"id"];
    if(_lastLoginIp) [aCoder encodeObject:_lastLoginIp forKey:@"lastLoginIp"];
    if(_company) [aCoder encodeObject:_company forKey:@"company"];
    if(_balance) [aCoder encodeObject:_balance forKey:@"balance"];
    if(_commission) [aCoder encodeObject:_commission forKey:@"commission"];
    if(_deleted) [aCoder encodeObject:_deleted forKey:@"deleted"];
    if(_headImgUrl) [aCoder encodeObject:_headImgUrl forKey:@"headImgUrl"];
    if(_phone) [aCoder encodeObject:_phone forKey:@"phone"];
    
    if(_name) [aCoder encodeObject:_name forKey:@"name"];
    if(_no) [aCoder encodeObject:_no forKey:@"no"];
    if(_nickname) [aCoder encodeObject:_nickname forKey:@"nickname"];
    if(_zhiwei) [aCoder encodeObject:_zhiwei forKey:@"zhiwei"];
    if(_xiaofeishang) [aCoder encodeObject:_xiaofeishang forKey:@"xiaofeishang"];
    if(_renzheng) [aCoder encodeObject:_renzheng forKey:@"renzheng"];
//    if(_renzhengTime) [aCoder encodeObject:_renzhengTime forKey:@"renzhengTime"];
    if(_remark) [aCoder encodeObject:_remark forKey:@"remark"];
    if(_openid) [aCoder encodeObject:_openid forKey:@"openid"];
    if(_tuijianren) [aCoder encodeObject:_tuijianren forKey:@"tuijianren"];
    if(_tuijianrendianhua) [aCoder encodeObject:_tuijianrendianhua forKey:@"tuijianrendianhua"];
    if(_jingyingmoshi) [aCoder encodeObject:_jingyingmoshi forKey:@"jingyingmoshi"];
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
//    NSString *version = self.version;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:[NSString stringWithFormat:@"%@",NSStringFromClass([self class])]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if ([self conformsToProtocol:@protocol(NSCoding)]) {
        UserData *uData = [[UserData alloc] init];
//        uData.userToken = userToken;
//        uData.version = version;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:uData];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:[NSString stringWithFormat:@"%@",NSStringFromClass([self class])]];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}


@end
