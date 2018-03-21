//
//  AddCardViewController.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/21.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "AddCardViewController.h"
#import "AddBankCardView.h"
#import "AddBankCardUploadView.h"

@interface AddCardViewController ()

@property (nonatomic, assign) BOOL isNext;

@end

@implementation AddCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"添加银行卡";
    [self setupSubviews];
}

- (void)setupSubviews {
    
    [self.view addSubview:self.tabView];
    self.tabView.backgroundColor = [UIColor mianColor:1];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
}

#pragma mark ----- UITableViewDelegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.isNext) {
        AddBankCardUploadView *uploadView = [[AddBankCardUploadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 300)];
        [uploadView loadData:nil andCliker:^(NSString *clueStr) {
            
            if ([clueStr isEqualToString:@"0"]) {
                
                NSLog(@"获取验证码");
            } else {
                
                NSLog(@"提交");
            }
            
            self.isNext = NO;
            [self.tabView reloadData];
        }];
        
        return uploadView;
    } else {
        AddBankCardView *addView = [[AddBankCardView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 300)];
        [addView loadData:nil andCliker:^(NSString *clueStr) {

            NSLog(@"下一步");
            
            self.isNext = YES;
            [self.tabView reloadData];
        }];
        
        return addView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 300;
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
