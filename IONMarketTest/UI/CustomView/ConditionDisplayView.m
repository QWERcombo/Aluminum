//
//  ConditionDisplayView.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2019/2/14.
//  Copyright © 2019年 赵越. All rights reserved.
//

#import "ConditionDisplayView.h"
#import "ConditionDisplayCell.h"

@implementation ConditionDisplayView


- (instancetype)initWithFrame:(CGRect)frame parameter:(NSString *)parameter
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"ConditionDisplayView" owner:self options:nil] firstObject];
        [self.collectionView registerNib:[UINib nibWithNibName:@"ConditionDisplayCell" bundle:nil] forCellWithReuseIdentifier:@"ConditionDisplayCell"];
        self.collectionView.allowsMultipleSelection = NO;
        self.dataSource = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4", nil];
        self.parameter = parameter;
        
        self.frame = frame;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeTap:)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        [self.collectionView reloadData];
    }
    return self;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([touch.view isKindOfClass:[ConditionDisplayView class]]) {
        return YES;
    } else {
        return NO;
    }
    
}

- (void)removeTap:(UITapGestureRecognizer *)sender {
    if (self.selectedBlock) {
        self.selectedBlock(@"-1", YES);
        [self hideSelf];
    }
}

- (void)hideSelf {
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.contentView.frame = CGRectMake(0, -320, SCREEN_WIGHT, 320);
        
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
    
}

+ (void)showConditionDisplayViewWithTitle:(NSString *)title parameter:(NSString *)parameter selectTitle:(NSString *)title selectedBlock:(SselectedIndexPath)selectedBlock {
    
    UIViewController *rootVC = [UIViewController currentViewController];
    
    ConditionDisplayView *displayV = [[ConditionDisplayView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIGHT, rootVC.view.bounds.size.height-40) parameter:parameter];
    displayV.selectedBlock = selectedBlock;
    displayV.selectTitle = title;
    displayV.hintLabel.text = [NSString stringWithFormat:@"请选择%@", title];
    displayV.contentView.frame = CGRectMake(0, -320, SCREEN_WIGHT, 320);
    
    [UIView animateWithDuration:0.3 animations:^{
        displayV.contentView.frame = CGRectMake(0, 0, SCREEN_WIGHT, 320);
        
    }];
    
    [rootVC.view addSubview:displayV];
    
}

+ (void)hideConditionDisplayView {
    
    for (UIView *subView in [UIViewController currentViewController].view.subviews) {
        
        if ([subView isKindOfClass:[ConditionDisplayView class]]) {
            
            ConditionDisplayView *display = (ConditionDisplayView *)subView;
            [display hideSelf];
        }
        
    }
}

#pragma mark - CollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ConditionDisplayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ConditionDisplayCell" forIndexPath:indexPath];
    
    [cell setButtonTitle:[self.dataSource objectAtIndex:indexPath.row]];
    
    if (indexPath.row == [self.dataSource indexOfObject:self.selectTitle]) {
        [cell setSelected:YES];
    } else {
        [cell setSelected:NO];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    for (int i=0; i<self.dataSource.count; i++) {
        
        if (i == indexPath.item) {
            //选中
            [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:indexPath.section] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
            
            if (self.selectedBlock) {
                
                self.selectedBlock([self.dataSource objectAtIndex:indexPath.row], YES);
                
            }

        }else {
            //未选中
            [self.collectionView deselectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:indexPath.section] animated:YES];
        }
        
        
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



- (IBAction)all:(UIButton *)sender {
    
    
}



@end
