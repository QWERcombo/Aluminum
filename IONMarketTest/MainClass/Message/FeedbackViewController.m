//
//  FeedbackViewController.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/22.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)buttonAction1:(UIButton *)sender {
    self.textView.text = sender.currentTitle;
    
}

- (IBAction)submitAction:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"提交成功!" time:0.0 aboutType:WHShowViewMode_Text state:YES];
    
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
