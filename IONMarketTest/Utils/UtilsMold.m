//
//  UtilsMold.m
//  GoGoTree
//
//  Created by youqin on 16/8/11.
//  Copyright © 2016年 t_b. All rights reserved.
//

#import "UtilsMold.h"
@interface UtilsMold ()<SlideSwitchViewDelegate>

@end

@implementation UtilsMold

DEF_SINGLETON(UtilsMold);

+ (UITableViewCell *)creatCell:(NSString *)type  table:(UITableView *)tableView deledate:(UIViewController *)deledate model:(NSObject *)model data:(id)data andCliker:(ShowBlock)clue
{
    
    if ([type isEqualToString:@"BaseCell"]) {
        static NSString *IDs = @"BaseCell";
        BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [[BaseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDs];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [cell loadData:model andCliker:^(NSString *clueStr) {
//
//        }];
        return cell;
    }
    
    
    else
    {
        static NSString *IDs = @"Basecell";
        BaseCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [[BaseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDs];
        }
//        cell.imageView.image = IMG(@"");
//        cell.textLabel.text =@"";
        return cell;
    }
    
    return nil;
}

+ (float)getCellHight:(NSString *)type data:(id)data model:(NSObject *)model indexPath:(NSIndexPath *)indexpath;
{
    
    if ([type isEqualToString:@"BaseCell"]) {
        return [BaseCell getCellHight:data Model:model indexPath:indexpath];
    }
    
    
    
    
    
    
    
    
    
    else {
        return 44;
    }
    
}

- (UIView *)creatView:(NSString *)type data:(id)data  model:(NSObject *)model deleGate:(id)delegate andCliker:(ShowBlock)clue{
    __showBlock = clue;
    
    UIView *backView = nil;
    if ([type isEqualToString:@"ABBannerView"]){
        NSMutableArray *IMGArr = [NSMutableArray array];
        NSArray *dataSource = [model mutableCopy];
        for (int i = 0; i < dataSource.count; i ++) {
            [IMGArr addObject:[dataSource objectAtIndex:i]];
        }
        ABBannerView *bannerView = nil;
//        ABBannerView *bannerView = [[ABBannerView alloc] initPageViewFrame:CGRectMake(0, 0, SCREEN_WIGHT, [delegate isKindOfClass:[MainViewController class]]?175:133) webImageStr:IMGArr titleStr:nil didSelectPageViewAction:^(NSInteger index) {
//            NSLog(@"click---%ld", index);
//        }];
        
        bannerView.duration = 5.0;
        bannerView.selfBackgroundColor = [UIColor Grey_BackColor1];
        bannerView.pageIndicatorTintColor = [UIColor lightTextColor];
        bannerView.currentPageColor = [UIColor mianColor:1];
//        [backView addSubview:bannerView];
        backView = bannerView;
        
        return backView;
    }
    
    else if ([type isEqualToString:@"SlideSwitchView"]){
        SlideSwitchView *slideView;
        NSMutableArray *dataAr = [NSMutableArray array];

            for (NSInteger i=0; i<3; i++) {
//                BillListViewController *circle = [[BillListViewController alloc] init];
//                circle.delegate = delegate;
//                circle.nameTitle = SINT(i);
//                [dataAr addObject:circle];
            }
            slideView = [[SlideSwitchView alloc] initWithFrame:CGRectZero];
            slideView.tabItemNormalColor = [UIColor Black_WordColor];
            slideView.tabItemSelectedColor = [UIColor mianColor:1];
            slideView.tabItemBannerNormalColor = [UIColor whiteColor];
            slideView.tabItemBannerSelectedColor = [UIColor mianColor:1];
            [slideView buildUIWithViews:dataAr andClikBlock:^(NSString *clueStr) {
                
            }];
            [slideView setHideTopView:NO];
        
        return slideView;
    }
    
    else{
        NSLog(@"没有找到所属view");
        return nil;
    }
}


@end
