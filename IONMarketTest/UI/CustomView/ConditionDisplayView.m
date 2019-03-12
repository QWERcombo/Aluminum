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


- (instancetype)initWithFrame:(CGRect)frame parameter:(NSString *)parameter normalTitle:(NSString *)title selectTitle:(NSString *)selectTitle
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"ConditionDisplayView" owner:self options:nil] firstObject];
        [self.collectionView registerNib:[UINib nibWithNibName:@"ConditionDisplayCell" bundle:nil] forCellWithReuseIdentifier:@"ConditionDisplayCell"];
        [self.collectionView registerNib:[UINib nibWithNibName:@"ConditionDisplaySectionView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ConditionSectionView"];
        self.collectionView.allowsMultipleSelection = YES;
        self.dataSource = [NSMutableArray array];
        self.moreTitleArr = [NSMutableArray array];
        self.selectArray = [NSMutableArray array];
        
        self.showTitle = title;
        self.parameter = parameter;
        self.selectTitle = selectTitle;
        
        self.frame = frame;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeTap:)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];
        [self getBaseDataWithTitle:title type:parameter];
        
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

- (void)getBaseDataWithTitle:(NSString *)title type:(NSString *)type {
    
    [self.dataSource removeAllObjects];
    //type  1整板  2零切
    if ([title isEqualToString:@"品类"]) {
        
        [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:nil imageArray:nil WithType:Interface_PinLei andCookie:nil showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
            
            NSArray *listArray = resultDic[@"list"];
            NSMutableArray *array = [NSMutableArray array];
            
            for (NSString *string in listArray) {
                
                [array addObject:string];
            }
            [self.dataSource addObject:array];
            
            [self.collectionView reloadData];
            
        } failure:^(NSString *error, NSInteger code) {
            
        }];
        
        
    } else if ([title isEqualToString:@"牌号"]) {
        
        [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:nil imageArray:nil WithType:[type intValue]==1?Interface_CateList:Interface_LQPaihao andCookie:nil showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
            
            NSArray *listArray = resultDic[@"list"];
            NSMutableArray *array = [NSMutableArray array];
            
            if ([type intValue] == 1) {
                for (NSString *dic in listArray) {

                    [array addObject:dic];
                }
            } else {
                for (NSDictionary *dic in listArray) {
                    MainItemTypeModel *model = [[MainItemTypeModel alloc] initWithDictionary:dic error:nil];
                    [array addObject:model];
                }
            }
            
            [self.dataSource addObject:array];
            
            [self.collectionView reloadData];
            
        } failure:^(NSString *error, NSInteger code) {
            
        }];
        
        
    } else if ([title isEqualToString:@"状态"]) {
        
        [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:nil imageArray:nil WithType:[type intValue]==1?Interface_ZhuangTai:Interface_LQZhuangtai andCookie:nil showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
            
            NSArray *listArray = resultDic[@"list"];
            NSMutableArray *array = [NSMutableArray array];
            
            for (NSString *string in listArray) {
                
                [array addObject:string];
            }
            [self.dataSource addObject:array];
            
            [self.collectionView reloadData];
            
        } failure:^(NSString *error, NSInteger code) {
            
        }];
        
        
    } else if ([title isEqualToString:@"厚度"]) {
        
        [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:nil imageArray:nil WithType:[type intValue]==1?Interface_HouDu:Interface_LQHoudu andCookie:nil showAnimation:NO success:^(NSDictionary *resultDic, NSString *msg) {
            
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
        
        [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:nil imageArray:nil WithType:Interface_QiHuoMore andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
            
            NSArray *bianmianArr = resultDic[@"biaomiangongyiList"];
            NSArray *changjiaArr = resultDic[@"changjiaList"];
            NSArray *fumoArr = resultDic[@"fumoList"];
            
            if (bianmianArr.count) {
                [self.moreTitleArr addObject:@"表面工艺"];
                
                NSMutableArray *array = [NSMutableArray array];
                [array addObject:@"全部"];
                for (NSString *string in bianmianArr) {
                    if (![string isEqualToString:@"全部"]) {
                        [array addObject:string];
                    }
                }
                
                
                [self.selectArray addObject:@""];
                [self.dataSource addObject:array];
            }
            if (changjiaArr.count) {
                [self.moreTitleArr addObject:@"生产厂家"];
                
                NSMutableArray *array = [NSMutableArray array];
                [array addObject:@"全部"];
                for (NSString *string in changjiaArr) {
                    if (![string isEqualToString:@"全部"]) {
                        [array addObject:string];
                    }
                }
                
                
                [self.selectArray addObject:@""];
                [self.dataSource addObject:array];
            }
            if (fumoArr.count) {
                [self.moreTitleArr addObject:@"覆膜类型"];
                
                NSMutableArray *array = [NSMutableArray array];
                [array addObject:@"全部"];
                for (NSString *string in fumoArr) {
                    if (![string isEqualToString:@"全部"]) {
                        [array addObject:string];
                    }
                }
                
                
                [self.selectArray addObject:@""];
                [self.dataSource addObject:array];
            }

            if ([self.selectTitle containsString:@","]) {
                //选择过更多条件
                for (int i=0; i<self.selectArray.count; i++) {
                    [self.selectArray replaceObjectAtIndex:i withObject:[self.selectTitle componentsSeparatedByString:@","][i]];
                }
            }
            
            [self.collectionView reloadData];
        } failure:^(NSString *error, NSInteger code) {
            
        }];
        
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
    
    [self hideConditionDisplayView];
    
    UIViewController *rootVC = [UIViewController currentViewController];
    
    ConditionDisplayView *displayV = [[ConditionDisplayView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIGHT, rootVC.view.bounds.size.height-40) parameter:parameter normalTitle:title selectTitle:selectTitle];
    displayV.selectedBlock = selectedBlock;

    if ([title isEqualToString:@"更多"]) {
        displayV.contentView.frame = CGRectMake(0, -420, SCREEN_WIGHT, 420);
        displayV.contentHeight.constant = 420;
        displayV.btnWidth.constant = SCREEN_WIGHT/2;
        [displayV.allButton setTitle:@"确定" forState:UIControlStateNormal];
    } else {
        displayV.contentView.frame = CGRectMake(0, -320, SCREEN_WIGHT, 320);
        displayV.contentHeight.constant = 320;
        displayV.btnWidth.constant = 0.01;
        [displayV.allButton setTitle:@"重置/全部" forState:UIControlStateNormal];
    }
    
    
    [UIView animateWithDuration:0.3 animations:^{
        if ([title isEqualToString:@"更多"]) {
            displayV.contentView.frame = CGRectMake(0, 0, SCREEN_WIGHT, 400);
        } else {
            displayV.contentView.frame = CGRectMake(0, 0, SCREEN_WIGHT, 320);
        }
        
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
    
    [cell setButtonTitle:self.showTitle selectTitle:self.selectArray.count?[self.selectArray objectAtIndex:indexPath.section]:self.selectTitle dataObject:self.dataSource[indexPath.section][indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *listArray = [self.dataSource objectAtIndex:indexPath.section];
    
    for (int i=0; i<listArray.count; i++) {
        
        if (i == indexPath.item) {
            //选中
            [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:indexPath.section] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
            
            if (self.selectedBlock) {
                
                if (![self.showTitle isEqualToString:@"更多"]) {
                    
                    self.selectedBlock(listArray[indexPath.row], YES);
                } else {
                    
                    [self.selectArray replaceObjectAtIndex:indexPath.section withObject:listArray[indexPath.row]];
                }
                
            }

        }else {
            //未选中
            [self.collectionView deselectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:indexPath.section] animated:YES];
        }
        
    }
    [self.collectionView reloadData];
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
        
        if ([self.showTitle isEqualToString:@"更多"]) {
            view.titleLabel.text = [NSString stringWithFormat:@"%@", [self.moreTitleArr objectAtIndex:indexPath.section]];
        } else {
             view.titleLabel.text = [NSString stringWithFormat:@"请选择%@", self.showTitle];
        }
        
        
        return view;
        
    } else {
        
        return nil;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    return CGSizeMake(SCREEN_WIGHT, 50);
}


- (IBAction)all:(UIButton *)sender {
    
    if ([self.showTitle isEqualToString:@"更多"] && (sender.tag == 200)) {
        //更多是确定
        if (self.selectedBlock) {
            
            NSMutableString *showStr = [NSMutableString string];
            for (int i=0; i<self.selectArray.count; i++) {
                
                NSString *objectS = [self.selectArray objectAtIndex:i];
                if (objectS.length) {
                    [showStr appendString:objectS];
                }
                
                if (i != self.selectArray.count-1) {
                    [showStr appendString:@","];
                }
            }
            
            self.selectedBlock(showStr, YES);
            
        }
        return;
    }
    
    //重置
    self.selectTitle = self.showTitle;
    [self.collectionView reloadData];
    if (self.selectedBlock) {
        self.selectedBlock(@"-2", YES);
    }
    
}



@end
