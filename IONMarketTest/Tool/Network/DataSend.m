//
//  DataSend.m
//  XiYouPartner
//
//  Created by 265G on 15/8/10.
//  Copyright (c) 2015年 YXCompanion. All rights reserved.
//

#import "DataSend.h"

static NSOperationQueue *queue;

@implementation DataSend

#pragma mark - POST

+ (void)verdictResponseString:(id)response
{
    if (response == nil) {
        NSLog(@"WARNING:数据为空");
        [[UtilsData sharedInstance]hideAlert];
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"数据返回异常" time:1.5 aboutType:WHShowViewMode_Text state:NO];
        return;
    }else{
        NSLog(@"访问成功~~~~~~~ ✔️✔️✔️-+*yeyeyeyeyeye ");
    }
}

+ (NSString *)getPostByWithType:(NSString*)type
{
    NSString *httpStr = [NSString stringWithFormat:@"%@/%@",BASE_URL,type];
    return httpStr;
}

+ (NSMutableDictionary *)getPostByParameters:(NSMutableDictionary*)params
{
    [DataSend addBasicParameters:params];
    NSArray *aryKeys = [params allKeys];
    //排序
    aryKeys = [aryKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString *number1 = obj1 ;
        NSString *number2 = obj2 ;
        NSComparisonResult result = [number1 compare:number2];
        return result == NSOrderedDescending; // 升序
        //return result == NSOrderedAscending;  // 降序
    }];
    NSMutableString *paramsStr = [NSMutableString stringWithCapacity:100];
    
    for (NSString *str in aryKeys ){
        //        if ([params objectForKey:str]!=[NSNull null]&&[[params objectForKey:str] length]>0){
        if ([params objectForKey:str]!=[NSNull null]){
            
            if (paramsStr.length==0){
                [paramsStr appendFormat:@"%@=%@",str,[params objectForKey:str]];
            }
            else{
                [paramsStr appendFormat:@"&%@=%@",str,[params objectForKey:str]];
            }
        }
    }
    [paramsStr replaceOccurrencesOfString:@"+" withString:@" " options:NSLiteralSearch range:NSMakeRange(0, [paramsStr length])];
    return params;
}

+ (void)sendPostWastedRequestWithBaseURL:(NSString *)baseUrl valueDictionary:(NSMutableDictionary*)dict imageArray:(NSArray *)imgArr WithType:(NSString*)type andCookie:(NSString *)cookie showAnimation:(BOOL)animation success:(SuccessBlock)success failure:(FailureBlock)failure{
    
    NSString *httpStr = [NSString stringWithFormat:@"%@/%@",baseUrl,type];
    
    NSLog(@"链接 🔗🔗 == %@  -----%@",httpStr, dict);
    
    [DataSend AFHTTPRequestWithURL:httpStr valueDictionary:dict imageArray:imgArr andCookie:cookie showAnimation:animation success:success failure:failure];
}



+ (void)AFHTTPRequestWithURL:(NSString *)URLString valueDictionary:(NSDictionary *)valueDic imageArray:(NSArray *)imgArr andCookie:(NSString *)cookie showAnimation:(BOOL)animation success:(SuccessBlock)success failure:(FailureBlock)failure
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer.timeoutInterval = 20.f;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"application/json", nil];
        
        
        [manager POST:URLString parameters:valueDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            //上传文件参数
            for (UIImage *img in imgArr ) {
                NSData *imageData = UIImageJPEGRepresentation([[UtilsData sharedInstance] scaleAndRotateImage:img resolution:800 maxSizeWithKB:600], 0.9);
//                NSData *imageData = UIImageJPEGRepresentation(img, 0.5);
                [formData appendPartWithFileData:imageData name:imgArr.count>1?@"filedata":@"file" fileName:@"image.jpg" mimeType:@"image/jpeg"];
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            //打印下上传进度
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [[UtilsData sharedInstance] hideAlert];
            
            //请求成功
            [DataSend verdictResponseString:responseObject];
            
            NSError *err;
            NSString *jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//            NSLog(@"---%@", jsonStr);
            NSData *jsonData = [[self removeUnescapedCharacter:jsonStr] dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
            
            NSLog(@" 🍔🍔 %@", result);
            NSString *status = [NSString stringWithFormat:@"%@", [result objectForKey:@"status"]];//1为成功
            NSString *msg = [NSString stringWithFormat:@"%@", [result objectForKey:@"msg"]];//返回信息
            
//            success(result,msg);
            if ([status isEqualToString:@"1"]) {   //成功
                
                success(result,msg);
                
            } else {                       // 失败
                
                [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:msg time:0.0 aboutType:WHShowViewMode_Text state:NO];
                
                failure(msg,-1);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [[UtilsData sharedInstance] hideAlert];
            //请求失败
            failure(error.localizedFailureReason,1);
//            [[UtilsData sharedInstance]showAlertTitle:@"" detailsText:@"加载失败，请检查网络是否通畅" time:2.5 aboutType:WHShowViewMode_Text state:NO];
            [[UtilsData sharedInstance]showAlertTitle:@"" detailsText:@"暂无数据" time:2.5 aboutType:WHShowViewMode_Text state:NO];
            NSLog(@"failure about error~%@",error);
        }];
    });
    if (animation == YES) {
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"加载中..." time:30.0 aboutType:WHShowViewMode_Load state:NO];
    } else {
        [[UtilsData sharedInstance] hideAlert];
    }
    
}


+ (void)cancelAllRequest{
    [queue cancelAllOperations];
    [[UtilsData sharedInstance] hideAlert];
}

#pragma mark  版本信息
+ (void)addBasicParameters:(NSMutableDictionary *)aParameters
{
    if(aParameters){
//        NSString * version = [[UtilsData sharedInstance] getVersions];
//        [aParameters safeSetObject:version forKey:REQ_KEY_VERSION];
//        [aParameters safeSetObject:@"IOS" forKey:REQ_KEY_PLATFORM];
//        [aParameters safeSetObject:APP_ID forKey:@"appId"];
        
        
        
        
        
        
    }
}



//去除特殊字符
+ (NSString *)removeUnescapedCharacter:(NSString *)inputStr
{
    NSCharacterSet *controlChars = [NSCharacterSet controlCharacterSet];//获取那些特殊字符
    NSRange range = [inputStr rangeOfCharacterFromSet:controlChars];//寻找字符串中有没有这些特殊字符
    if (range.location != NSNotFound)
    {
        NSMutableString *mutable = [NSMutableString stringWithString:inputStr];
        while (range.location != NSNotFound)
        {
            [mutable deleteCharactersInRange:range];//去掉这些特殊字符
            range = [mutable rangeOfCharacterFromSet:controlChars];
        }
        return mutable;
    }
    return inputStr;
}



@end

