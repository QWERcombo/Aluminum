//
//  OrderListCell.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/17.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "OrderListCell.h"
#import "CALayer+Addition.h"
#import "ConfirmOrderCell.h"

@implementation OrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.statusButton.titleEdgeInsets = UIEdgeInsetsMake(0, -self.statusButton.imageView.width, 0, self.statusButton.imageView.width);
    self.statusButton.imageEdgeInsets = UIEdgeInsetsMake(0, self.statusButton.titleLabel.width, 0, -self.statusButton.titleLabel.width);
    
    self.caizhiBtn.time = 2;
    self.quxiaoBtn.time = 2;
    self.zhifuBtn.time = 2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

+ (float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
//    过期
    OrderListModel *dataModel = (OrderListModel *)model;
    NSInteger status = [dataModel.status integerValue];
    NSInteger count = dataModel.detail.count;
    
    return status==3?((32+10)+(count*72)):((32+40+10)+(count*72));
}

+ (instancetype)OrderListCell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}


- (IBAction)buyAction:(id)sender {
    if (_clikerBlock) {
        _clikerBlock(((UIButton *)sender).currentTitle);
    }
}

- (IBAction)serviceAction:(id)sender {
    if (_clikerBlock) {
        _clikerBlock(((UIButton *)sender).currentTitle);
    }
}

- (IBAction)cancelAction:(UIButton *)sender {
    if (_clikerBlock) {
        _clikerBlock(((UIButton *)sender).currentTitle);
    }
}

+ (instancetype)initCell:(UITableView *)tableView cellName:(NSString *)cellName dataObject:(id)dataObject {
    
    OrderListCell *cell = [super initCell:tableView cellName:cellName dataObject:dataObject];
    
    OrderListModel *dataM = (OrderListModel *)dataObject;
    
    cell.orderIDLabel.text = [NSString stringWithFormat:@"订单编号:%@", dataM.no];
    cell.zhifuBtn.layer.borderColor = [UIColor colorWithHexString:@"#6D9EF1"].CGColor;
    cell.zhifuBtn.layer.borderWidth = 0.5;
    [cell.zhifuBtn setTitleColor:[UIColor colorWithHexString:@"#6D9EF1"] forState:UIControlStateNormal];
    
    switch ([dataM.status integerValue]) {
        case 0:
            [cell.statusButton setTitle:@"待付款" forState:UIControlStateNormal];
            [cell.statusButton setTitleColor:[UIColor Grey_OrangeColor] forState:UIControlStateNormal];
            [cell.zhifuBtn setTitle:@" 前往支付 " forState:UIControlStateNormal];
            [cell.caizhiBtn setTitle:@" 材质证明 " forState:UIControlStateNormal];
            [cell.quxiaoBtn setTitle:@" 取消订单 " forState:UIControlStateNormal];
            cell.caizhiBtn.hidden = NO;
            break;
        case 1:
            [cell.statusButton setTitle:@"待收货" forState:UIControlStateNormal];
            [cell.statusButton setTitleColor:[UIColor mianColor:2] forState:UIControlStateNormal];
            [cell.zhifuBtn setTitle:@" 确认收货 " forState:UIControlStateNormal];
            [cell.quxiaoBtn setTitle:@" 材质证明 " forState:UIControlStateNormal];
            cell.caizhiBtn.hidden = YES;
            break;
        case 2:
            [cell.statusButton setTitle:@"完成" forState:UIControlStateNormal];
            [cell.statusButton setTitleColor:[UIColor Black_WordColor] forState:UIControlStateNormal];
            [cell.zhifuBtn setTitle:@" 材质证明 " forState:UIControlStateNormal];
            cell.caizhiBtn.hidden = YES;
            cell.quxiaoBtn.hidden = YES;
            
            break;
        case 3:
            [cell.statusButton setTitle:@"过期" forState:UIControlStateNormal];
            [cell.statusButton setTitleColor:[UIColor Grey_WordColor] forState:UIControlStateNormal];
            cell.buttonView.hidden = YES;
            [cell.buttonView setFrame:CGRectMake(0, 0, SCREEN_WIGHT, 0)];
            break;
        default:
            break;
    }
    if ([dataM.status integerValue] ==3) {
        cell.buttonView.hidden = YES;
        cell.buttonViewHeight.constant = 0;
    } else {
        cell.buttonView.hidden = NO;
        cell.buttonViewHeight.constant = 40;
    }
    
    for (UIView *subView in cell.itemView.subviews) {
        if ([subView isKindOfClass:[ConfirmOrderCell class]]) {
            [subView removeFromSuperview];
        }
    }
    
    for (NSInteger i=0; i<dataM.detail.count; i++) {

        ConfirmOrderCell *scell = [ConfirmOrderCell getConfirmOrderCell];
        [scell loadData:dataM.detail[i]];
        scell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        scell.frame = CGRectMake(0, 72*i, SCREEN_WIGHT, 72);
        if (i!=dataM.detail.count-1) {
            UIView *line_view = [[UIView alloc] initWithFrame:CGRectMake(0, 71, SCREEN_WIGHT, 1)];
            line_view.backgroundColor = [UIColor groupTableViewBackgroundColor];
            [scell addSubview:line_view];
        }
        
        [cell.itemView addSubview:scell];
    }
    
    
    return cell;
}

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click {
    _clikerBlock = click;
}

@end
