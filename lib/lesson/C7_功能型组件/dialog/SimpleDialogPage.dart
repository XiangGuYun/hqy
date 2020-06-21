import 'package:flutter/material.dart';
import 'package:wobei/page/dialog/%E4%BC%9A%E5%91%98%E4%BA%AB%E4%BC%98%E6%83%A0.dart';

class SimpleDialogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('SimpleDialogPage'),
          onPressed: () {
//            changeLanguage(context);
            showDialog(
                context: context,
                builder: (context) {
                  return HuiYuanXiangYouHuiDialog(
                    "6.66",
                    leftBtnClick: () {
                      Navigator.of(context).pop();
                    },
                    rightBtnClick: () {
                      Navigator.of(context).pop();
                    },
                  );
                });
          },
        ),
      ),
    );
  }

  Future<void> changeLanguage(context) async {
    int i = await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('请选择语言'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  // 返回1
                  Navigator.pop(context, 1);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text('中文简体'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  // 返回2
                  Navigator.pop(context, 2);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text('美国英语'),
                ),
              ),
            ],
          );
        });

    if (i != null) {
      print("选择了：${i == 1 ? "中文简体" : "美国英语"}");
    }
  }
}
