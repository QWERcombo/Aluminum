//
//  SetOrderViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/15.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "SetOrderViewController.h"

@interface SetOrderViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *order_imgv;

@end

@implementation SetOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor mianColor:1];
    
}


#pragma mark ---- Action
- (IBAction)uploadButton:(id)sender {
    NSLog(@"%@", [(UIButton *)sender currentTitle]);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
