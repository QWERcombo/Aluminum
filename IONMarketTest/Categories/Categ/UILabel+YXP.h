//
//  UILabel+YXP.h
//  YouXiPartner
//
//  Created by 265G on 15-1-26.
//  Copyright (c) 2015年 YXP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBAttributeModel : NSObject{

}

@property (nonatomic, copy) NSString *str;

@property (nonatomic, assign) NSRange range;

@end
@interface UILabel (YXP)
@property (nonatomic, assign) BOOL enabledTapEffect;

- (void)TB_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings tapClicked:(void (^) (NSString *string , NSRange range , NSInteger index))tapClick;

-(NSMutableAttributedString *)changeAttributeForColorInFormer:(NSString *)former latter:(NSString *)latter reply:(NSString *)reply font:(UIFont *)font;

+ (id)lableWithText:(NSString *)text Font:(UIFont *)font TextColor:(UIColor *)textColor;

//计算默认文本高度
+(CGSize)getSizeWithText:(NSString*)text andFont:(UIFont *)font andSize:(CGSize)size;

//富文本
+ (NSMutableAttributedString *)getAttributedFromRange:(NSRange)range WithColor:(UIColor *)color andFont:(UIFont *)font allFullText:(NSString *)labelText;

//改变行间距
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;

//改变字间距
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

//改变行间距和字间距
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

@end
