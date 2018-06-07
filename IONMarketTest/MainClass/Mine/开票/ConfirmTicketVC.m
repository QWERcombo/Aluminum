//
//  ConfirmTicketVC.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/6/6.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "ConfirmTicketVC.h"
#import "TicketInfoVC.h"

@interface ConfirmTicketVC ()
@property (weak, nonatomic) IBOutlet UILabel *dingdanhao;
@property (weak, nonatomic) IBOutlet UILabel *feiyong;
@property (weak, nonatomic) IBOutlet UILabel *wuliufei;
@property (weak, nonatomic) IBOutlet UILabel *xuanze;
@property (nonatomic, copy) NSString *fapiaoId;
@end

@implementation ConfirmTicketVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"开发票";
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.dingdanhao.text = self.model.no;
    self.wuliufei.text = self.model.wuliufei;
    self.feiyong.text = self.model.totalMoney;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        
        TicketInfoVC *info = [[UIStoryboard storyboardWithName:@"Common" bundle:nil] instantiateViewControllerWithIdentifier:@"TicketInfoVC"];
        info.PassBillModel = ^(BillTicketModel *billModel) {
            self.xuanze.text = billModel.kaipiaotaitou;
            self.fapiaoId = billModel.id;
        };
        [self.navigationController pushViewController:info animated:YES];
    }
}


- (IBAction)confirm:(UIButton *)sender {
    
    NSMutableDictionary *dataDic = [NSMutableDictionary dictionary];
    
    [dataDic setValue:[UserData currentUser].id forKey:@"userId"];
    [dataDic setValue:self.fapiaoId forKey:@"fapiaoId"];
    [dataDic setValue:self.model.totalMoney forKey:@"money"];
    [dataDic setValue:self.model.no forKey:@"orderNos"];
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dataDic imageArray:nil WithType:Interface_SaveKaipiao andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"开票成功!" time:0 aboutType:WHShowViewMode_Text state:YES];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
