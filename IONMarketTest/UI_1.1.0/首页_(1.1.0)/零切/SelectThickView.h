//
//  SelectThickView.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/10/23.
//  Copyright © 2018 赵越. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectThickBlock)(NSString *selectIndexString);

//型号类型
typedef NS_ENUM(NSUInteger, SelectShowType) {
    SelectShowType_LingQie,     //零切
    SelectShowType_YuanBang,    //圆棒
    SelectShowType_GuanCai,     //管材
    SelectShowType_XingCai,     //型材
};

//获取信息类型
typedef NS_ENUM(NSUInteger, GetInfoType) {
    GetInfoType_Length,     //获取长度
    GetInfoType_GuiGe,      //获取规格
};


@interface SelectThickView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoHeight;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIButton *left_btn;
@property (weak, nonatomic) IBOutlet UILabel *left_label;
@property (weak, nonatomic) IBOutlet UIButton *right_btn;
@property (weak, nonatomic) IBOutlet UILabel *right_label;

@property (nonatomic, strong) NSMutableArray *dataSource;//默认数据
@property (nonatomic, strong) NSMutableArray *leftdataSource;//两组默认左边
@property (nonatomic, strong) NSMutableArray *rightdataSource;//两组默认右边

@property (nonatomic, copy) SelectThickBlock selectBlock;

@property (nonatomic, assign) GetInfoType getInfoType;
@property (nonatomic, assign) SelectShowType selectShowType;

@property (nonatomic, assign) BOOL isSelectLeft;//默认选中左边YES
@property (nonatomic, copy) NSString *leftIndex;//选中的左索引
@property (nonatomic, copy) NSString *rightIndex;//选中的右索引
@property (nonatomic, copy) NSDictionary *parDic;//选整只时选择长度传的参数
@property (nonatomic, copy) NSString *erjimulu_id;//传入的型号
@property (nonatomic, copy) NSString *zhuangtai;//传入的状态
@property (nonatomic, assign) BOOL isRequest;//


+ (void)showSelectThickViewWithSelectShowType:(SelectShowType)selectType getInfoType:(GetInfoType)getInfoType erjimulu_id:(NSString *)erjimulu_id zhuangTai:(NSString *)zhuangTai parDic:(NSDictionary *)parDic selectBlock:(SelectThickBlock)selectBlock;

@end

NS_ASSUME_NONNULL_END
