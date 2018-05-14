//
//  BorderView.m
//  jjl
//
//  Created by sks on 16/5/6.
//  Copyright © 2016年 jjl. All rights reserved.
//

#import "BorderView.h"

#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define SEPARATOR_LINE_COLOR rgba(229,229,229,1.0)

@implementation BorderView
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGFloat lineWidth = 0.5;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, lineWidth);
    
    
    
    
    if (self.tag ==101)
    {
        CGContextSetStrokeColorWithColor(context, SEPARATOR_LINE_COLOR.CGColor);
        //上边边框
        CGContextMoveToPoint(context, 0, 0.2);
        CGContextAddLineToPoint(context, rect.size.width, 0.2);
        
    }
    else if(self.tag ==102)
    {
        CGContextSetStrokeColorWithColor(context, SEPARATOR_LINE_COLOR.CGColor);
        //左边边框
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, 0, rect.size.height);
        
    }
    else if(self.tag ==103)
    {
        CGContextSetStrokeColorWithColor(context, SEPARATOR_LINE_COLOR.CGColor);
        //下边边框
        CGContextMoveToPoint(context, 0, rect.size.height-0.2);
        CGContextAddLineToPoint(context, rect.size.width, rect.size.height-0.2);
    }
    else if(self.tag ==104)
    {
        CGContextSetStrokeColorWithColor(context, SEPARATOR_LINE_COLOR.CGColor);
        //右边边框
        CGContextMoveToPoint(context, rect.size.width, 0);
        CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
    }
    else if(self.tag ==105)
    {
        //垂直中间分割线
        CGContextSetStrokeColorWithColor(context, SEPARATOR_LINE_COLOR.CGColor);
        CGContextMoveToPoint(context, rect.size.width*0.5, rect.size.height*0.2);
        CGContextAddLineToPoint(context, rect.size.width*0.5, rect.size.height*0.8);
    }
    else if (self.tag ==106)
    {
        //虚线
        CGContextSetStrokeColorWithColor(context, SEPARATOR_LINE_COLOR.CGColor);
        //上边边框
        CGFloat lengths[] = {1,2};
        CGContextSetLineDash(context, 0, lengths, 2);
        CGContextMoveToPoint(context, 0, 0/*rect.size.height*0.5*/);
        
        CGContextAddLineToPoint(context, rect.size.width, 0/*rect.size.height*0.5*/);
    }
    else if(self.tag ==107)
    {
        CGContextSetStrokeColorWithColor(context, SEPARATOR_LINE_COLOR.CGColor);
        //水平中间线
        CGContextMoveToPoint(context, 0, rect.size.height/2.0);
        CGContextAddLineToPoint(context, rect.size.width, rect.size.height/2.0);
    }
    else if(self.tag ==108)
    {
        CGContextSetStrokeColorWithColor(context, SEPARATOR_LINE_COLOR.CGColor);
        //下边边框
        CGContextMoveToPoint(context, 0, rect.size.height-0.2);
        CGContextAddLineToPoint(context, rect.size.width, rect.size.height-0.2);
        
        //上边边框
        CGContextMoveToPoint(context, 0, 0.2);
        CGContextAddLineToPoint(context, rect.size.width, 0.2);
    }
    else if(self.tag ==109)
    {
        CGContextSetStrokeColorWithColor(context, SEPARATOR_LINE_COLOR.CGColor);
        
        //左边边框
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, 0, rect.size.height);
        //右边边框
        CGContextMoveToPoint(context, rect.size.width, 0);
        CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
        
    }else if(self.tag ==110)
    {
        CGContextSetLineWidth(context, 0.2);
        CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
        //下边边框
        CGContextMoveToPoint(context, 0, rect.size.height-0.2);
        CGContextAddLineToPoint(context, rect.size.width, rect.size.height-0.2);
        
    }else if(self.tag ==111)
    {
        //垂直中间分割线
        CGContextSetStrokeColorWithColor(context, SEPARATOR_LINE_COLOR.CGColor);
        CGContextMoveToPoint(context, rect.size.width*0.5, 0);
        CGContextAddLineToPoint(context, rect.size.width*0.5, rect.size.height);
    }
    
    else if(self.tag ==112)
    {
        CGContextSetStrokeColorWithColor(context, SEPARATOR_LINE_COLOR.CGColor);
        
        //左边边框
        CGContextMoveToPoint(context, 0, 3);
        CGContextAddLineToPoint(context, 0, rect.size.height-6);
        //右边边框
        CGContextMoveToPoint(context, rect.size.width, 3);
        CGContextAddLineToPoint(context, rect.size.width, rect.size.height-6);
        
    }
    else if(self.tag ==113)
    {
        CGContextSetStrokeColorWithColor(context, SEPARATOR_LINE_COLOR.CGColor);
        
        //左边边框
        CGContextMoveToPoint(context, 0, 5);
        CGContextAddLineToPoint(context, 0, rect.size.height-10);
        
        
    }
    else if(self.tag ==114)
    {
        CGContextSetStrokeColorWithColor(context, SEPARATOR_LINE_COLOR.CGColor);
        
        
        //右边边框
        CGContextMoveToPoint(context, rect.size.width, 5);
        CGContextAddLineToPoint(context, rect.size.width, rect.size.height-10);
        
    }
    else if(self.tag ==115)
    {
        CGContextSetStrokeColorWithColor(context, SEPARATOR_LINE_COLOR.CGColor);
        
        
        //上边边框
        CGContextMoveToPoint(context, 0, 0.2);
        CGContextAddLineToPoint(context, rect.size.width, 0.2);
        
        CGContextMoveToPoint(context, rect.size.width*0.5, 0);
        CGContextAddLineToPoint(context, rect.size.width*0.5, rect.size.height);
        
    }
    else if(self.tag ==116)
    {
        CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
        
        
        //上边边框
        CGContextMoveToPoint(context, 0, 0.2);
        CGContextAddLineToPoint(context, rect.size.width, 0.2);
        
    }
    else if(self.tag ==117)
    {
        CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
        
        
        //上边边框
        CGContextMoveToPoint(context, 0, 0.2);
        CGContextAddLineToPoint(context, rect.size.width, 0.2);
        //右边边框
        CGContextMoveToPoint(context, rect.size.width-0.2, 0);
        CGContextAddLineToPoint(context, rect.size.width-0.2, rect.size.height);
    }
    
    CGContextStrokePath(context);

}


@end
