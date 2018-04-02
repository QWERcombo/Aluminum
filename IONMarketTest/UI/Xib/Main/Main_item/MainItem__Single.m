//
//  MainItem__Single.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/17.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "MainItem__Single.h"

@implementation MainItem__Single


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
        self = [[[NSBundle mainBundle] loadNibNamed:@"MainItem__Single" owner:self options:nil] firstObject];
        
        self.frame = frame;
        
        [self.lengthTF addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:@"length"];
        [self.widthTF addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:@"width"];
        [self.amountTF addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:@"amount"];
        self.mainM = [[MainModel alloc] init];
    }
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    id newName = [change objectForKey:NSKeyValueChangeNewKey];

    NSString *contextInfo = [NSString stringWithFormat:@"%@", context];
    if ([contextInfo isEqualToString:@"length"]) {
        self.mainM.changdu = newName;
        self.lengthIsChanged = YES;
        
    } else if ([contextInfo isEqualToString:@"width"]) {
        self.mainM.kuandu = newName;
        
    } else if ([contextInfo isEqualToString:@"amount"]) {
        self.mainM.shuliang = newName;
        
    } else {
    }
    
    if (self.mainBlock) {
        self.mainBlock(self.mainM, self.lengthIsChanged);
    }
}


- (void)dealloc {
    [self.lengthTF removeObserver:self forKeyPath:@"text"];
    [self.widthTF removeObserver:self forKeyPath:@"text"];
    [self.amountTF removeObserver:self forKeyPath:@"text"];
    self.lengthTF = nil;
}

- (IBAction)rightTap:(UITapGestureRecognizer *)sender {
    self.rightImgv.hidden = NO;
    self.leftImgv.hidden = YES;
    
    self.right_top_Label.textColor = [UIColor mianColor:2];
    self.right_down_Label.textColor  =[UIColor mianColor:2];
    self.left_top_Label.textColor = [UIColor mianColor:3];
    self.left_down_Label.textColor = [UIColor mianColor:3];
    
    self.lengthTF.userInteractionEnabled = YES;
    
    if (self.click) {
        self.click(@"优切");
    }
}


- (IBAction)hbhb:(UITapGestureRecognizer *)sender {
    self.rightImgv.hidden = YES;
    self.leftImgv.hidden = NO;
    
    self.right_top_Label.textColor = [UIColor mianColor:3];
    self.right_down_Label.textColor  =[UIColor mianColor:3];
    self.left_top_Label.textColor = [UIColor mianColor:2];
    self.left_down_Label.textColor = [UIColor mianColor:2];
    
    self.lengthTF.userInteractionEnabled = NO;
    self.rightCountLabel.text = @"0 元";
    if (self.click) {
        self.click(@"快速");
    }
}


- (IBAction)selectAction:(UIButton *)sender {//选择厚度
    if (self.click) {
        self.click(@"0");
    }

}


- (IBAction)addNew:(UIButton *)sender {
//    NSLog(@"%@--%@---%@", self.lengthTF.text, self.widthTF.text, self.lengthTF.text);
    if (self.click) {
        self.click(@"1");
    }
}


- (void)loadData:(NSObject *)data andCliker:(ClikBlock)click andMainBlock:(JudgeBlock)mainB {
    self.click = click;
    self.mainBlock = mainB;
    
    
}

@end
