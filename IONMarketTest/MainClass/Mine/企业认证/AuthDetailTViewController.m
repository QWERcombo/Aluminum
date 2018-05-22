//
//  AuthDetailTViewController.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/4/9.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "AuthDetailTViewController.h"

@interface AuthDetailTViewController ()
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;

@end

@implementation AuthDetailTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction:)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
    
    self.inputTextView.layer.borderColor = [UIColor blackColor].CGColor;
    self.inputTextView.layer.borderWidth = 1;
    self.inputTextView.layer.masksToBounds = YES;
    self.inputTextView.layer.cornerRadius = 5;
    self.inputTextView.text = self.contentStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)saveAction:(UIBarButtonItem *)sender {
    if (self.PassValueBlock) {
        self.PassValueBlock(self.inputTextView.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Table view data source






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
