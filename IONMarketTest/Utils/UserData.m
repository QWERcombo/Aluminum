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

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"user_id": @"id"
                                                                  }];
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self=[super init])
    {
        unsigned int count = 0;
        
        Ivar *ivars = class_copyIvarList([self class], &count);
        
        for (int i = 0 ; i < count; i++) {
            //取出对应的成员变量
            Ivar ivar = ivars[i];
            
            //查看成员变量
            const char *name = ivar_getName(ivar);
            
            //归档
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
            
        }
        free(ivars);
    }

    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    unsigned int count = 0;
    
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    for (int i = 0 ; i < count; i++) {
        //取出对应的成员变量
        Ivar ivar = ivars[i];
        
        //查看成员变量
        const char *name = ivar_getName(ivar);
        
        //归档
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
        
    }
    free(ivars);
    
    
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
