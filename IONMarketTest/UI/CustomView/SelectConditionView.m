//
//  SelectConditionView.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2019/2/13.
//  Copyright © 2019年 赵越. All rights reserved.
//

#import "SelectConditionView.h"
#import "UIButton+YXP.h"

@interface SelectConditionView ()

@property (nonatomic, copy) NSArray *titleArray;

@end

@implementation SelectConditionView


- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleArray = [NSArray arrayWithArray:titleArray];
        
        CGFloat BUTTON_WW = (SCREEN_WIGHT-self.titleArray.count+1)/self.titleArray.count;
        
        for (int i = 0; i < self.titleArray.count; i++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake((BUTTON_WW+1)*i, 0, BUTTON_WW, frame.size.height);
            button.tag = 100+i;
            
            [button setTitle:[self.titleArray objectAtIndex:i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithHexString:@"#595E64"] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor mianColor:2] forState:UIControlStateSelected];
            [button setImage:IMG(@"show_down") forState:UIControlStateNormal];
            [button setImage:IMG(@"show_up") forState:UIControlStateSelected];
            button.titleLabel.font = [UIFont systemFontOfSize:14];
            button.titleLabel.adjustsFontSizeToFitWidth = YES;
            
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(button.frame), 8, 1, 24)];
            line.backgroundColor = [UIColor groupTableViewBackgroundColor];
            
            
            [self addSubview:button];
            
            if (i!=self.titleArray.count-1) {
                [self addSubview:line];
            }
        }
        
    }
    return self;
}

- (void)buttonClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedConditionIndex:conditionTitle:)]) {
            [self.delegate didSelectedConditionIndex:sender.tag-100 conditionTitle:sender.currentTitle];
        }
        
        for (int i = 0; i < self.titleArray.count; i++) {
            
            UIButton *button = [self viewWithTag:100+i];
            if (sender.tag-100 != i) {
                
                [button setSelected:NO];
            }
            
        }
        
        
    } else {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedConditionIndex:conditionTitle:)]) {
            [self.delegate didSelectedConditionIndex:-1 conditionTitle:sender.currentTitle];
        }
    }
    
}

- (void)changeTitle:(NSString *)title index:(NSInteger)index {
    
    UIButton *button = [self viewWithTag:100+index];
    
    if ([title containsString:@","]) {
        //更多
        [button setTitle:@"已选" forState:UIControlStateNormal];
    } else {
        [button setTitle:title forState:UIControlStateNormal];
    }
    
    [button setSelected:NO];
    
    if (![title isEqualToString:[self.titleArray objectAtIndex:index]]) {
        
        [button setTitleColor:[UIColor mianColor:2] forState:UIControlStateNormal];
    } else {
        
        [button setTitleColor:[UIColor colorWithHexString:@"#595E64"] forState:UIControlStateNormal];
    }
    
}

- (void)reset {
    
    for (UIView *subView in self.subviews) {
        
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)subView;
            [button setSelected:NO];
        }
    }
    
}

- (void)resetTitleWithIndex:(NSInteger)index {
    
    for (UIView *subView in self.subviews) {
        
        if ([subView isKindOfClass:[UIButton class]]) {
            
            UIButton *button = (UIButton *)subView;
            
            if (button.tag > (index+100)) {
                
                [button setSelected:NO];
                [button setTitle:[self.titleArray objectAtIndex:button.tag-100] forState:UIControlStateNormal];
                [button setTitleColor:[UIColor colorWithHexString:@"#595E64"] forState:UIControlStateNormal];
                [button setImage:IMG(@"show_down") forState:UIControlStateNormal];
            }
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(resetTitleInfomationWithIndex:)]) {
        
        [self.delegate resetTitleInfomationWithIndex:index];
    }
    
}

@end
