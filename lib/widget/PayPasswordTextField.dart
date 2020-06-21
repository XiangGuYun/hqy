import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../my_lib/extension/BaseExtension.dart';

///=============================================================================
///支付密码输入框
///=============================================================================
class PayPasswordTextField extends StatefulWidget {
  @override
  _PayPasswordTextFieldState createState() => _PayPasswordTextFieldState();
}

class _PayPasswordTextFieldState extends State<PayPasswordTextField> {
  ///创建一个焦点节点
  FocusNode _commentFocus = FocusNode();
  var currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getSrnW() - 80,
      height: 60,
      child: Row(
        children: <Widget>[
          Container(
            width: 40,
            height: 60,
            child: TextField(
              focusNode: currentIndex==1?_commentFocus:null,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
              ],
              textAlign: TextAlign.center,
              onChanged: (value) {
                if(value.length==1){
                  setState(() {
                    currentIndex = 2;
                    FocusScope.of(context).requestFocus(_commentFocus);
                  });
                }
              },
            ),
          ),
          SizedBox(
            width: 1,
          ).setExpanded(1),
          Container(
            width: 40,
            height: 60,
            child: TextField(
              focusNode: currentIndex==2?_commentFocus:null,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(1),
              ],
              textAlign: TextAlign.center,
              onChanged: (value) {
                if(value.length==1){

                }
              },
            ),
          ),
          SizedBox(
            width: 1,
          ).setExpanded(1),
          Container(
            width: 40,
            height: 60,
            child: TextField(),
          ),
          SizedBox(
            width: 1,
          ).setExpanded(1),
          Container(
            width: 40,
            height: 60,
            child: TextField(),
          ),
          SizedBox(
            width: 1,
          ).setExpanded(1),
          Container(
            width: 40,
            height: 60,
            child: TextField(),
          ),
          SizedBox(
            width: 1,
          ).setExpanded(1),
          Container(
            width: 40,
            height: 60,
            child: TextField(),
          ),
        ],
      ),
    );
  }
}


