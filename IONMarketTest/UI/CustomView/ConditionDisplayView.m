//
//  ConditionDisplayView.m
//  IONMarketTest
//
//  Created by 瓜豆2018 on 2019/2/14.
//  Copyright © 2019年 赵越. All rights reserved.
//

#import "ConditionDisplayView.h"
#import "ConditionDisplayCell.h"
#import "ConditionDisplaySectionView.h"
#import "PinLeiModel.h"

@implementation ConditionDisplayView


- (instancetype)initWithFrame:(CGRect)frame parameter:(NSString *)parameter
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"ConditionDisplayView" owner:self options:nil] firstObject];
        [self.collectionView registerNib:[UINib nibWithNibName:@"ConditionDisplayCell" bundle:nil] forCellWithReuseIdentifier:@"ConditionDisplayCell"];
        [self.collectionView registerNib:[UINib nibWithNibName:@"ConditionDisplaySectionView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ConditionSectionView"];
        self.collectionView.allowsMultipleSelection = NO;
        self.dataSource = [NSMutableArray array];
        self.parameter = parameter;
        
        self.frame = frame;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeTap:)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        [self getBaseDataWithTitle:parameter];
        
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

- (void)getBaseDataWithTitle:(NSString *)title {
    
    [self.dataSource removeAllObjects];
    
    if ([title isEqualToString:@"品类"]) {
        
        [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:nil imageArray:nil WithType:Interface_PinLei andCookie:nil showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
            
            NSArray *listArray = resultDic[@"list"];
            NSMutableArray *array = [NSMutableArray array];
            
            for (NSDictionary *dic in listArray) {
                
                PinLeiModel *model = [[PinLeiModel alloc] initWithDictionary:dic error:nil];
                [array addObject:model];
            }
            [self.dataSource addObject:array];
            
            [self.collectionView reloadData];
            
        } failure:^(NSString *error, NSInteger code) {
            
        }];
        
        
    } else if ([title isEqualToString:@"牌号"]) {
        
        [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:nil imageArray:nil WithType:Interface_CateList andCookie:nil showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
            
            NSArray *listArray = resultDic[@"list"];
            NSMutableArray *array = [NSMutableArray array];
            
            for (NSDictionary *dic in listArray) {
                
                MainItemTypeModel *model = [[MainItemTypeModel alloc] initWithDictionary:dic error:nil];
                [array addObject:model];
            }
            [self.dataSource addObject:array];
            
            [self.collectionView reloadData];
            
        } failure:^(NSString *error, NSInteger code) {
            
        }];
        
        
    } else if ([title isEqualToString:@"状态"]) {
        
        [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:nil imageArray:nil WithType:Interface_ZhuangTai andCookie:nil showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
            
            NSArray *listArray = resultDic[@"list"];
            NSMutableArray *array = [NSMutableArray array];
            
            for (NSString *string in listArray) {
                
                [self.dataSource addObject:string];
            }
            [array addObject:array];
            
            [self.collectionView reloadData];
            
        } failure:^(NSString *error, NSInteger code) {
            
        }];
        
        
    } else if ([title isEqualToString:@"厚度"]) {
        
        [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:nil imageArray:nil WithType:Interface_HouDu andCookie:nil showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
            
            NSArray *listArray = resultDic[@"list"];
            NSMutableArray *array = [NSMutableArray array];
            
            for (NSString *string in listArray) {
                
                [array addObject:string];
            }
            [self.dataSource addObject:array];
            
            [self.collectionView reloadData];
            
        } failure:^(NSString *error, NSInteger code) {
            
        }];
        
        
    } else if ([title isEqualToString:@"更多"]) {
        
        
        
    }
    else {
        
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

+ (void)showConditionDisplayViewWithTitle:(NSString *)title parameter:(NSString *)parameter selectTitle:(NSString *)selectTitle selectedBlock:(SselectedIndexPath)selectedBlock {
    
    UIViewController *rootVC = [UIViewController currentViewController];
    
    ConditionDisplayView *displayV = [[ConditionDisplayView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIGHT, rootVC.view.bounds.size.height-40) parameter:title];
    displayV.selectedBlock = selectedBlock;
    displayV.showTitle = title;
    displayV.selectTitle = selectTitle;
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
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *listArray = [self.dataSource objectAtIndex:section];
    return listArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ConditionDisplayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ConditionDisplayCell" forIndexPath:indexPath];
    
    [cell setButtonTitle:self.showTitle selectTitle:self.selectTitle dataObject:self.dataSource[indexPath.section][indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *listArray = [self.dataSource objectAtIndex:indexPath.section];
    for (int i=0; i<listArray.count; i++) {
        
        if (i == indexPath.item) {
            //选中
            [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:indexPath.section] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
            
            if (self.selectedBlock) {
                
                self.selectedBlock(listArray[indexPath.row], YES);
                
            }

        }else {
            //未选中
            [self.collectionView deselectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:indexPath.section] animated:YES];
        }
        
    }
    
}

#pragma mark - Layout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((SCREEN_WIGHT-30-24)/4.0, 36);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 8;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    NSString * reuseIdentifier = @"ConditionSectionView";
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        ConditionDisplaySectionView *view =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader   withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        view.titleLabel.text = [NSString stringWithFormat:@"请选择%@", self.showTitle];
        
        return view;
        
    } else {
        
        return nil;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    return CGSizeMake(SCREEN_WIGHT, 50);
}


- (IBAction)all:(UIButton *)sender {
    //重置
    self.selectTitle = self.showTitle;
    [self.collectionView reloadData];
    if (self.selectedBlock) {
        self.selectedBlock(@"-2", YES);
    }
    
}



@end
