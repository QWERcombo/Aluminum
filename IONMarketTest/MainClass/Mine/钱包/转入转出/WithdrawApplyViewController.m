//
//  WithdrawApplyViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/5/28.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "WithdrawApplyViewController.h"
#import "TradeListViewController.h"

@interface WithdrawApplyViewController ()
@property (weak, nonatomic) IBOutlet UITextField *kaihuhangTF;
@property (weak, nonatomic) IBOutlet UITextField *kaihuhangzhanghaoTF;
@property (weak, nonatomic) IBOutlet UITextField *shuruTF;
@property (weak, nonatomic) IBOutlet UITextField *kaihurenTF;
@property (weak, nonatomic) IBOutlet UITextField *kaihuhangdizhiTF;

@end

@implementation WithdrawApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *recordBtn = [UIButton buttonWithTitle:@"提现记录" andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    recordBtn.frame = CGRectMake(0, 0, 70, 40);
    [recordBtn addTarget:self action:@selector(payCliker:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:recordBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)payCliker:(UIButton *)sender {
    
    TradeListViewController *list = [[TradeListViewController alloc] init];
    list.listType = ListType_Withdraw;
    [self.navigationController pushViewController:list animated:YES];
}

- (IBAction)applyClicker:(UIButton *)sender {
    
    if (!_kaihuhangTF.text || !_kaihurenTF.text || !_kaihuhangdizhiTF.text || !_kaihuhangzhanghaoTF.text || !_shuruTF.text) {
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请输入正确的信息" time:0 aboutType:WHShowViewMode_Text state:NO];
        return;
    }
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    [dataDic setValue:[UserData currentUser].user_id forKey:@"userId"];
    [dataDic setValue:self.shuruTF.text forKey:@"money"];
    [dataDic setValue:self.kaihuhangTF.text forKey:@"bank"];
    [dataDic setValue:self.kaihuhangzhanghaoTF.text forKey:@"bankNo"];
    [dataDic setValue:self.kaihurenTF.text forKey:@"bankName"];
    [dataDic setValue:self.kaihuhangdizhiTF.text forKey:@"bankAddress"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dataDic imageArray:nil WithType:Interface_withdrawSave andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"提交成功！" time:0 aboutType:WHShowViewMode_Text state:YES];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
    
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
