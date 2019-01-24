//
//  UIButton+YXP.h
//  YouXiPartner
//
//  Created by 265G on 15-1-26.
//  Copyright (c) 2015年 YXP. All rights reserved.
//

#import <UIKit/UIKit.h>


//@protocol UIbuttonDelegate <NSObject>
//
//-(void)touchesMoveTheView:(NSSet *)touches withEvent:(UIEvent *)event;
//
//@end

typedef NS_ENUM(NSUInteger, MKButtonEdgeInsetsStyle) {
    MKButtonEdgeInsetsStyleTop, // image在上，label在下
    MKButtonEdgeInsetsStyleLeft, // image在左，label在右
    MKButtonEdgeInsetsStyleBottom, // image在下，label在上
    MKButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (YXP)


//右侧按钮
+ (UIButton *)buttonForGamePackWithTitle:(NSString *)title andNormalColor:(UIColor *)normalColor;

//用户头像
+ (UIButton *)buttonForUserHeadWithAvatarPath:(NSString *)avatarPath;

//上图标下文本的button
+ (UIButton *)buttonWithImage:(NSString *)imageName text:(NSString *)titleText TextColor:(UIColor *)color Font:(UIFont *)font redNumber:(int)number showRed:(BOOL)isShowRed;

//
- (void)setImageWithURLPath:(NSString *)urlPath;

//自定义高亮按钮
+ (UIButton *)buttonWithTitle:(NSString *)title andFont:(UIFont *)font andtitleNormaColor:(UIColor *)normalColor andHighlightedTitle:(UIColor *)lightedTitle andNormaImage:(UIImage *)normalImage andHighlightedImage:(UIImage *)lightedImage;

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(MKButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

@end

