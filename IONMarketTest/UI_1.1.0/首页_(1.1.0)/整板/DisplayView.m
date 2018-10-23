//
//  DisplayView.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2018/10/23.
//  Copyright © 2018年 赵越. All rights reserved.
//

#import "DisplayView.h"

@implementation DisplayView


- (instancetype)initWithFrame:(CGRect)frame andDataArr:(NSArray *)dataArr
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"DisplayView" owner:self options:nil] firstObject];
        self.dataSource = [NSMutableArray arrayWithArray:dataArr];
        
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"display_cell"];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeTap:)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        
        self.frame = frame;
    }
    return self;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([touch.view isKindOfClass:[DisplayView class]]) {
        
        return YES;
    } else {
        
        return NO;
    }
}



#pragma mark - CollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"display_cell" forIndexPath:indexPath];
    
    UILabel *showLabel = [[UILabel alloc] initWithFrame:cell.contentView.bounds];
    showLabel.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    showLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    showLabel.font = [UIFont systemFontOfSize:15];
    showLabel.textColor = [UIColor colorWithHexString:@"#333336"];
    showLabel.textAlignment = NSTextAlignmentCenter;
    showLabel.layer.cornerRadius = 3;
    showLabel.layer.masksToBounds = YES;
    
    [cell.contentView addSubview:showLabel];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectedBlock) {
//        self.selectedBlock([self.dataSource objectAtIndex:indexPath.row]);
        self.selectedBlock([NSString stringWithFormat:@"%ld", indexPath.row]);
        [self removeTap:nil];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((SCREEN_WIGHT-30-32)/3.0, 40);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 16;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 16;
}


+ (void)showDisplayViewWithDataSource:(NSArray *)dataSource selectedIndexPath:(SelectedIndexPath)selectedBlock {
    
    DisplayView *displayV = [[DisplayView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIGHT, SCREEN_HEIGHT-64) andDataArr:dataSource];
    displayV.selectedBlock = selectedBlock;
    displayV.contentView.frame = CGRectMake(0, -204, SCREEN_WIGHT, 204);
    
    [UIView animateWithDuration:0.3 animations:^{
        displayV.contentView.frame = CGRectMake(0, 0, SCREEN_WIGHT, 204);
        
    }];
    
    
    [MY_WINDOW addSubview:displayV];
    
}

- (void)removeTap:(UITapGestureRecognizer *)sender {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.contentView.frame = CGRectMake(0, -204, SCREEN_WIGHT, 204);
        
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
    
}


@end
