//
//  WhiteBarVC.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/6/4.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "WhiteBarVC.h"

@interface WhiteBarVC ()
@property (weak, nonatomic) IBOutlet UITableView *whiteBarTableView;
@property (weak, nonatomic) IBOutlet UILabel *totalFeeLab;
@property (weak, nonatomic) IBOutlet UILabel *availFeeLab;
@property (weak, nonatomic) IBOutlet UILabel *huankuanLab;

@end

@implementation WhiteBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *recordBtn = [UIButton buttonWithTitle:@"还款记录" andFont:FONT_ArialMT(15) andtitleNormaColor:[UIColor whiteColor] andHighlightedTitle:[UIColor whiteColor] andNormaImage:nil andHighlightedImage:nil];
    recordBtn.frame = CGRectMake(0, 0, 70, 40);
    [recordBtn addTarget:self action:@selector(payCliker:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:recordBtn];
}

- (void)payCliker:(UIButton *)sender {
    
    
    
    
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
