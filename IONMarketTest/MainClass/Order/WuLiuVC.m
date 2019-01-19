//
//  WuLiuVC.m
//  IONMarketTest
//
//  Created by 赵越 on 2019/1/19.
//  Copyright © 2019 赵越. All rights reserved.
//

#import "WuLiuVC.h"
#import "PostListCell.h"

@interface WuLiuVC ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *numCode;

@property (nonatomic, strong) NSMutableArray *listArray;

@end

@implementation WuLiuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"物流跟踪";
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.listArray = [NSMutableArray array];
    [self.listArray addObjectsFromArray:@[@"1",@"1",@"1",@"1",@"1"]];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PostListCell *cell = [PostListCell initCell:tableView cellName:@"PostListCell" dataObject:nil];
    
    if (indexPath.row==0) {
        cell.topLine.hidden = YES;
        cell.centerImg.hidden = NO;
        cell.bottomLine.hidden = NO;
    } else if (indexPath.row == self.listArray.count-1) {
        cell.topLine.hidden = NO;
        cell.centerImg.hidden = NO;
        cell.bottomLine.hidden = YES;
    } else {
        cell.topLine.hidden = NO;
        cell.centerImg.hidden = YES;
        cell.bottomLine.hidden = NO;
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
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
