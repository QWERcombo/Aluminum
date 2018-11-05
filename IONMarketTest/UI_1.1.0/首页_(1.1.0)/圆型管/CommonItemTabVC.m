//
//  CommonItemTabVC.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/11/4.
//  Copyright © 2018 赵越. All rights reserved.
//

#import "CommonItemTabVC.h"
#import "SelectThickView.h"

@interface CommonItemTabVC ()

@property (weak, nonatomic) IBOutlet UIImageView *zhengzhi_imgv;
@property (weak, nonatomic) IBOutlet UIImageView *zidingyi_imgv;
@property (weak, nonatomic) IBOutlet UILabel *zidingyi_right_label;
@property (weak, nonatomic) IBOutlet UILabel *zhengzhi_right_label;
@property (weak, nonatomic) IBOutlet UILabel *zhengzhi_left_label;
@property (weak, nonatomic) IBOutlet UILabel *zidingyi_left_label;
@property (weak, nonatomic) IBOutlet UITextField *lengthTF;
@property (weak, nonatomic) IBOutlet UITextField *amountTF;
@property (weak, nonatomic) IBOutlet UILabel *danjianzhongliang;
@property (weak, nonatomic) IBOutlet UILabel *danjianjiage;
@property (weak, nonatomic) IBOutlet UILabel *jianshu;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *guigeLabel;

@property (nonatomic, assign) BOOL isShowLength;
@property (nonatomic, assign) BOOL isShowInfoView;

@end

@implementation CommonItemTabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            return 8;
            break;
        case 1:
            return 50;
            break;
        case 2:
            return 50;
            break;
        case 3:
            return 50;
            break;
        case 4:
            return 6;
            break;
        case 5:
            //长度
            return _isShowLength?50:0;
            break;
        case 6:
            return 60;
            break;
        case 7:
            return _isShowInfoView?138:0;
            break;
        default:
            return 0;
            break;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        NSMutableArray *arr = [NSMutableArray array];
        for (NSInteger i=0; i<50; i++) {
            
            [arr addObject:[NSString stringWithFormat:@"%ld", (long)i]];
        }
        
        SelectShowType type;
        switch (self.showType) {
            case ShowType_YuanBang:
                type = SelectShowType_YuanBang;
                break;
            case ShowType_GuanCai:
                type = SelectShowType_GuanCai;
                break;
            case ShowType_XingCai:
                type = SelectShowType_XingCai;
                break;
            default:
                break;
        }
        
        [SelectThickView showSelectThickViewWithSelectShowType:type erjimulu_id:@"" selectBlock:^(NSString * _Nonnull selectIndexString) {
            
        }];
    }
}


#pragma mark - Handle
//自定义
- (IBAction)ziDingYi:(UIButton *)sender {
    _isShowLength = YES;
    _isShowInfoView = YES;
    
    self.zidingyi_imgv.image = [UIImage imageNamed:@"select_1"];
    self.zidingyi_left_label.textColor = [UIColor mianColor:2];
    self.zidingyi_right_label.textColor = [UIColor Grey_OrangeColor];
    self.zidingyi_right_label.text = @"20.50元/公斤";
    self.zidingyi_right_label.attributedText = [UILabel getAttributedFromRange:[self.zidingyi_right_label.text rangeOfString:@"元/公斤"] WithColor:[UIColor Grey_OrangeColor] andFont:[UIFont systemFontOfSize:10] allFullText:self.zidingyi_right_label.text];
    
    self.zhengzhi_imgv.image = [UIImage imageNamed:@"select_0"];
    self.zhengzhi_left_label.textColor = [UIColor colorWithHexString:@"#202124"];
    self.zhengzhi_right_label.textColor = [UIColor Grey_WordColor];
    self.zhengzhi_right_label.text = @"19.50元/公斤";
    self.zhengzhi_right_label.attributedText = [UILabel getAttributedFromRange:[self.zhengzhi_right_label.text rangeOfString:@"元/公斤"] WithColor:[UIColor Grey_WordColor] andFont:[UIFont systemFontOfSize:10] allFullText:self.zhengzhi_right_label.text];
    
    
    [self.tableView reloadData];
}
//整只
- (IBAction)zhengZhi:(UIButton *)sender {
    _isShowLength = NO;
    _isShowInfoView = YES;
    
    self.zidingyi_imgv.image = [UIImage imageNamed:@"select_0"];
    self.zidingyi_left_label.textColor = [UIColor colorWithHexString:@"#202124"];
    self.zidingyi_right_label.textColor = [UIColor Grey_WordColor];
    self.zidingyi_right_label.text = @"20.50元/公斤";
    self.zidingyi_right_label.attributedText = [UILabel getAttributedFromRange:[self.zidingyi_right_label.text rangeOfString:@"元/公斤"] WithColor:[UIColor Grey_WordColor] andFont:[UIFont systemFontOfSize:10] allFullText:self.zidingyi_right_label.text];
    
    self.zhengzhi_imgv.image = [UIImage imageNamed:@"select_1"];
    self.zhengzhi_left_label.textColor = [UIColor mianColor:2];
    self.zhengzhi_right_label.textColor = [UIColor Grey_OrangeColor];
    self.zhengzhi_right_label.text = @"19.50元/公斤";
    self.zhengzhi_right_label.attributedText = [UILabel getAttributedFromRange:[self.zhengzhi_right_label.text rangeOfString:@"元/公斤"] WithColor:[UIColor Grey_OrangeColor] andFont:[UIFont systemFontOfSize:10] allFullText:self.zhengzhi_right_label.text];
    
    [self.tableView reloadData];
}



- (void)refreshInfoToReset {
    
    
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
