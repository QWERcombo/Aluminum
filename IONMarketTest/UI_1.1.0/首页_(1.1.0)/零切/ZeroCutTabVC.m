//
//  ZeroCutTabVC.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/10/23.
//  Copyright © 2018 赵越. All rights reserved.
//

#import "ZeroCutTabVC.h"
#import "SelectThickView.h"

@interface ZeroCutTabVC ()

@property (weak, nonatomic) IBOutlet UITextField *lengthTF;
@property (weak, nonatomic) IBOutlet UITextField *widthTF;
@property (weak, nonatomic) IBOutlet UITextField *thinTF;
@property (weak, nonatomic) IBOutlet UITextField *countTF;
@property (weak, nonatomic) IBOutlet UILabel *suqieLab;
@property (weak, nonatomic) IBOutlet UIImageView *suqieImgv;
@property (weak, nonatomic) IBOutlet UILabel *youqieLab;
@property (weak, nonatomic) IBOutlet UIImageView *youqieImgv;
@property (weak, nonatomic) IBOutlet UILabel *danjianzhongliangLab;
@property (weak, nonatomic) IBOutlet UILabel *danjianjiageLab;
@property (weak, nonatomic) IBOutlet UILabel *jianshuLab;
@property (weak, nonatomic) IBOutlet UILabel *hejiLab;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UIView *infoView;


@end

@implementation ZeroCutTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Table view data source



#pragma mark - Handle

- (IBAction)suqie:(UIButton *)sender {
    
    _label1.textColor = [UIColor mianColor:2];
    _label2.textColor = [UIColor mianColor:2];
    _label3.textColor = [UIColor Grey_WordColor];
    _label4.textColor = [UIColor Grey_WordColor];
    
    _youqieImgv.image = [UIImage imageNamed:@"select_0"];
    _youqieLab.textColor = [UIColor Grey_WordColor];
    _suqieImgv.image = [UIImage imageNamed:@"select_1"];
    _suqieLab.textColor = [UIColor Grey_OrangeColor];
    _suqieLab.text = @"￥18.5元/公斤";
    
    [self updateInfoView];
}

- (IBAction)youqie:(UIButton *)sender {
    
    _label1.textColor = [UIColor Grey_WordColor];
    _label2.textColor = [UIColor Grey_WordColor];
    _label3.textColor = [UIColor mianColor:2];
    _label4.textColor = [UIColor mianColor:2];
    
    _youqieImgv.image = [UIImage imageNamed:@"select_1"];
    _youqieLab.textColor = [UIColor Grey_OrangeColor];
    _youqieLab.text = @"￥19.5元/公斤";
    _suqieImgv.image = [UIImage imageNamed:@"select_0"];
    _suqieLab.textColor = [UIColor Grey_WordColor];
    
    [self updateInfoView];
}

- (IBAction)selectThin:(UIButton *)sender {
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i=0; i<50; i++) {
        
        [arr addObject:[NSString stringWithFormat:@"%ld", (long)i]];
    }
    
    [SelectThickView showSelectThickViewWithDataSource:arr selectBlock:^(NSInteger selectIndex) {
        NSLog(@"---%ld", selectIndex);
        
        
    }];
    
}


- (void)updateInfoView {
    self.infoView.hidden = NO;
    
    
}

- (void)refreshInfoToReset {
    self.infoView.hidden = YES;
    _label1.textColor = [UIColor Grey_WordColor];
    _label2.textColor = [UIColor Grey_WordColor];
    _label3.textColor = [UIColor Grey_WordColor];
    _label4.textColor = [UIColor Grey_WordColor];
    
    _youqieImgv.image = [UIImage imageNamed:@"select_0"];
    _youqieLab.textColor = [UIColor Grey_WordColor];
    _youqieLab.text = @"";
    _suqieImgv.image = [UIImage imageNamed:@"select_0"];
    _suqieLab.textColor = [UIColor Grey_WordColor];
    _suqieLab.text = @"";
    
    self.lengthTF.text = @"";
    self.widthTF.text = @"";
    self.thinTF.text = @"";
    self.countTF.text = @"";
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
