//
//  SelectThickView.m
//  IONMarketTest
//
//  Created by 赵越 on 2018/10/23.
//  Copyright © 2018 赵越. All rights reserved.
//

#import "SelectThickView.h"

@implementation SelectThickView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame dataArr:(NSArray *)dataArr
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"SelectThickView" owner:self options:nil] firstObject];
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewCell"];
        self.dataSource = [NSMutableArray arrayWithArray:dataArr];
        
        self.frame = frame;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeTap:)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([touch.view isKindOfClass:[SelectThickView class]]) {
        return YES;
    } else {
        return NO;
    }
    
}

- (void)removeTap:(UITapGestureRecognizer *)sender {
    [self hideSelf];
}


#pragma mark - CollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    
    UILabel *showLabel = [[UILabel alloc] initWithFrame:cell.contentView.bounds];
    showLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    showLabel.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    showLabel.textColor = [UIColor colorWithHexString:@"#333336"];
    showLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightSemibold];
    showLabel.layer.cornerRadius = 3;
    showLabel.layer.masksToBounds = YES;
    showLabel.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:showLabel];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectBlock) {
        self.selectBlock(indexPath.row);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((SCREEN_WIGHT-30-24)/4.0, 36);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 8;
}



- (IBAction)removeAction:(UIButton *)sender {
    [self hideSelf];
}

- (void)hideSelf {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.contentView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIGHT, 320);
        
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
    
    
}

+ (void)showSelectThickViewWithDataSource:(NSArray *)dataArr selectBlock:(SelectThickBlock)selectBlock {
    
    SelectThickView *selectV = [[SelectThickView alloc] initWithFrame:MY_WINDOW.bounds dataArr:dataArr];
    selectV.selectBlock = selectBlock;
    selectV.contentView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIGHT, 320);
    
    [UIView animateWithDuration:0.3 animations:^{
        selectV.contentView.frame = CGRectMake(0, SCREEN_HEIGHT-320, SCREEN_WIGHT, 320);
    }];
    
    [MY_WINDOW addSubview:selectV];
}


@end
