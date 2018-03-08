//
//  PublicFuntionTool.m
//  WHFinance
//
//  Created by wanhong on 2017/7/7.
//  Copyright © 2017年 wanhong. All rights reserved.
//

#import "PublicFuntionTool.h"

@implementation PublicFuntionTool
DEF_SINGLETON(PublicFuntionTool);

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
}

/*
- (void)getSmsCodeByPhoneString:(NSString *)phone {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    if (!phone.length) {
        [[UtilsData sharedInstance] showAlertTitle:@"提示" detailsText:@"未输入手机号" time:2.0 aboutType:WHShowViewMode_Text state:NO];
        return;
    }
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"param":@{@"mobile":phone,@"type":@"register"}}] forKey:@"common.sendMsgCode"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:@"sms_code" showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
        if (resultDic) {
            [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"短信验证码\n已发送!" time:2 aboutType:WHShowViewMode_Text state:YES];
            _clikBlock(resultDic[@"resultData"]);
        }
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}
*/

/*
- (void)uMengShareWithObject:(UMSocialPlatformType)dataType andBaseController:(BaseViewController *)controller {
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
//        NSString* thumbURL =  IMG(@"");
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:[NSString stringWithFormat:@"%@,收款利器，赚钱神器！更低费率，更高返佣", [self getAppName]] descr:[NSString stringWithFormat:@"推荐人手机号%@邀请您使用%@", [UserData currentUser].mobileNumber, [self getAppName]] thumImage:IMG(@"login_logo")];
    //设置网页地址
    shareObject.webpageUrl = Share_URL;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:dataType messageObject:messageObject currentViewController:controller completion:^(id data, NSError *error) {
        
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        
    }];
    
    
}
*/


- (NSString *) getweekDayStringWithDate
{
    NSDate *date = [NSDate date];
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 指定日历的算法
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:date];
    // 1 是周日，2是周一 3.以此类推
    NSNumber * weekNumber = @([comps weekday]);
    NSInteger weekInt = [weekNumber integerValue];
    NSString *weekDayString = @"";
    switch (weekInt) {
        case 1:
        {
            weekDayString = @"周日";
        }
            break;
        case 2:
        {
            weekDayString = @"周一";
        }
            break;
        case 3:
            
        {
            weekDayString = @"周二";
        }
            break;
        case 4:
            
        {
            weekDayString = @"周三";
        }
            break;
        case 5:
        {
            weekDayString = @"周四";
        }
            break;
        case 6:
        {
            weekDayString = @"周五";
        }
            break;
        case 7:
        {
            weekDayString = @"周六";
        }
            break;
        default:
            break;
    }
    return weekDayString;
}


- (NSString *)getBase64StringFrom:(UIImage *)image {
    NSData *imageData = UIImageJPEGRepresentation([[UtilsData sharedInstance] scaleAndRotateImage:image resolution:800 maxSizeWithKB:600], 0.9);
    NSString *imageBase64Str = [NEUSecurityUtil encodeBase64Data:imageData];
    return imageBase64Str;
}

//用户退出登录
- (void)userLoginOut {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"userToken":[UserData currentUser].userToken}] forKey:@"user.loginOut"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        if (resultDic) {
            [[UserData currentUser] removeMe];
            [[UtilsData sharedInstance] postLogoutNotice];
//            [[PublicFuntionTool sharedInstance] hangShake];//握手
        }
    } failure:^(NSString *error, NSInteger code) {
        
    }];
}

- (NSString *)getAppName {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    return app_Name;
}

- (void)checkAppId {
    //0自己 以后新的依次+1
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"appId":APP_ID}] forKey:@"transqury.isCheck"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
//        NSLog(@"++++-----%@", resultDic);
        if ([resultDic[@"resultCode"] integerValue]==0) {
            [[UserData currentUser] giveData:@{@"isCheck":[NSString stringWithFormat:@"%@",resultDic[@"resultData"]]}];
            if ([[UserData currentUser].uid integerValue]==5) {
                [self appStorecheck];
            } else {
                [[UtilsData sharedInstance] postLoginNotice];
            }
        }
    } failure:^(NSString *error, NSInteger code) {
        
    }];
}

- (void)appStorecheck {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[NEUSecurityUtil FormatJSONString:@{@"appId":APP_ID,@"userName":[UserData currentUser].userName}] forKey:@"transqury.isCheck2"];
    NSString *json = [NEUSecurityUtil FormatJSONString:paramDic];
    [dict setObject:json forKey:@"key"];
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:@"" andCookie:nil showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
        //        NSLog(@"++++-----%@", resultDic);
        if ([resultDic[@"resultCode"] integerValue]==0) {
            [[UserData currentUser] giveData:@{@"isCheck":[NSString stringWithFormat:@"%@",resultDic[@"resultData"]]}];
            [[UtilsData sharedInstance] postLoginNotice];
        }
    } failure:^(NSString *error, NSInteger code) {
        
    }];
}

- (id)noEmptyWithObject:(id)object{
    const NSString *nullStr = @"";
    //数据处理
    if ([object isKindOfClass:[NSArray class]]) {
        NSMutableArray *array = [(NSArray *)object mutableCopy];
        for (int index = 0; index<array.count; index++) {
            //遍历后每个数据
            id arrayObject = array[index];
            //返回数据
            id useObject = [self noEmptyWithObject:arrayObject];
            //存档
            [array setObject:useObject atIndexedSubscript:index];
        }
        
        return array;
    }else if([object isKindOfClass:[NSDictionary class]]){
        NSMutableDictionary *mutableDic = [(NSDictionary *)object mutableCopy];
        for (id key in mutableDic.allKeys) {
            //遍历后每个数据
            id value = mutableDic[key];
            //返回数据
            id useObject = [self noEmptyWithObject:value];
            //存档
            [mutableDic setObject:useObject forKey:key];
        }
        
        return mutableDic;
    }else if([object isEqual:[NSNull null]]||object == nil){
        return nullStr;
    }else{
        return object;
    }
}


- (NSDateComponents *)getInfomationFromNowDate {
    // 获取代表公历的NSCalendar对象
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* dt = [NSDate date];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags
                                          fromDate:dt];
    return comp;
}


- (LYEmptyView *)getEmptyViewWithType:(WHShowEmptyViewMode)mode withReloadAction:(ReloadDataBlock)reload {
    
    if ([Reachability isMayUseInternet]) {//无网络
        mode = WHShowEmptyMode_noNetWork;
    }
    
    LYEmptyView *empty = nil;
    if (mode==WHShowEmptyMode_noData) {
        empty = [LYEmptyView emptyViewWithImageStr:@"Nothing_NoContent" titleStr:@"" detailStr:@""];
    } else {
        empty = [LYEmptyView emptyViewWithImageStr:@"Nothing_NoNetWork" titleStr:@"" detailStr:@""];
    }
    empty.titleLabTextColor = [UIColor mianColor:2];
    empty.titleLabFont = FONT_ArialMT(13);
    [empty setTapContentViewBlock:^{
        if (reload) {
            reload();
        }
    }];
    
    return empty;
}


@end
