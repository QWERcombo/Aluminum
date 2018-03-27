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
