//
//  ConfirmTicketVC.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/6/6.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "ConfirmTicketVC.h"
#import "TicketInfoVC.h"

@interface ConfirmTicketVC ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *totalLab;
@property (weak, nonatomic) IBOutlet UILabel *taitouLab;

@property (nonatomic, copy) NSString *fapiaoId;
@end

@implementation ConfirmTicketVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"开发票";
    CGFloat totalFee = 0.0;
    for (OrderListModel *model in self.modelArr) {
        
        totalFee+= [model.totalMoney floatValue];
        
    }
    self.taitouLab.text = [NSString stringWithFormat:@"开票总额: %.2lf元", totalFee];
}




- (IBAction)xuanfapiao:(UIButton *)sender {
    
    TicketInfoVC *info = [[UIStoryboard storyboardWithName:@"Common" bundle:nil] instantiateViewControllerWithIdentifier:@"TicketInfoVC"];
    info.PassBillModel = ^(BillTicketModel *billModel) {
        self.taitouLab.text = billModel.kaipiaotaitou;
        self.fapiaoId = billModel.id;
    };
    [self.navigationController pushViewController:info animated:YES];
}


- (IBAction)confirm:(UIButton *)sender {
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    
    [dataDic setValue:[UserData currentUser].id forKey:@"userId"];
    [dataDic setValue:self.fapiaoId forKey:@"fapiaoId"];
    [dataDic setValue:@"" forKey:@"money"];
    [dataDic setValue:@"" forKey:@"orderNos"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dataDic imageArray:nil WithType:Interface_SaveKaipiao andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"开票成功!" time:0 aboutType:WHShowViewMode_Text state:YES];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold creatCell:@"TicketCell" table:tableView deledate:self model:[self.modelArr objectAtIndex:indexPath.row] data:nil andCliker:^(NSDictionary *clueDic) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"TicketCell" data:nil model:nil indexPath:indexPath];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
