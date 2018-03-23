//
//  MainItemCell.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/3/12.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "MainItemCell.h"

@implementation MainItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(float)getCellHight:(id)data Model:(NSObject *)model indexPath:(NSIndexPath *)indexpath {
    return 55;
}

+ (instancetype)MainItemCell {
    return [[[NSBundle mainBundle] loadNibNamed:@"MainItemCell" owner:nil options:nil] firstObject];
}

- (void)loadData:(NSObject *)model andCliker:(ClikBlock)click {
    NSString *string = (NSString *)model;
    self.rightCountLabel.text = string;
    if ([[string substringToIndex:1] isEqualToString:@"+"]) {
        self.rightCountLabel.backgroundColor = [UIColor colorWithHexString:@"#A0DAA8"];
    } else {
        self.rightCountLabel.backgroundColor = [UIColor colorWithHexString:@"#D97078"];
    }
    CGSize size = [UILabel getSizeWithText:string andFont:FONT_ArialMT(13) andSize:CGSizeMake(0, 25)];
    self.rightCountLabel.layer.cornerRadius = 3;
    self.rightCountLabel.layer.masksToBounds = YES;
    [self.rightCountLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.width.equalTo(@(size.width+20));
        make.height.equalTo(@(25));
    }];
    
    
    
    
}

@end
