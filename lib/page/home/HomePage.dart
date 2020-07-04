import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wobei/bean/Banner.dart';
import 'package:wobei/bean/BannerData.dart';
import 'package:wobei/common/OverScrollBehavior.dart';
import 'package:wobei/my_lib/Req.dart';
import 'package:wobei/my_lib/base/BaseState.dart';
import '../../my_lib/extension/BaseExtension.dart';

///*****************************************************************************
/// 主页
///*****************************************************************************
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return App();
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with BaseUtils, AutomaticKeepAliveClientMixin{
  List<BannerData> bannerList = [];

  @override
  void initState(){
    super.initState();
    showStatusBar();
    setStatusBarColor(true, Colors.transparent);
    Req.getBannerInfo().then((response){
      var banner = HbBanner.fromJson(response.data);
      setState(() {
        bannerList.addAll(banner.data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          ScrollConfiguration(
            behavior: OverScrollBehavior(),
            child: ListView(
              children: <Widget>[
//              SizedBox(height: 30,),
                SizedBox(
                  height: 18,
                ),
                getBanner().setPadding1(left: 20, right: 20), //轮播图
                SizedBox(
                  height: 20,
                ),
                getSubBar().setPadding1(left: 20, right: 20),
                SizedBox(
                  height: 20,
                ),
                getAreaList(),
              ],
            ),
          ),
          getTopBar().setColor(Colors.white).setPadding1(left: 20, right: 20), //顶部栏，包括搜索，定位
        ],
      ).setPadding1(top: 6 + getStatusBarHeight()),
    );
  }

  ///***************************************************************************
  /// 设置顶部栏
  ///***************************************************************************
  Widget getTopBar() {
    return Row(
      children: <Widget>[
        Image.asset(
          'assets/images/location_l.png',
          width: 12,
          height: 16,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          '杭州',
          style: TextStyle(
              color: '#393649'.color(),
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: 20,
        ),
        Container(
          height: 32,
          decoration: BoxDecoration(
              color: Color(0xFFF5F5F5),
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 16,
              ),
              Image.asset(
                'assets/images/search.png',
                width: 12,
                height: 12,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                '爱奇艺VIP月卡',
                style: TextStyle(color: '#A5A3AC'.color(), fontSize: 12),
              )
            ],
          ),
        ).setExpanded(1)
      ],
    ).setSize(double.infinity, 30);
  }

  ///****************************************************************************
  /// 设置轮播图
  ///****************************************************************************
  Widget getBanner() {
    return Swiper(
      key: UniqueKey(),
      itemBuilder: (BuildContext context, int index) {
        return Image.network(
          bannerList[index].url,
          fit: BoxFit.cover,
        );
      },
      itemCount: bannerList.length,
      pagination: SwiperCustomPagination(
          builder: (BuildContext context, SwiperPluginConfig config) {
        print(config.activeIndex); //当前显示的索引值
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              bottom: 7,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 20,
                    height: 2,
                    color: config.activeIndex == 0
                        ? Colors.white
                        : Color(0x4dffffff),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 20,
                    height: 2,
                    color: config.activeIndex == 1
                        ? Colors.white
                        : Color(0x4dffffff),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 20,
                    height: 2,
                    color: config.activeIndex == 2
                        ? Colors.white
                        : Color(0x4dffffff),
                  )
                ],
              ),
            )
          ],
        );
      }),
      control: null,
      loop: true,
      //是否循环
      autoplay: true,
      autoplayDelay: 3000,
    ).setClipRRect(4).setSizedBox(width: double.infinity, height: 167.5);
  }

  ///***************************************************************************
  /// 获取副标签栏 
  ///***************************************************************************
  Widget getSubBar() {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/mall.png", width: 54.5, height: 34, fit: BoxFit.contain,),
            Text('会员商城', style: TextStyle(fontSize: 12, color: "#ff393649".color()),),
          ],
        ),
        SizedBox(width: 1,).setExpanded(1),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/recharge.png", width: 54.5, height: 34, fit: BoxFit.contain,),
            Text('话费充值', style: TextStyle(fontSize: 12, color: "#ff393649".color()),),
          ],
        ),
        SizedBox(width: 1,).setExpanded(1),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/exclusive.png", width: 54.5, height: 34, fit: BoxFit.contain,),
            Text('禾卡专属', style: TextStyle(fontSize: 12, color: "#ff393649".color()),),
          ],
        ),
        SizedBox(width: 1,).setExpanded(1),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/mall.png", width: 54.5, height: 34, fit: BoxFit.contain,),
            Text('热门生鲜', style: TextStyle(fontSize: 12, color: "#ff393649".color()),),
          ],
        ),
      ],
    );
  }

  String getTestImgUrl(int index) {
    var imgUrl;
    switch(index){
      case 0:
        imgUrl = "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1211338343,1056512950&fm=26&gp=0.jpg";
        break;
      case 1:
        imgUrl = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1592479227896&di=fcf0311815dffc9738396298ae7c7ee3&imgtype=0&src=http%3A%2F%2Fbpic.588ku.com%2Fback_pic%2F05%2F16%2F08%2F1359b10f28667c2.jpg";
        break;
      case 2:
        imgUrl = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1592479227897&di=d1c35ab15275d2b39c510c005b706591&imgtype=0&src=http%3A%2F%2Fbpic.588ku.com%2Fback_pic%2F00%2F03%2F46%2F05561e73254317d.jpg";
        break;
    }
    return imgUrl;
  }

  ///***************************************************************************
  /// 获取专区列表
  ///***************************************************************************
  Widget getAreaList() {

    final testImgUrl = 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1592480228176&di=a320b93fd8d94b5fd816770007454ff8&imgtype=0&src=http%3A%2F%2Fwx1.sinaimg.cn%2Fcrop.85.0.640.360.1000%2F44c65225gy1flwshea7ytj20m80a0wfp.jpg';

    return ListView(
      shrinkWrap: true,//解决无限高度问题
      physics: NeverScrollableScrollPhysics(),//禁用滑动事件
      children: <Widget>[
        Row(
          children: <Widget>[
            Text('福利专区', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: "#ff393649".color()),),
            SizedBox(width: 1,).setExpanded(1),
            Text("进入专区", style: TextStyle(fontSize: 12, color: "#ffa5a3ac".color()),)
          ],
        ).setPadding1(left: 20, right: 20),
        SizedBox(height: 16,),
        ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 20,),
            Image.network(testImgUrl, width: (context.getSrnW()-52)/2, height: 121, fit: BoxFit.cover,).setClipRRect(4.0),
            SizedBox(width: 12,),
            Image.network(testImgUrl, width: (context.getSrnW()-52)/2, height: 121, fit: BoxFit.cover,).setClipRRect(4.0),
            SizedBox(width: 12,),
            Image.network(testImgUrl, width: (context.getSrnW()-52)/2, height: 121, fit: BoxFit.cover,).setClipRRect(4.0),
            SizedBox(width: 12,),
            Image.network(testImgUrl, width: (context.getSrnW()-52)/2, height: 121, fit: BoxFit.cover,).setClipRRect(4.0),
            SizedBox(width: 12,),
            Image.network(testImgUrl, width: (context.getSrnW()-52)/2, height: 121, fit: BoxFit.cover,).setClipRRect(4.0),
            SizedBox(width: 12,),
          ],
        ).setSizedBox(width: double.infinity, height: 121),

        SizedBox(height: 20,),
        Row(
          children: <Widget>[
            Text('福利专区', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: "#ff393649".color()),),
            SizedBox(width: 1,).setExpanded(1),
            Text("进入专区", style: TextStyle(fontSize: 12, color: "#ffa5a3ac".color()),)
          ],
        ).setPadding1(left: 20, right: 20),
        SizedBox(height: 16,),
        ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 20,),
            Image.network(testImgUrl, width: (context.getSrnW()-52)/2, height: 121, fit: BoxFit.cover,).setClipRRect(4.0),
            SizedBox(width: 12,),
            Image.network(testImgUrl, width: (context.getSrnW()-52)/2, height: 121, fit: BoxFit.cover,).setClipRRect(4.0),
            SizedBox(width: 12,),
            Image.network(testImgUrl, width: (context.getSrnW()-52)/2, height: 121, fit: BoxFit.cover,).setClipRRect(4.0),
            SizedBox(width: 12,),
            Image.network(testImgUrl, width: (context.getSrnW()-52)/2, height: 121, fit: BoxFit.cover,).setClipRRect(4.0),
            SizedBox(width: 12,),
            Image.network(testImgUrl, width: (context.getSrnW()-52)/2, height: 121, fit: BoxFit.cover,).setClipRRect(4.0),
            SizedBox(width: 12,),
          ],
        ).setSizedBox(width: double.infinity, height: 121),

        SizedBox(height: 20,),
        Row(
          children: <Widget>[
            Text('福利专区', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: "#ff393649".color()),),
            SizedBox(width: 1,).setExpanded(1),
            Text("进入专区", style: TextStyle(fontSize: 12, color: "#ffa5a3ac".color()),)
          ],
        ).setPadding1(left: 20, right: 20),
        SizedBox(height: 16,),
        ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            SizedBox(width: 20,),
            Image.network(testImgUrl, width: (context.getSrnW()-52)/2, height: 121, fit: BoxFit.cover,).setClipRRect(4.0),
            SizedBox(width: 12,),
            Image.network(testImgUrl, width: (context.getSrnW()-52)/2, height: 121, fit: BoxFit.cover,).setClipRRect(4.0),
            SizedBox(width: 12,),
            Image.network(testImgUrl, width: (context.getSrnW()-52)/2, height: 121, fit: BoxFit.cover,).setClipRRect(4.0),
            SizedBox(width: 12,),
            Image.network(testImgUrl, width: (context.getSrnW()-52)/2, height: 121, fit: BoxFit.cover,).setClipRRect(4.0),
            SizedBox(width: 12,),
            Image.network(testImgUrl, width: (context.getSrnW()-52)/2, height: 121, fit: BoxFit.cover,).setClipRRect(4.0),
            SizedBox(width: 12,),
          ],
        ).setSizedBox(width: double.infinity, height: 121),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
