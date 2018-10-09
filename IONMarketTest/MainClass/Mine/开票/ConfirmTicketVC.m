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
@property (weak, nonatomic) IBOutlet UILabel *wuliufeiLab;
@property (weak, nonatomic) IBOutlet UILabel *chanpinLab;

@property (nonatomic, copy) NSString *fapiaoId;
@property (nonatomic, copy) NSString *totalFee;
@property (nonatomic, copy) NSString *wuliufeiFee;
@property (nonatomic, copy) NSString *orderNos;
@end

@implementation ConfirmTicketVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"开发票";
    
    CGFloat totalFee = 0.0;
    CGFloat wuliufeiFee = 0.0;
    NSMutableString *orderString = [NSMutableString string];
    for (OrderListModel *model in self.modelArr) {
        
        totalFee+= [model.totalMoney floatValue];
        wuliufeiFee+= [model.wuliufei floatValue];
        [orderString appendString:model.no];
        [orderString appendString:@","];
    }
    
    self.orderNos = [orderString substringToIndex:orderString.length-1];
    self.totalFee = [NSString getStringAfterTwo:[NSNumber numberWithFloat:totalFee].stringValue];
    self.wuliufeiFee = [NSString getStringAfterTwo:[NSNumber numberWithFloat:wuliufeiFee].stringValue];
    self.totalLab.text = [NSString stringWithFormat:@"开票总额: %@元", [NSString getStringAfterTwo:[NSNumber numberWithFloat:([self.totalFee floatValue]+[self.wuliufeiFee floatValue])].stringValue]];
    self.wuliufeiLab.text = [NSString stringWithFormat:@"物流费: %@元", self.wuliufeiFee];
    self.chanpinLab.text = [NSString stringWithFormat:@"产品总额: %@元", self.totalFee];
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
    
    if (!self.fapiaoId.length) {
        
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请先选择发票抬头！" time:0.0 aboutType:WHShowViewMode_Text state:NO];
        
        return;
    }
    
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    
    [dataDic setValue:[UserData currentUser].id forKey:@"userId"];
    [dataDic setValue:self.fapiaoId forKey:@"fapiaoId"];
    [dataDic setValue:self.totalFee forKey:@"money"];
    [dataDic setValue:self.wuliufeiFee forKey:@"wuliufei"];
    [dataDic setValue:self.orderNos forKey:@"orderNos"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dataDic imageArray:nil WithType:Interface_SaveKaipiao andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"开票成功!" time:0 aboutType:WHShowViewMode_Text state:YES];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
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
