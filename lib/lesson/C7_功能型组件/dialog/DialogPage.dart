import 'package:flutter/material.dart';

///对话框页面
class DialogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Dialog'),
          onPressed: (){
            showListDialog(context);
          },
        ),
      ),
    );
  }

  Future<void> showListDialog(context) async {
    int index = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        var child = Container(
          width: 300,
          child: Column(
            children: <Widget>[
              ListTile(title: Text("请选择")),
              Expanded(
                  child: ListView.builder(
                    itemCount: 30,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text("$index"),
                        onTap: () => Navigator.of(context).pop(index),
                      );
                    },
                  )),
            ],
          ),
        );
        //使用AlertDialog会报错
        //return AlertDialog(content: child);

        var dialog1 = Dialog(
          child: child,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
        );

        var dialog2 = UnconstrainedBox(
          constrainedAxis: Axis.vertical,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 280, maxHeight: 500),
            child: Material(
              child: child,
              type: MaterialType.card,
            ),
          ),
        );

        return dialog2;
      },
    );
    if (index != null) {
      print("点击了：$index");
    }
  }

}
