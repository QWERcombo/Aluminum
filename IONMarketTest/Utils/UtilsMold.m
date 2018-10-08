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
        [cell loadData:model delegate:deledate andCliker:^(NSString *clueStr) {
//            clue(@{@"key":clueStr});
        }];
        return cell;
    }
    else if ([type isEqualToString:@"InventoryCell"]) {
        static NSString *IDs = @"InventoryCell";
        InventoryCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [InventoryCell getInventoryCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model andCliker:^(NSString *clueStr) {
            
        }];
        return cell;
    }
    else if ([type isEqualToString:@"WallentListCell"]) {
        static NSString *IDs = @"WallentListCell";
        WallentListCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [WallentListCell getWallentListCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model andCliker:^(NSString *clueStr) {

        }];
        return cell;
    }
    else if ([type isEqualToString:@"RemainExplainCell"]) {
        static NSString *IDs = @"RemainExplainCell";
        RemainExplainCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [RemainExplainCell getRemainExplainCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model andCliker:^(NSString *clueStr) {
            
        }];
        return cell;
    }
    else if ([type isEqualToString:@"BankCardCell"]) {
        static NSString *IDs = @"BankCardCell";
        BankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [BankCardCell getBankCardCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model andCliker:^(NSString *clueStr) {
            
        }];
        return cell;
    }
    else if ([type isEqualToString:@"AddressCell"]) {
        static NSString *IDs = @"AddressCell";
        AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [AddressCell getAddressCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model andCliker:^(NSString *clueStr) {
            clue(@{@"key":clueStr});
        }];
        return cell;
    }
    else if ([type isEqualToString:@"TicketCell"]) {
        static NSString *IDs = @"TicketCell";
        TicketCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [TicketCell getTicketCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model isWeiKaiPiao:[data boolValue] andCliker:^(NSString *clueStr) {
            clue(@{@"key":clueStr});
        }];
        return cell;
    }
    else if ([type isEqualToString:@"TicketInfoCell"]) {
        static NSString *IDs = @"TicketInfoCell";
        TicketInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [TicketInfoCell getTicketInfoCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model andCliker:^(NSString *clueStr) {
            clue(@{@"key":clueStr});
        }];
        return cell;
    }
    else if ([type isEqualToString:@"EndTicketCell"]) {
        static NSString *IDs = @"EndTicketCell";
        EndTicketCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [EndTicketCell getEndTicketCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model andCliker:^(NSString *clueStr) {
            clue(@{@"key":clueStr});
        }];
        return cell;
    }
    else if ([type isEqualToString:@"SmartServiceCell"]) {
        static NSString *IDs = @"SmartServiceCell";
        SmartServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [SmartServiceCell getSmartServiceCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model andCliker:^(NSString *clueStr) {
            
        }];
        return cell;
    }
    else if ([type isEqualToString:@"ShopCarListCell"]) {
        static NSString *IDs = @"ShopCarListCell";
        ShopCarListCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [ShopCarListCell getShopCarListCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model andCliker:^(NSString *clueStr) {
            clue(@{@"key":clueStr});
        }];
        return cell;
    }
    else if ([type isEqualToString:@"ShopCarNewListCell"]) {
        static NSString *IDs = @"ShopCarNewListCell";
        ShopCarNewListCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [ShopCarNewListCell getShopCarNewListCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model andCliker:^(NSString *clueStr) {
            clue(@{@"key":clueStr});
        }];
        return cell;
    }
    else if ([type isEqualToString:@"TradeRecordCell"]) {
        static NSString *IDs = @"TradeRecordCell";
        TradeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [TradeRecordCell getTradeRecordCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model delegate:(NSString *)data andCliker:^(NSString *clueStr) {
            clue(@{@"key":clueStr});
        }];
        return cell;
    }
    else if ([type isEqualToString:@"WhiteBarCell"]) {
        static NSString *IDs = @"WhiteBarCell";
        WhiteBarCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [WhiteBarCell getWhiteBarCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model andCliker:^(NSString *clueStr) {
            clue(@{@"key":clueStr});
        }];
        return cell;
    }
    else if ([type isEqualToString:@"WithdrawRecordCell"]) {
        static NSString *IDs = @"WithdrawRecordCell";
        WithdrawRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [WithdrawRecordCell getWithdrawRecordCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model andCliker:^(NSString *clueStr) {
            clue(@{@"key":clueStr});
        }];
        return cell;
    }
    else if ([type isEqualToString:@"WuLiuCell"]) {
        static NSString *IDs = @"WuLiuCell";
        WuLiuCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [WuLiuCell WuLiuCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model name:data andCliker:^(NSString *clueStr) {
            
        }];
        return cell;
    }
    else if ([type isEqualToString:@"ConfirmOrderCell"]) {
        static NSString *IDs = @"ConfirmOrderCell";
        ConfirmOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:IDs];
        if (cell == nil) {
            cell = [ConfirmOrderCell getConfirmOrderCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell loadData:model];
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
    } else if ([type isEqualToString:@"InventoryCell"]) {
        
        return [InventoryCell getCellHight:data Model:model indexPath:indexpath];
    } else if ([type isEqualToString:@"WallentListCell"]) {
        
        return [WallentListCell getCellHight:data Model:model indexPath:indexpath];
    } else if ([type isEqualToString:@"BankCardCell"]) {
        
        return [BankCardCell getCellHight:data Model:model indexPath:indexpath];
    } else if ([type isEqualToString:@"AddressCell"]) {
        
        return [AddressCell getCellHight:data Model:model indexPath:indexpath];
    } else if ([type isEqualToString:@"TicketCell"]) {
        
        return [TicketCell getCellHight:data Model:model indexPath:indexpath];
    } else if ([type isEqualToString:@"TicketInfoCell"]) {
        
        return [TicketInfoCell getCellHight:data Model:model indexPath:indexpath];
    } else if ([type isEqualToString:@"EndTicketCell"]) {
        
        return [EndTicketCell getCellHight:data Model:model indexPath:indexpath];
    } else if ([type isEqualToString:@"SmartServiceCell"]) {
        
        return [SmartServiceCell getCellHight:data Model:model indexPath:indexpath];
    } else if ([type isEqualToString:@"ShopCarListCell"]) {
        
        return [ShopCarListCell getCellHight:data Model:model indexPath:indexpath];
    } else if ([type isEqualToString:@"ShopCarNewListCell"]) {
        
        return [ShopCarNewListCell getCellHight:data Model:model indexPath:indexpath];
    } else if ([type isEqualToString:@"TradeRecordCell"]) {
        
        return [TradeRecordCell getCellHight:data Model:model indexPath:indexpath];
    } else if ([type isEqualToString:@"WhiteBarCell"]) {
        
        return [WhiteBarCell getCellHight:data Model:model indexPath:indexpath];
    } else if ([type isEqualToString:@"WithdrawRecordCell"]) {
        
        return [WithdrawRecordCell getCellHight:data Model:model indexPath:indexpath];
    } else if ([type isEqualToString:@"WuLiuCell"]) {
        
        return [WuLiuCell getCellHight:data Model:model indexPath:indexpath];
    } else if ([type isEqualToString:@"ConfirmOrderCell"]) {
        
        return [ConfirmOrderCell getCellHight:data Model:model indexPath:indexpath];
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
        bannerView.currentPageColor = [UIColor mianColor:2];
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
