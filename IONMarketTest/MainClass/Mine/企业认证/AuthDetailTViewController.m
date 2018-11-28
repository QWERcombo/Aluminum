//
//  AuthDetailTViewController.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/4/9.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "AuthDetailTViewController.h"

@interface AuthDetailTViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;

@end

@implementation AuthDetailTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction:)];
//    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
    
    self.inputTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.inputTextView.layer.borderWidth = 0.5;
    self.inputTextView.layer.masksToBounds = YES;
    self.inputTextView.layer.cornerRadius = 5;
    self.inputTextView.text = self.contentStr;
    self.inputTextView.delegate = self;
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
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;//这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
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
