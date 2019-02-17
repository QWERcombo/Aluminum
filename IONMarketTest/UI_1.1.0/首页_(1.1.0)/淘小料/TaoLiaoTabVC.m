//
//  TaoLiaoTabVC.m
//  IONMarketTest
//
//  Created by 赵越 on 2019/2/17.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "TaoLiaoTabVC.h"
#import "CALayer+Addition.h"

@interface TaoLiaoTabVC ()

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;


@end

@implementation TaoLiaoTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.nextBtn.layer.cornerRadius = 4;
    self.nextBtn.layer.masksToBounds = YES;
    
    
}

#pragma mark - Table view data source

- (IBAction)buttonClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        sender.backgroundColor = [UIColor mianColor:2];
    } else {
        sender.backgroundColor = [UIColor colorWithHexString:@"#FAFAFA"];
    }
    
    
    
    
}


- (IBAction)next:(UIButton *)sender {
    NSLog(@"%@", sender.currentTitle);
    
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
