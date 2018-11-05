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

- (instancetype)initWithFrame:(CGRect)frame erjimulu:(NSString *)erjimulu_id
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"SelectThickView" owner:self options:nil] firstObject];
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewCell"];
        self.dataSource = [NSMutableArray array];
        [self getListDataWith:erjimulu_id];
        self.isSelectLeft = YES;
        
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

- (void)getListDataWith:(NSString *)erjimulu {
    
    NSMutableDictionary *parDic = [NSMutableDictionary dictionary];
    [parDic setObject:erjimulu forKey:@"xinghao"];
    switch (self.selectShowType) {
        case SelectShowType_LingQie:
            [parDic setObject:@"零切" forKey:@"zhonglei"];
            break;
        case SelectShowType_YuanBang:
            [parDic setObject:@"圆棒" forKey:@"zhonglei"];
            break;
        case SelectShowType_XingCai:
            [parDic setObject:@"型材" forKey:@"zhonglei"];
            break;
        case SelectShowType_GuanCai:
            [parDic setObject:@"管材" forKey:@"zhonglei"];
            break;
            
        default:
            break;
    }
    
    [DataSend sendPostWastedRequestWithBaseURL:BASE_URL valueDictionary:parDic imageArray:nil WithType:Interface_GetByZhongleiAndXinghao andCookie:nil showAnimation:YES success:^(NSDictionary *resultDic, NSString *msg) {
        
        NSArray *dataArr = [resultDic objectForKey:@"houdus"];
        [self.dataSource addObjectsFromArray:dataArr];
        
        [self.collectionView reloadData];
    } failure:^(NSString *error, NSInteger code) {
        
    }];
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
        
        switch (self.selectShowType) {
            case SelectShowType_LingQie:
                [self hideSelf];
                self.selectBlock([self.dataSource objectAtIndex:indexPath.row]);
                break;
            case SelectShowType_YuanBang:
                [self hideSelf];
                self.selectBlock([self.dataSource objectAtIndex:indexPath.row]);
                break;
            case SelectShowType_XingCai:
                
                if (self.isSelectLeft) {
                    self.left_label.text = [self.dataSource objectAtIndex:indexPath.row];
                    self.leftIndex = indexPath.row;
                } else {
                    self.right_label.text = [self.dataSource objectAtIndex:indexPath.row];
                    self.rightIndex = indexPath.row;
                }
                
                if (self.left_label.text.length && self.right_label.text.length) {
                    [self hideSelf];
                    self.selectBlock([NSString stringWithFormat:@"%ld-%ld", self.leftIndex, self.rightIndex]);
                }
                break;
            case SelectShowType_GuanCai:
                
                if (self.isSelectLeft) {
                    self.left_label.text = [self.dataSource objectAtIndex:indexPath.row];
                    self.leftIndex = indexPath.row;
                } else {
                    self.right_label.text = [self.dataSource objectAtIndex:indexPath.row];
                    self.rightIndex = indexPath.row;
                }
                
                if (self.left_label.text.length && self.right_label.text.length) {
                    [self hideSelf];
                    self.selectBlock([NSString stringWithFormat:@"%ld-%ld", self.leftIndex, self.rightIndex]);
                }
                break;
            default:
                break;
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

- (IBAction)leftSelect:(UIButton *)sender {
    _isSelectLeft = YES;
    [sender setTitleColor:[UIColor Black_WordColor] forState:UIControlStateNormal];
    [self.right_btn setTitleColor:[UIColor colorWithHexString:@"#CED4DA"] forState:UIControlStateNormal];
}

- (IBAction)rightSelect:(UIButton *)sender {
    _isSelectLeft = NO;
    [sender setTitleColor:[UIColor Black_WordColor] forState:UIControlStateNormal];
    [self.left_btn setTitleColor:[UIColor colorWithHexString:@"#CED4DA"] forState:UIControlStateNormal];
}


+ (void)showSelectThickViewWithSelectShowType:(SelectShowType)selectType erjimulu_id:(NSString *)erjimulu_id selectBlock:(SelectThickBlock)selectBlock {
    
    SelectThickView *selectV = [[SelectThickView alloc] initWithFrame:MY_WINDOW.bounds erjimulu:erjimulu_id];
    selectV.selectBlock = selectBlock;
    selectV.selectShowType = selectType;
    selectV.contentView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIGHT, 320);
    
    switch (selectV.selectShowType) {
        case SelectShowType_LingQie:
            selectV.infoView.hidden = YES;
            selectV.infoHeight.constant = 0;
            selectV.hintLabel.text = @"选择厚度";
            
            break;
        case SelectShowType_YuanBang:
            selectV.infoView.hidden = YES;
            selectV.infoHeight.constant = 0;
            selectV.hintLabel.text = @"选择直径";
            
            break;
        case SelectShowType_XingCai:
            selectV.infoView.hidden = NO;
            selectV.infoHeight.constant = 30;
            selectV.hintLabel.text = @"选择规格";
            [selectV.left_btn setTitle:@"侧面长" forState:UIControlStateNormal];
            [selectV.right_btn setTitle:@"侧面宽" forState:UIControlStateNormal];
            
            break;
        case SelectShowType_GuanCai:
            selectV.infoView.hidden = NO;
            selectV.infoHeight.constant = 30;
            selectV.hintLabel.text = @"选择规格";
            [selectV.left_btn setTitle:@"外径" forState:UIControlStateNormal];
            [selectV.right_btn setTitle:@"内径" forState:UIControlStateNormal];
            
            break;
        default:
            break;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        selectV.contentView.frame = CGRectMake(0, SCREEN_HEIGHT-320, SCREEN_WIGHT, 320);
    }];
    
    [MY_WINDOW addSubview:selectV];
}


@end
