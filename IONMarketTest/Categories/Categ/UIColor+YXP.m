//
//  UIColor+YXP.m
//  YouXiPartner
//
//  Created by 265G on 15-1-26.
//  Copyright (c) 2015年 YXP. All rights reserved.
//

#import "UIColor+YXP.h"

@implementation UIColor (YXP)
//http://www.jianshu.com/p/79e4dd8a44bc
+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (UIColor *)colorWithR:(CGFloat)R G:(CGFloat)G B:(CGFloat)B A:(CGFloat)A
{
    return [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A];
}

+ (UIColor *)YXPBlueColor
{
    return [UIColor colorWithR:0 G:128 B:255 A:1];
}
+ (UIColor *)Black_WordColor{
//    return [UIColor colorWithHexString:@"#27293b"];
    return [UIColor colorWithR:51 G:51 B:51 A:1];
}

+ (UIColor *)Black_BlackColor//黑色
{
    return [UIColor colorWithHexString:@"#3E3E3E"];
}

+ (UIColor *)Grey_BackColor//深
{
    return [UIColor colorWithR:153 G:153 B:153 A:1];
}
+ (UIColor *)Grey_BackColor1//浅
{
    return [UIColor colorWithR:245 G:245 B:245 A:1];
}
+ (UIColor *)Grey_LineColor
{
    return [UIColor colorWithR:231 G:231 B:231 A:1];
}

+ (UIColor *)Grey_WordColor//浅灰
{
    return [UIColor colorWithHexString:@"#A5A5A5"];
}

+ (UIColor *)YXPYellowColor
{
    return [UIColor colorWithR:250 G:150 B:4 A:1];
}

+ (UIColor *)Grey_OrangeColor {//橙
//    return [UIColor colorWithR:0xf7 G:0x94 B:0x1d A:1];
    return [UIColor colorWithR:243 G:152 B:0 A:1];
}

+ (UIColor *)Grey_NameColor {
    return [UIColor colorWithR:0x6b G:0x79 B:0x9d A:1];
}

+ (UIColor *)Grey_CommentColor {
    return [UIColor colorWithR:0x93 G:0x94 B:0x9d A:1];
}

+ (UIColor *)Grey_ContentColor {
    return [UIColor colorWithR:0x27 G:0x29 B:0x3b A:1];
}

+ (UIColor *)Grey_LikeColor {
    return [UIColor colorWithR:235 G:51 B:15 A:1];
}

+ (UIColor *)Grey_PurColor {
    return [UIColor colorWithR:0x82 G:0x51 B:0xff A:1];
}

+ (UIColor *)Grey_BlankColor {
    return [UIColor colorWithR:0xed G:0xed B:0xed A:1];
}

+ (UIColor *)mianColor:(colorTypes)type
{
    if (type == 1) {
        return  [UIColor colorWithHexString:@"#f6f8f8"];
    } else if(type==2) {
        return  [UIColor colorWithHexString:@"#2c98f8"];
    } else {
        return [UIColor whiteColor];
    }
}

@end
