//
//  InputViewController.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/21.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "InputViewController.h"
#import "InOutputView.h"
#import "BankCardViewController.h"

@interface InputViewController ()

@end

@implementation InputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.mode_way == Mode_Input) {
        self.title = @"转入";
    } else {
        self.title = @"转出";
    }
    
    [self setupSubviews];
}

- (void)setupSubviews {
    UIButton *explainButton = [UIButton buttonWithTitle:@"限额说明" andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    [explainButton addTarget:self action:@selector(explainButtonCliker:) forControlEvents:UIControlEventTouchUpInside];
    explainButton.frame = CGRectMake(0, 0, 70, 15);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:explainButton];
    
    
    InOutputView *mainView = [[InOutputView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 300)];
    [mainView loadData:SINT(self.mode_way) andCliker:^(NSString *clueStr) {

        if ([clueStr isEqualToString:@"1"]) {
            NSLog(@"下一步");
        } else {
            NSLog(@"选择银行卡");
            BankCardViewController *bank = [BankCardViewController new];
            [self.navigationController pushViewController:bank animated:YES];
        }

    }];
    
    [self.view addSubview:mainView];
    
    
}





- (void)explainButtonCliker:(UIButton *)sender {
    NSLog(@"%@", sender.currentTitle);
    
    
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
