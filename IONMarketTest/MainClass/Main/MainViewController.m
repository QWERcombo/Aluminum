//
//  MainViewController.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/8.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "MainViewController.h"
#import "SelectedItem.h"
#import "MainItemViewController.h"
#import "SetOrderViewController.h"
#import "QuotationViewController.h"
#import "QuotationDetailViewController.h"
#import "MessageViewController.h"
#import "SpecialMakeViewController.h"
#import "InventoryViewController.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MainViewController

#define Item_Margin  ((SCREEN_WIGHT-40*4)/5)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    for (NSInteger i = 0 ; i<10; i++) {
        NSString *string = @"";
        if (i%2==0) {
            string = @"+ 100";
        } else {
            string = @" - 100";
        }
        [self.dataMuArr addObject:string];
    }
    [self getDataSource];
}


#pragma mark --- Delegate&DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section==2?self.dataMuArr.count:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold creatCell:@"MainItemCell" table:tableView deledate:self model:[self.dataMuArr objectAtIndex:indexPath.row] data:nil andCliker:^(NSDictionary *clueDic) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UtilsMold getCellHight:@"MainItemCell" data:nil model:nil indexPath:indexPath];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return [self createTopView];
    } else if (section==1) {
        return [self createSectionView];
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 340;
    } else if (section==1) {
        return 40;
    } else {
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QuotationDetailViewController *detail = [QuotationDetailViewController new];
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark ---- CreateSubViews
- (UIView *)createTopView {
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 340)];
    mainView.backgroundColor = [UIColor whiteColor];

    UIImageView *bannerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 140)];
    bannerView.backgroundColor = [UIColor purpleColor];
    [mainView addSubview:bannerView];
    
    NSArray *nameArr = @[@"整板",@"零切",@"圆棒",@"型材",@"管材",@"特殊定制",@"自动下单",@"询价"];
    for (NSInteger i=0; i<2; i++) {
        for (NSInteger j=0; j<4; j++) {
            SelectedItem *item = [[SelectedItem alloc] initWithFrame:CGRectMake((Item_Margin+40)*j+Item_Margin, ((65+(70/3))*i)+140+35, 40, 65)];
            item.item_name.text = [nameArr objectAtIndex:i*4+j];
            NSString *imageName = [NSString stringWithFormat:@"Main_item_%ld", (long)(i*2+j)];
            item.item_imgv.image = IMG(imageName);
            
            [item loadData:nil andCliker:^(NSString *clueStr) {
                NSLog(@"%@", clueStr);
                NSString *name = [nameArr objectAtIndex:clueStr.integerValue];
                if ([name isEqualToString:@"自动下单"]) {
                    SetOrderViewController *set = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SetOrder"];
                    [self.navigationController pushViewController:set animated:YES];
                } else if ([name isEqualToString:@"特殊定制"]) {
                    SpecialMakeViewController *special = [SpecialMakeViewController new];
                    [self.navigationController pushViewController:special animated:YES];
                } else if ([name isEqualToString:@"询价"]) {
                    MessageViewController *message = [MessageViewController new];
                    [self.navigationController pushViewController:message animated:YES];
                } else if ([name isEqualToString:@"整板"]) {
                    InventoryViewController *inven = [InventoryViewController new];
                    [self.navigationController pushViewController:inven animated:YES];
                } else {
                    MainItemViewController *main_item = [[MainItemViewController alloc] init];
                    main_item.titleStr = name;
                    main_item.selectedNum = [clueStr integerValue]-1;
                    [self.navigationController pushViewController:main_item animated:YES];
                }
            }];
            [mainView addSubview:item];
        }
    }
    
    
    return mainView;
}

- (UIView *)createSectionView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, 40)];
    UILabel *leftlabel = [UILabel lableWithText:@"自选关注" Font:FONT_BoldMT(15) TextColor:[UIColor Black_WordColor]];
    [headerView addSubview:leftlabel];
    [leftlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView.mas_centerY);
        make.left.equalTo(headerView.mas_left).offset(15);
        make.height.equalTo(@(15));
    }];
    
    UIButton *rightlabel = [UIButton buttonWithTitle:@"查看全部" andFont:FONT_ArialMT(13) andtitleNormaColor:[UIColor mianColor:3] andHighlightedTitle:[UIColor mianColor:3] andNormaImage:nil andHighlightedImage:nil];
    [rightlabel setImage:IMG(@"image_more") forState:UIControlStateNormal];
    
    [rightlabel addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:rightlabel];
    [rightlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(15));
        make.centerY.equalTo(headerView.mas_centerY);
        make.right.equalTo(headerView.mas_right).offset(-10);
    }];
    
    rightlabel.titleEdgeInsets = UIEdgeInsetsMake(0, -rightlabel.imageView.width, 0, rightlabel.imageView.width);
    rightlabel.imageEdgeInsets = UIEdgeInsetsMake(0, rightlabel.titleLabel.width, 0, -rightlabel.titleLabel.width-5);
    
    return headerView;
}

#pragma mark ---- Action

- (void)moreAction:(UIButton *)sender {
    NSLog(@"查看更多");
    QuotationViewController *quo = [QuotationViewController new];
    [self.navigationController pushViewController:quo animated:YES];
    
}

#pragma mark ----- DataSource

- (void)getDataSource {
    
    
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
