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
    
    if ([type isEqualToString:@"MainItemCell"]) {
        static NSString *IDs = @"MainItemCell";
        MainItemCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [MainItemCell MainItemCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model andCliker:^(NSString *clueStr) {

        }];
        return cell;
    }
    else if ([type isEqualToString:@"QuotationDetailCell"]) {
        static NSString *IDs = @"QuotationDetailCell";
        QuotationDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [QuotationDetailCell getQuotationDetailCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model andCliker:^(NSString *clueStr) {
            
        }];
        return cell;
    }
    else if ([type isEqualToString:@"OrderListCell"]) {
        static NSString *IDs = @"OrderListCell";
        OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [OrderListCell OrderListCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model andCliker:^(NSString *clueStr) {
            clue(@{@"key":clueStr});
        }];
        return cell;
    }
    else if ([type isEqualToString:@"OrderDetailCell"]) {
        static NSString *IDs = @"OrderDetailCell";
        OrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [OrderDetailCell getOrderDetailCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model andCliker:^(NSString *clueStr) {
//            clue(@{@"key":clueStr});
        }];
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
    
    if ([type isEqualToString:@"MainItemCell"]) {
        return [MainItemCell getCellHight:data Model:model indexPath:indexpath];
    } else if ([type isEqualToString:@"OrderListCell"]) {
        return [OrderListCell getCellHight:data Model:model indexPath:indexpath];
    } else if ([type isEqualToString:@"QuotationDetailCell"]) {
        return [QuotationDetailCell getCellHight:data Model:model indexPath:indexpath];
    } else if ([type isEqualToString:@"OrderDetailCell"]) {
        return [OrderDetailCell getCellHight:data Model:model indexPath:indexpath];
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
        ABBannerView *bannerView = [[ABBannerView alloc] initPageViewFrame:CGRectMake(0, 0, SCREEN_WIGHT, 160) webImageStr:IMGArr titleStr:nil didSelectPageViewAction:^(NSInteger index) {
            NSLog(@"click---%ld", index);
            
        }];
        
        bannerView.duration = 5.0;
        bannerView.selfBackgroundColor = [UIColor Grey_BackColor1];
        bannerView.pageIndicatorTintColor = [UIColor lightTextColor];
        bannerView.currentPageColor = [UIColor mianColor:1];
        backView = bannerView;
        
        return backView;
    }
    
    else if ([type isEqualToString:@"SlideSwitchView"]){
        SlideSwitchView *slideView;
        NSMutableArray *dataAr = [NSMutableArray array];
//        NSArray *topName = [model mutableCopy];
            for (NSInteger i=0; i<4; i++) {
//                OrderListViewController *circle = [[OrderListViewController alloc] init];
//                circle.delegate = delegate;
//                circle.nameTitle = [topName objectAtIndex:i];
//                [dataAr addObject:circle];
            }
        UIViewController *mainViewController = (UIViewController *)delegate;
            slideView = [[SlideSwitchView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIGHT, mainViewController.view.size.height-50)];
            slideView.tabItemNormalColor = [UIColor mianColor:2];
            slideView.tabItemSelectedColor = [UIColor mianColor:2];
            slideView.tabItemBannerNormalColor = [UIColor whiteColor];
            slideView.tabItemBannerSelectedColor = [UIColor mianColor:2];
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
