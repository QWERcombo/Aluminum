//
//  ExpressInfoManager.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2019/1/21.
//  Copyright © 2019年 赵越. All rights reserved.
//

#import "ExpressInfoManager.h"
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import "AFNetworking.h"

//#define CC_MD5_DIGEST_LENGTH 32

@implementation ExpressInfoManager

static char base64EncodeChars[] = {
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
    'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
    'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
    'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
    'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
    'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
    'w', 'x', 'y', 'z', '0', '1', '2', '3',
    '4', '5', '6', '7', '8', '9', '+', '/' };

+ (void)getExpressInfo:(NSDictionary *)parameters block:(void (^)(NSInteger, NSDictionary *, NSString *))block  {
    // 快递鸟  注册时的字段   填写你的app对应的字段
    NSString *EBusinessID = @"1433662";
    NSString *AppKey = @"fbc12b25-abb4-4f8e-8d7b-02804bba2be7";
    // 快递鸟  快递信息查询时不同的类型对应不同的链接
//    NSString *ReqURL = @"http://api.kdniao.com/Ebusiness/EbusinessOrderHandle.aspx";
//    NSString *ReqURL = @"http://sandboxapi.kdniao.com:8080/kdniaosandbox/gateway/exterfaceInvoke.json";
    NSString *requestStr = [NSString stringWithFormat:@"{'OrderCode':'','ShipperCode':'%@','LogisticCode':'%@'}",parameters[@"expCode"],parameters[@"expNo"]];
    
    NSString *encodePath = [ExpressInfoManager urlEncoder:requestStr];
    
    NSString *dataSign = [ExpressInfoManager encrypt:requestStr keyValue:AppKey charset:@"UTF-8"];
    
    NSString *dataSignEncoder = [ExpressInfoManager urlEncoder:dataSign];
    
    NSDictionary *requestParameters = @{@"RequestData":encodePath,@"EBusinessID":EBusinessID,@"RequestType":@"1002",@"DataSign":dataSignEncoder,@"DataType":@"2"};
    
    [DataSend sendPostRequestWithReqDic:requestParameters success:^(NSDictionary *resultDic, NSString *msg) {
        
        if ([msg isEqualToString:@"1"]) {
            block(1,resultDic,msg);
        } else {
            block(-1,nil,@"");
        }
        
    } failure:^(NSString *error, NSInteger code) {
        block(-1,nil,@"");
    }];

}

+ (NSData*)JSONData:(NSDictionary *)dict{
    NSError* error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}


+ (NSString *)urlEncoder:(NSString *)urlStr{
    
    NSString *encodePath = nil;
    if ([[UIDevice currentDevice].systemVersion floatValue] > 7.0) {
        encodePath = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }else{
        encodePath = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
    }
    
    return encodePath;
}

+ (NSString *) encrypt:(NSString *)content keyValue:(NSString *)keyValue charset:(NSString *)charset{
    
    if (keyValue != nil) {
        
        return [ExpressInfoManager base64:[ExpressInfoManager MD5:[NSString stringWithFormat:@"%@%@",content,keyValue] charset:charset] charset:charset];
    }
    
    return [ExpressInfoManager base64:[ExpressInfoManager MD5:content charset:charset] charset:charset];
}


+ (NSString *)base64:(NSString *)str charset:(NSString *)charset{
    
    return [ExpressInfoManager base64Encode:str];
}

+ (NSString *)base64Encode:(NSString *)dataStr{
    
    NSData *data = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
    
    Byte *dataBuffer = (Byte*)[data bytes];
    
    NSMutableString *resultStr = [NSMutableString string];
    NSInteger len = [data length];
    NSInteger i = 0;
    NSInteger b1,b2,b3;
    while (i < len) {
        b1 = dataBuffer[i++] & 0xff;
        
        if (i==len) {
            
            //            char c = base64EncodeChars[b1 >> 2];
            [resultStr appendString:[NSString stringWithFormat:@"%c",base64EncodeChars[b1 >> 2]]];
            [resultStr appendString:[NSString stringWithFormat:@"%c",base64EncodeChars[(b1 & 0x3) << 4]]];
            [resultStr appendString:@"=="];
            break;
        }
        
        b2 = dataBuffer[i++] & 0xff;
        
        if (i==len) {
            [resultStr appendString:[NSString stringWithFormat:@"%c",base64EncodeChars[b1 >> 2]]];
            [resultStr appendString:[NSString stringWithFormat:@"%c",base64EncodeChars[((b1 & 0x03) << 4) | ((b2 & 0xf0) >> 4)]]];
            //NSLog(@"b2 resultStr == %@",resultStr);
            [resultStr appendString:[NSString stringWithFormat:@"%c",base64EncodeChars[(b2 & 0x0f) << 2]]];
            [resultStr appendString:@"="];
            break;
        }
        b3 = dataBuffer[i++] & 0xff;
        [resultStr appendString:[NSString stringWithFormat:@"%c",base64EncodeChars[b1 >> 2]]];
        [resultStr appendString:[NSString stringWithFormat:@"%c",base64EncodeChars[((b1 & 0x03) << 4) | ((b2 & 0xf0) >> 4)]]];
        [resultStr appendString:[NSString stringWithFormat:@"%c",base64EncodeChars[((b2 & 0x0f) << 2) | ((b3 & 0xc0) >> 6)]]];
        [resultStr appendString:[NSString stringWithFormat:@"%c",base64EncodeChars[b3 & 0x3f]]];
    }
    
    //NSLog(@"base64Encode == %@",resultStr);
    
    return resultStr;
}


+ (NSString *)MD5:(NSString *)str charset:(NSString *)charset{
    
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    
    for (int i = 0; i < 16; i++){
        
        [hash appendFormat:@"%02X", result[i]];
    }
    
    //NSLog(@"MD5 == %@",[hash lowercaseString]);
    return [hash lowercaseString];
}


+ (NSString *)getExpressCodeWithName:(NSString *)expName {
    
    NSDictionary *nameDic = @{@"顺丰速运":@"SF",@"圆通":@"YTO",@"圆通快递":@"YTO",@"百世快递":@"HTKY",@"中通快递":@"ZTO",@"韵达速递":@"YD",@"申通快递":@"STO",@"EMS":@"EMS",@"天天快递":@"HHTT",@"优速快递":@"UC",@"德邦快递":@"DBL",@"宅急送":@"ZJS",@"阿里跨境电商物流":@"ALKJWL",@"亚马逊物流":@"AMAZON",@"安能快运":@"ANEKY",@"八达通":@"BDT",@"八方安运":@"BFAY",@"百世快运":@"BTWL",@"城市100":@"CITY100",@"城际快递":@"CJKD",@"大田物流":@"DTWL",@"东骏快捷物流":@"DJKJWL",@"德邦快运":@"DBLKY",@"汇丰物流":@"HFWL",@"辉隆物流":@"HLONGWL",@"京东快运":@"JDKY",@"民航快递":@"MHKD",@"苏宁物流":@"SNWL",@"壹米滴答":@"YMDD",@"韵达快运":@"YDKY",@"中通快运":@"ZTOKY",@"中骅物流":@"ZHWL",@"跨越物流":@"KYWL",@"圆通速递":@"YTO"};
    
    if ([nameDic.allKeys containsObject:expName]) {
        return [nameDic objectForKey:expName];
    } else {
        return @"";
    }
    
}



@end
