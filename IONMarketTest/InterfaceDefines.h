//
//  InterfaceDefines.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/14.
//  Copyright © 2018年 赵越. All rights reserved.
//

#ifndef InterfaceDefines_h
#define InterfaceDefines_h

//《 测试地址 》
#define  BASE_URL    @"http://118.31.35.233:8080/leqie"

//登陆
#define Interface_Login  @"login"
//获取品型
#define Interface_CateList  @"cateList"
//获取价格
#define Interface_OrderMoney @"user/getOrderMoney"
//获取品型的具体参数
#define Interface_FindDetail @"findDetailById"
//下单，根据种类和型号获取滚动字段
#define Interface_GetByZhongleiAndXinghao   @"user/getByZhongleiAndXinghao"
//下整只的时候，自动选择长度
#define Inuterface_GetLengthByOthers  @"user/getLengthByOthers"
//新建收货地址
#define Interface_SaveAddress   @"user/saveAddress"
//修改收货地址
#define Interface_UpdateAddress    @"user/updateAddress"
//获取收货地址
#define Interface_GetAddressByPhone  @"user/getAddressById"
//删除地址
#define Interface_DeleteAddress   @"user/deleteAddress"
//查询开票订单
#define Interface_OrderList    @"user/ordersList"
//加入购物车
#define Interface_SaveToGouwuche   @"user/saveToGouwuche"
//查询购物车
#define Interface_GetGouwucheByUser   @"user/getGouwucheByUser"
//直接购买 生成订单
#define Interface_OrderSave   @"user/ordersSave"
//查询订单列表
#define Interface_OrdersList   @"user/ordersList"
//从购物车生成订单
#define Interface_SaveFromGouwuche   @"user/saveFromGouwuche"
//获取物流费
#define Interface_GetWuliufei  @"user/getWuliufei"


//获取个人发票信息
#define Interface_GetFapiaoByUser  @"user/getFapiaoByUser"





#endif /* InterfaceDefines_h */
