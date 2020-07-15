///管理所有接口
class URL {
  static const String BASE_URL =  "https://api.hbei.vip"; //正式
//  static const String BASE_URL =  "http://106.12.176.120"; //开发
//  static const String BASE_URL = "https://test-api.hbei.vip"; //测试

  static const String MODIFY_DATA = "/account/app/user/mine/edit"; //我的-修改资料
  static const String LOOKUP_DATA = "/account/app/user/mine/select"; //我的-查询资料
  static const String UPDATE_VERSION = "/iceberg/app/version/check"; //版本更新
  /// 登录
  static const String FORGET_PASSWORD =
      "/account/app/user/login/editPassword"; //忘记密码W
  static const String VERIFY_PIC =
      "/account/app/user/login/getVerifyPicture"; //获取验证码图片
  static const String REGISTER =
      "/account/app/user/login/register"; //用户注册登录 (返回-1则为新用户，跳转设置密码页面)
  static const String SEND_MESSAGE =
      "/account/app/user/login/sendMessage"; //发送验证码 返回-1的时候为非第一次登录vvv
  static const String SET_PASSWORD =
      "/account/app/user/login/setPassword"; //设置密码

  /// 卡券福利
  static const String KA_QUAN_DIALOG =
      "/iceberg/app/welfare/getUserWelfare"; //卡券弹窗
  static const String MY_RED_PACKET =
      "/iceberg/app/welfare/myRedPacket"; //我的红包；全部/历史
  static const String RECEIVE_KA_QUAN =
      "/iceberg/app/welfare/receiveWelfare"; //领取
  /// 开通会员-购买页
  static const String PURCHASE_PAGE = "/iceberg/app/buyPage/page"; //购买页展示

  /// 搜索页
  static const String GET_SEARCH_WORDS =
      "/iceberg/app/search/getSearchWord"; //获取搜索建议词、推荐词
  static const String SEARCH = "/iceberg/app/search/search"; //搜索

  /// 权益分类
  static const String RIGHT_CLASS_LIST =
      "/iceberg/app/itemGroup/getGroupList"; //展示页

  /// 零钱兑换卡
  static const String LING_QIAN_DUI_HUAN =
      "/iceberg/app/changeCard/exchange"; //兑换
  static const String LING_QIAN_CARD_LIST =
      "/iceberg/app/changeCard/getCards"; //零钱兑换卡列表

  /// 首页轮播图
  static const String LUN_BO_TU = "/iceberg/advertise/app/select";

  /// 权益管理
  static const String RIGHT_DETAIL = "/iceberg/item/app/detail"; //权益详情
  static const String FEN_YE_QUERY = "/iceberg/item/app/page"; //分页查询

  /// 权益订单管理
  static const String CANCEL_DUI_HUAN = "/iceberg/order/app/cancel"; //取消兑换小单
  static const String DUI_HUAN = "/iceberg/order/app/create"; //兑换下单
  static const String DING_DAN_DETAIL = "/iceberg/order/app/detail"; //订单详情
  static const String FEN_YE_LIST = "/iceberg/order/app/page"; //分页列表(我的卡券)
  static const String RIGHT_PAY_INFO = "/iceberg/order/app/pay/info"; //权益订单支付信息
  static const String ZH_PAY = "/iceberg/order/app/pay/cmb/param"; //招行支付参数获取
  static const String HB_PAY = "/iceberg/order/app/pay/score"; //禾贝支付
  static const String WX_PAY = "/iceberg/order/app/pay/wx/param"; //微信支付参数

  /// 会员卡订单管理
  static const String CANCEL_BUY_VIP =
      "/iceberg/order/app/vipCard/cancel"; //取消下单
  static const String BUY_VIP = "/iceberg/order/app/vipCard/create"; //下单
  static const String VIP_PAY_INFO =
      "/iceberg/order/app/vipCard/pay/info"; //会员卡支付信息
  static const String ZH_PAY_VIP =
      "/iceberg/order/app/vipCard/pay/cmb/param"; //招行支付参数获取
  static const String HB_PAY_VIP =
      "/iceberg/order/app/vipCard/pay/score"; //禾贝支付
  static const String WX_PAY_VIP =
      "/iceberg/order/app/vipCard/pay/wx/param"; //微信支付参数获取

  //认证------------------------------------------------
  static const String CERTIFICATION = "/account/cert/v1"; //实名认证
  static const String SET_PAY_PASSWORD = "/account/cert/password/set"; //设置支付密码
  static const String IS_CERTIFICATION = "/account/cert/info"; //查看用户认证状态和支付密码状态
  static const String VALIDATE_PASSWORD =
      "/account/cert/password/validate"; //校验支付密码

  //禾贝账号---------------------------------------------
  static const String HEBEI_FLOWWATER = "/bank/account/score/flow/page"; //禾贝流水
  static const String HEBEI_BALANCE = "/bank/account/score/total"; //禾贝余额

  //钱包------------------------------------------------
  static const String PACKET_DETAIL = "/bank/account/money/detail"; //钱包流水详情
  static const String PACKET_FLOW_WATER =
      "/bank/account/money/flow/page"; //钱包流水
  static const String PACKET_BALANCE = "/bank/account/money/total"; //钱包余额

  //特权------------------------------------------------
  static const String PRIVILEGE_INDUCE_BUY =
      "/iceberg/app/throne/buyPage"; //会员诱导购买页
  static const String BUY_PRIVILEGE_ONCE =
      "/iceberg/app/throne/buyThrone"; //立即购买特权
  static const String CreateThroneOrder =
      "/iceberg/app/throne/createThroneOrder"; //特权购买下单
  static const String exchange = "/iceberg/app/throne/exchange"; //兑换权益卡券
  static const String getThroneOrderDetail =
      "/iceberg/app/throne/getThroneOrderDetail"; //订单详情
  static const String getTopButton =
      "/iceberg/app/throne/getTopButton"; //获取topButton
  static const String getMyThroneCombo =
      "/iceberg/app/throne/mine/getMyThroneCombo"; //我的：我的兑换券
  static const String getThroneList =
      "/iceberg/app/throne/mine/getThroneList"; //我的：去使用->对应特权列表
  static const String page = "/iceberg/app/throne/page"; //特权分页
  static const String throneCancel = "/iceberg/app/throne/throneCancel"; //订单取消

  //券码兑换---------------
  static const String QUANMA_DUIHUAN = "/iceberg/ticket/app/coupon/exchange";

  //会员生活支付--------------------------------------
  static const String HB_PAY_VIP_LIFE = "/iceberg/app/throne/pay/score"; //禾贝支付
  static const String WX_PAY_VIP_LIFE = "/iceberg/app/throne/pay/wx"; //微信支付
  static const String ZH_PAY_VIP_LIFE = "/iceberg/app/throne/pay/cmd"; //招行支付
  static const String CANCEL_PAY_VIP_LIFE =
      "/iceberg/app/throne/throneCancel"; //终止支付

  //话费充值
  static const String CALL_RECHARGE_TAB =
      "/iceberg/phoneBill/app/tab"; //查看话费充值选项卡
  static const String RECHARGE_TIP = "/iceberg/phoneBill/app/tip"; //话费充值提示
  static const String CLOSE_THE_TOP_UP =
      "/iceberg/app/phoneBill/order/cancel"; //关闭充值
  static const String CREATE_ORDER =
      "/iceberg/app/phoneBill/order/create"; //创建订单
  static const String PAY_INFO_CHARGE =
      "/iceberg/app/phoneBill/order/pay/info"; //支付信息
  static const String ZH_PAY_CHARGE =
      "/iceberg/app/phoneBill/order/pay/cmb"; //招行支付话费
  static const String HB_PAY_CHARGE =
      "/iceberg/app/phoneBill/order/pay/score"; //禾贝支付话费
  static const String WX_PAY_CHARGE =
      "/iceberg/app/phoneBill/order/pay/wx"; //微信支付话费
  static const String RECHARGE_RECORD =
      "/iceberg/app/phoneBill/order/statistics"; //充值记录

  //微信分享图片
  static const String WX_SHARE_PIC = "/iceberg/app/wxShared/wxacode";

  //禾卡专属
  static const String HE_KA_EXCLUSIVE = "/iceberg/item/app";

  //消息中心
  static const String MESSAGE_CENTER = "/iceberg/app/push/getPushMessage";
  static const String SET_HAVE_READ = "/iceberg/app/push/readMessage"; //设置消息为已读
  static const String CLICK_ADD_ONE = "/iceberg/app/push/addPointNum"; //点击数+1

  static const String TE_QUAN_BAO_MIAO_SHU =
      "/iceberg/app/throne/getThroneDesc"; //特权包描述

  static const String QI_YE_ZHUAN_QU_SHOU_YE =
      "/iceberg/enterprise/app/customer/index"; //企业专区首页

  static const String FEN_YE_CHA_KAN_GE_GE_BIAO_QIAN_XIA_DE_QUAN_YI =
      "/iceberg/enterprise/app/customer/item/label/page"; //分页查看各个标签下的权益

  static const String CHA_KAN_WO_DE_QI_YE_XIN_XI =
      "/iceberg/enterprise/app/customer/mine"; //查看我的企业信息

  static const String GUANG_GAO_YE_HUO_QU_TU_PIAN_DI_ZHI =
      "/iceberg/advertise/app/getAdvertPage"; //广告页获取图片地址

  static const String GUANG_GAO_YE_ZENG_JIA_DIAN_JI_SHU =
      "/iceberg/advertise/app/addPointNum"; //广告页增加点击数

  static const String SHOU_YE_BIAO_QIAN = "/iceberg/home/app/homeLabel"; //首页标签

  static const String SHOU_YE_BIAO_QIAN_FEN_YE =
      "/iceberg/home/app/homeLabel/page"; //首页标签分页

  static const String SHANG_HU_QI_XIA_DE_DUO_MEN_DIAN =
      "/iceberg/enterprise/merchant/app/store/byItemBind"; //商户旗下的多门店

  static const String CHENG_SHI_SOU_SUO =
      "/iceberg/home/app/cityProvince/search"; //城市搜索

  static const String DENG_LU_ZHUANG_TAI =
      "/account/app/user/mine/handleCustomerStaff"; //登录状态调用：定制客户处理

  /// Version 1.4
  static const String SHANG_PIN_LEI_MU =
      "/iceberg/app/goods/category/all"; //商品类目

  static const String SHANG_PIN_XIANG_QING = "/iceberg/app/goods/detail"; //商品详情

  static const String SHANG_PIN_FEN_YE = "/iceberg/app/goods/page"; //商品分页

  static const String TIAN_JIA_SHOU_HUO_DI_ZHI =
      "/iceberg/goods/order/app/add/address"; //添加收货地址

  static const String QU_XIAO_ZHI_FU =
      "/iceberg/goods/order/app/goodsOrder/cancel"; //取消支付

  static const String XIA_DAN = "/iceberg/goods/order/app/getOrderDetail"; //下单

  static const String DAI_ZHI_FU_DING_DAN_XIANG_QING =
      "/iceberg/goods/order/app/getOrderDetail"; //待支付订单详情

  static const String WO_DE_DING_DAN =
      "/iceberg/goods/order/app/myOrder/page"; //我的订单

  static const String DING_DAN_XIANG_QING =
      "/iceberg/goods/order/app/order/detail"; //订单详情

  static const String ADD_ORDER_NOTE =
      "/iceberg/goods/order/app/add/remarks"; //添加订单备注

  static const String QUE_REN_ZHI_FU_ZHAO_XING =
      "/iceberg/goods/order/app/pay/cmd"; //确认支付招行

  static const String QUE_REN_ZHI_FU_ZHI_FU_BAO =
      "/iceberg/goods/order/app/pay/ali"; //确认支付支付宝

  static const String QUE_REN_ZHI_FU_HE_BEI =
      "/iceberg/goods/order/app/pay/score"; //确认支付禾贝

  static const String QUE_REN_ZHI_FU_WEI_XIN =
      "/iceberg/goods/order/app/pay/wx"; //确认支付微信

  static const String ALI_PAY_RIGHT = "/iceberg/order/app/pay/ali"; //支付宝-权益支付
  static const String ALI_PAY_RECHARGE =
      "/iceberg/app/phoneBill/order/pay/ali"; //支付宝-话费充值
  static const String ALI_PAY_VIP_LIFE =
      "/iceberg/app/throne/pay/ali"; //支付宝-会员生活
  static const String ALI_PAY_BUY_VIP =
      "/iceberg/order/app/vipCard/pay/ali"; //支付宝-会员充值
  static const String Sheng_Cheng_Ding_Dan_He_Bei =
      "/iceberg/goods/order/app/createOrder/score"; //生成订单禾贝

  static const String GET_LIMIT_CITY =
      "/iceberg/goods/order/app/getLimitArea"; //获取发货受限区域

  static const String HOME_ICON = "/iceberg/home/app/icon"; //首页icon列表

  static const String HOME_LABEL = "/iceberg/home/app/homeLabel"; //首页标签列表

  static const String HOT_CITIES = "/iceberg/home/app/getHotCities"; //获取热门城市

  static const String TUI_KUAN = "/iceberg/goods/order/app/refund";

  static const String UPLOAD_AVATAR = '/cargo/image/upload';
}
