//
//  UtilsMold.h
//  GoGoTree
//
//  Created by youqin on 16/8/11.
//  Copyright © 2016年 t_b. All rights reserved.
//

#import <Foundation/Foundation.h>

//Cell
#import "MainItemCell.h"
#import "QuotationDetailCell.h"
#import "OrderListCell.h"
#import "OrderDetailCell.h"
#import "InventoryCell.h"
#import "WallentListCell.h"
#import "RemainExplainCell.h"
#import "BankCardCell.h"
#import "AddressCell.h"
#import "TicketCell.h"
#import "TicketInfoCell.h"
#import "EndTicketCell.h"
#import "SmartServiceCell.h"
#import "ShopCarListCell.h"
#import "ShopCarNewListCell.h"
#import "TradeRecordCell.h"
#import "WhiteBarCell.h"
#import "WithdrawRecordCell.h"
#import "WuLiuCell.h"
#import "ConfirmOrderCell.h"



//View
#import "ABBannerView.h"
#import "SlideSwitchView.h"


@interface UtilsMold : NSObject

AS_SINGLETON(UtilsMold);

typedef void (^ShowBlock)(NSDictionary *clueDic);

@property (nonatomic, copy) ShowBlock _showBlock;


//cell
+ (UITableViewCell *)creatCell:(NSString *)type table:(UITableView *)tableView deledate:(UIViewController *)deledate model:(NSObject *)model data:(id)data andCliker:(ShowBlock)clue;
//cel高度
+ (float)getCellHight:(NSString *)type data:(id)data model:(NSObject *)model indexPath:(NSIndexPath *)indexpath;
//view
- (UIView *)creatView:(NSString *)type data:(id)data  model:(NSObject *)model deleGate:(id)delegate andCliker:(ShowBlock)clue;

@end
