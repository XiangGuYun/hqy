import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frame_animate_widget/frame_animate_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wobei/constant/Config.dart';

///该例演示了如何使用PullToRefresh插件实现列表的下拉刷新和上拉加载
class PullToRefreshPage extends StatefulWidget {
  @override
  _PullToRefreshPageState createState() => _PullToRefreshPageState();
}

class _PullToRefreshPageState extends State<PullToRefreshPage> {
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<String> frameList;
  final GlobalKey<FrameAnimationImageState> _key =
      GlobalKey<FrameAnimationImageState>();

  @override
  void initState() {
    super.initState();
    frameList = [
      Config.S_01,
      Config.S_02,
      Config.S_03,
      Config.S_04,
      Config.S_05,
      Config.S_06,
      Config.S_07,
      Config.S_08,
      Config.S_09,
      Config.S_10,
      Config.S_11,
      Config.S_12,
      Config.S_13,
      Config.S_14,
      Config.S_15,
      Config.S_16,
      Config.S_17,
      Config.S_18,
      Config.S_19,
      Config.S_20,
      Config.S_21,
      Config.S_22,
      Config.S_23,
      Config.S_24,
      Config.S_25,
      Config.S_26,
      Config.S_27,
      Config.S_28,
      Config.S_29,
      Config.S_30,
      Config.S_31,
      Config.S_32,
      Config.S_33,
      Config.S_34,
      Config.S_35,
      Config.S_36,
    ];
  }

  ///下拉刷新
  void _onRefresh() async {
    //模拟网络请求
    await Future.delayed(Duration(milliseconds: 1000));
    //结束下拉
    _refreshController.refreshCompleted();
  }

  ///上拉加载
  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    items.add((items.length + 1).toString());
    if (mounted) {
      setState(() {});
    }
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        //启用下拉刷新
        enablePullUp: true,
        //启动上拉加载
        header:
            CustomHeader(builder: (BuildContext context, RefreshStatus mode) {
          return Container(
            height: 50,
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 100,
                  right: 100,
                  bottom: 0,
                  child: FrameAnimationImage(
                    _key,
                    frameList,
                    width: 200,
                    height: 30,
                    interval: 20,
                    start: true,
                  ),
                )
              ],
            ),
          );
        }),
        //WaterDropHeader(),
        //设置头部视图
        footer: CustomFooter(
          //设置底部视图
          builder: (BuildContext ctx, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text('上拉加载');
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text('加载失败，点击重试！');
            } else if (mode == LoadStatus.canLoading) {
              body = Text('松手加载更多');
            } else {
              body = Text('没有更多数据了');
            }
            return Container(
              height: 50,
              child: Center(
                child: body,
              ),
            );
          },
        ),
        controller: _refreshController,
        //设置控制器
        onRefresh: _onRefresh,
        //设置刷新方法
        onLoading: _onLoading,
        //设置加载方法
        child: ListView.builder(
          //设置列表
          itemCount: items.length,
          itemExtent: 100,
          itemBuilder: (c, i) => Card(
            child: Center(
              child: Text(items[i]),
            ),
          ),
        ),
      ),
    );
  }
}
