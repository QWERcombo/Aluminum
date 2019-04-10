//
//  InterfaceDefines.h
//  IONMarketTest
//
//  Created by 赵越 on 2018/3/14.
//  Copyright © 2018年 赵越. All rights reserved.
//

#ifndef InterfaceDefines_h
#define InterfaceDefines_h

//《正式地址》
#define  BASE_URL         @"http://118.31.35.233:8080/leqie"
//《测试地址》
//#define  BASE_URL           @"http://118.31.35.233:8999/leqiev120"

//获取图片地址
//#define  BASE_URL_IMAGE_APP         @"http://118.31.35.233:8999/"
#define  BASE_URL_IMAGE_APP         @"http://118.31.35.233:8999/"

//#define  BASE_URL_IMAGE_Service     @"http://118.31.35.233:8999/leqiev120/"
#define  BASE_URL_IMAGE_Service     @"http://118.31.35.233:8080/leqie/"


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
#define Interface_SaveAddress       @"user/saveAddress"
//修改收货地址
#define Interface_UpdateAddress     @"user/updateAddress"
//获取收货地址
#define Interface_GetAddressByPhone  @"user/getAddressById"
//删除地址
#define Interface_DeleteAddress     @"user/deleteAddress"
//查询开票订单
#define Interface_OrderList         @"user/ordersList"
//加入购物车
#define Interface_SaveToGouwuche        @"user/saveToGouwuche"
//查询购物车
#define Interface_GetGouwucheByUser     @"user/getGouwucheByUser"
//直接购买 生成订单
#define Interface_OrderSave     @"user/ordersSave"
//查询订单列表
#define Interface_OrdersList    @"user/ordersList"
//从购物车生成订单
#define Interface_SaveFromGouwuche   @"user/saveFromGouwuche"
//获取物流费
#define Interface_GetWuliufei        @"user/getWuliufei"
//删除购物车
#define Interface_DeleteGouwuche        @"user/deleteGouwuche"



//获取个人发票信息
#define Interface_GetFapiaoByUser   @"user/getFapiaoByUser"
//申请开票
#define Interface_SaveKaipiao       @"user/saveKaipiao"
//查看开票记录
#define Interface_GetkaipiaoByUser   @"user/getkaipiaoByUser"

//保存发票信息
#define Interface_SaveFapiao        @"user/saveFapiao"
//修改发票信息
#define Interface_UpdateFapiao      @"user/updateFapiao"
//删除发票信息
#define Interface_DeleteFapiao      @"user/deleteFapiao"
//查看个人发票信息
#define Interface_GetFapiaoByUser   @"user/getFapiaoByUser"

//上传图片
#define Interface_UserUpload   @"user/upload"
//上传多张图片
#define Interface_MultiUpload   @"user/multiUpload"

//根据用户查询认证信息
#define Interface_GetRenzhengByUser   @"user/getRenzhengByUser"
//提交认证
#define Interface_SaveRenzheng      @"user/saveRenzheng"
//修改认证信息
#define Interface_UpdateRenzheng    @"user/updateRenzheng"

//获取短信验证码
#define Interface_SendMsg       @"sendMsg"
//注册
#define Interface_Register      @"register"
//忘记密码
#define Interface_Forget      @"user/forget"


//整板
#define Interface_ZhengbanList      @"zhengbanList"
//微信支付接口
#define Interface_WeixinPay         @"user/buyOrder"
//确认收货
#define Interface_ConfirmComplete   @"user/confirmComplete"
//取消订单
#define Interface_OrdersRemove   @"user/ordersRemove"

//查看用户的推广列表
#define Interface_MyInvite   @"user/myinvite"
//申请白条
#define Interface_SaveBaitiao   @"user/saveBaitiao"
//查看白条相关申请信息
#define Interface_GetBaitiaoById   @"user/getBaitiaoById"
//修改白条
#define Interface_UpdateBaitiao   @"user/updateBaitiao"
//申请通过，查看白条总额度和可用额度
#define Interface_GetBaitiaoEDuById   @"user/getBaitiaoEDuById"
//查看本月白条账单信息和白条花费总额
#define Interface_BaitiaoBillList   @"user/baitiaoBillList"
//白条还款微信支付
#define Interface_WxHuanKuan   @"user/wxHuanKuan"
//白条还款记录
#define Interface_BaitiaoHuanKuanList   @"user/baitiaoHuanKuanList"

//获取所有铝锭价列表
#define Interface_PriceList   @"priceList"
//分页获取铝锭价列表
#define Interface_PricePageList   @"pricePageList"

//管材接口时，根据内径获取外径
//#define Interface_GetWaijingByNeijing @"getWaijingByNeijing"
//管材接口时，根据外径获取内径
#define Interface_GetNeijingByWaijing @"getNeijingByWaijing"
//型材根据厚度选择宽度
#define Interface_GetKuanduByHoudu @"getKuanduByHoudu"
//型材根据宽度选择厚度
#define Interface_GetHouduByKuandu @"getHouduByKuandu"


//微信充值钱包
#define Interface_wxChongzhi   @"user/wxChongzhi"
//查看钱包充值列表
#define Interface_qianbaoChongZhiList   @"user/qianbaoChongZhiList"
//查看用户钱包余额
#define Interface_getQianBao   @"user/getQianBao"
//钱包消费记录
#define Interface_qianBaoBillList   @"user/qianBaoBillList"
//个人申请提现
#define Interface_withdrawSave   @"user/withdrawSave"
//个人钱包提现列表
#define Interface_withdrawList   @"user/withdrawList"

//修改用户信息
#define Interface_updateUser   @"user/updateUser"
//修改密码
#define Interface_changePassword   @"user/changePassword"
//图片下单
#define Interface_savePicOrder   @"user/savePicOrder"

//白条支付
#define Interface_baitiaoPay   @"user/baitiaoPay"
//钱包支付
#define Interface_qianbaoPay   @"user/qianbaoPay"
//订单详情
#define Interface_detailList   @"user/detailList"
//查询购物车数量和总额
#define Interface_countGouwucheByUser   @"user/countGouwucheByUser"

//支付宝支付
#define Interface_aliAppOrderPay   @"user/aliAppOrderPay"
//支付宝钱包充值
#define Interface_aliAppChongzhi   @"user/aliAppChongzhi"
//支付宝白条还款
#define Interface_aliAppHuanKuan   @"user/aliAppHuanKuan"

//根据订单编号获取材质证明
#define Interface_getInspectionReports   @"user/getInspectionReports"


#pragma mark --- V.1.1.0
//验证码登陆
#define Interface_loginByCode           @"loginByCode"
//绑定推荐人号码
#define Interface_updatePromotePhone    @"user/updatePromotePhone"
//判断是否含有密码
#define Interface_hasPassword           @"user/hasPassword"
//设置密码
#define Interface_setPassword           @"user/setPassword"
//设置支付密码
#define Interface_setPayPassword        @"user/setPayPassword"
//获取最新的铝锭价
#define Interface_getLastestPrice       @"getLastestPrice"
//保存特殊定制
#define Interface_saveSpOrder           @"user/saveSpOrder"
//修改购物车
#define Interface_updateGouwuche        @"user/updateGouwuche"
//批量加入购物车
#define Interface_batchSaveToGouwuche   @"user/batchSaveToGouwuche"
//获取版本信息
#define Interface_getVersionAndUrl      @"getVersionAndUrl"

#pragma mark --- V.1.1.3

#pragma mark --- V.1.2.0
//请选择品类:铝板，圆棒，管材，型材等
#define Interface_PinLei            @"pinleiList"
//请选择牌号
//#define Interface_Cate      @"cateList"
//请选择状态
#define Interface_ZhuangTai         @"zhuangtaiList"
//请选择厚度
#define Interface_HouDu             @"indexHouduList"
//按条件查询期货列表
#define Interface_QiHuo             @"showQiHuo"
//保存抢约包（期货）数据
#define Interface_QiHuoOrder        @"user/saveQiHuoOrder"
//获取半成品
#define Interface_Banchengpin       @"banchengpinList"
//获取期货更多条件
#define Interface_QiHuoMore         @"getQihuoSearchMore"
//微信授权成功 判断openid是否存在
#define Interface_RegisterByWX      @"registerByWX"
//微信登录，手机号码绑定
#define Interface_WxBindPhone       @"wxBindPhone"
//根据OpenId获取用户所有信息
#define Interface_GetByOpenId       @"user/getByOpenId"
//请选择零切牌号
#define Interface_LQPaihao          @"lingqiepaihaoList"
//零切状态
#define Interface_LQZhuangtai       @"lingqiezhuangtaiList"
//零切厚度
#define Interface_LQHoudu           @"lingqiehouduList"
//期货状态
#define Interface_QHZhuangtai       @"qihuozhuangtaiList"
//期货牌号
#define Interface_QHPaihao          @"qihuopaihaoList"
//期货厚度
#define Interface_QHHoudu           @"qihuohouduList"
//微信解绑
#define Interface_Unlinkwx          @"user/unlinkwx"





#endif /* InterfaceDefines_h */
