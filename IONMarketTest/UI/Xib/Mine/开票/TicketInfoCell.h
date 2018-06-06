//
//  TicketInfoCell.h
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/21.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "BaseCell.h"

@protocol RadioSelectDelegate;

@interface TicketInfoCell : BaseCell

@property (weak, nonatomic) IBOutlet UILabel *duigongzhanghu;
@property (weak, nonatomic) IBOutlet UILabel *phoneLab;
@property (weak, nonatomic) IBOutlet UILabel *fapiaotaitou;
@property (weak, nonatomic) IBOutlet UILabel *shuihao;


@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) id <RadioSelectDelegate> delegate;
@property (nonatomic, copy) ClikBlock click;

+ (instancetype)getTicketInfoCell;

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click;

@end


@protocol RadioSelectDelegate <NSObject>

- (void)radioSelectedWithIndexPath:(NSIndexPath *)indexPath;

@end
