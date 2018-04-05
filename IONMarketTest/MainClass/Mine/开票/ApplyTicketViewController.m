//
//  ApplyTicketViewController.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/21.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "ApplyTicketViewController.h"

@interface ApplyTicketViewController ()

@end

@implementation ApplyTicketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"新增开票信息";
    if ([self.mode isEqualToString:@"111"]) {
        [self.dataMuArr addObjectsFromArray:@[self.billModel.kaipiaotaitou, self.billModel.shuihao,self.billModel.duigongzhanghu,self.billModel.zhanghukaihuhang,self.billModel.gongsizhucedizhi,self.billModel.gongsizhucezuojihao,self.billModel.shoujianren,self.billModel.shoujiandizhi,self.billModel.shoujihao,self.billModel.yingyewangzhi]];
        
        for (NSInteger i=100; i<110; i++) {
            UITextField *textField = [self.view viewWithTag:i];
            textField.placeholder = [self.dataMuArr objectAtIndex:i-100];
        }
    }
}

- (BOOL)checkInfo {
    
    for (NSInteger i=100; i<110; i++) {
        
        UITextField *textField = [self.view viewWithTag:i];
        if ([self.mode isEqualToString:@"111"]) {
            if (textField.text.length) {
                [self.dataMuArr replaceObjectAtIndex:i-100 withObject:textField.text];
            } else {
            }
        } else {
            if (!textField.text.length) {
                return NO;
                break;
            } else {
                [self.dataMuArr addObject:textField.text];
            }
        }
        
    }
    
    return YES;
}


- (IBAction)doneAc:(UIButton *)sender {
    
    if (![self checkInfo]) {
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:@"请填写完整信息！" time:0 aboutType:WHShowViewMode_Text state:NO];
        return;
    }
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:self.dataMuArr[0] forKey:@"kaipiaotaitou"];
    [dict setValue:self.dataMuArr[1] forKey:@"shuihao"];
    [dict setValue:self.dataMuArr[2] forKey:@"duigongzhanghu"];
    [dict setValue:self.dataMuArr[3] forKey:@"zhanghukaihuhang"];
    [dict setValue:self.dataMuArr[4] forKey:@"gongsizhucedizhi"];
    [dict setValue:self.dataMuArr[5] forKey:@"gongsizhucezuojihao"];
    [dict setValue:self.dataMuArr[6] forKey:@"shoujianren"];
    [dict setValue:self.dataMuArr[7] forKey:@"shoujiandizhi"];
    [dict setValue:self.dataMuArr[8] forKey:@"shoujihao"];
    [dict setValue:self.dataMuArr[9] forKey:@"yingyewangzhi"];
    if ([self.mode isEqualToString:@"111"]) {
        [dict setValue:self.billModel.id forKey:@"fapiaoId"];
    } else {
        [dict setValue:[UserData currentUser].id forKey:@"userId"];
    }
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:dict imageArray:nil WithType:[self.mode isEqualToString:@"111"]?Interface_UpdateFapiao:Interface_SaveFapiao andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        NSLog(@"++--++%@", resultDic);
        [[UtilsData sharedInstance] showAlertTitle:@"" detailsText:msg time:0 aboutType:WHShowViewMode_Text state:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshFaPiaoNewData" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
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
