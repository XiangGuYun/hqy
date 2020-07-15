import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///通用输入框
class EditText extends StatefulWidget {
  ///输入框宽度（必须制定）
  final double width;

  ///输入框高度
  final double height;

  ///输入文本的内容
  final String text;

  ///输入文本的字体大小
  final double textSize;

  ///输入文本的字体颜色
  final Color textColor;

  ///提示文字的内容
  final String hint;

  ///提示文字的字体大小
  final double hintSize;

  ///提示文字的字体颜色
  final Color hintColor;

  ///最大可输入字数
  final int maxLength;

  ///输入监听
  final Function onChanged;

  ///输入文本类型
  final TextInputType inputType;

  ///键盘动作按钮
  final TextInputAction action;

  ///外边距
  final EdgeInsets margin;

  ///内边距
  final EdgeInsets padding;

  ///最大行数
  final int maxLines;

  /// 输入控制器
  final TextEditingController controller;

  final FocusNode focusNode;

  EditText(this.width,
      {Key key,
      this.height = 36,
      this.textSize = 14.0,
      this.controller = null,
      this.hint,
      this.maxLength = 20,
      this.onChanged = null,
      this.inputType = TextInputType.text,
      this.action = TextInputAction.go,
      this.hintSize = 14.0,
      this.hintColor = const Color(0xFFC9C8CD),
      this.text = '',
      this.textColor = const Color(0xFF393649),
      this.margin = const EdgeInsets.all(0),
      this.padding = const EdgeInsets.all(0),
      this.focusNode = null,
      this.maxLines = 1})
      : super(key: key);

  @override
  _EditTextState createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      padding: widget.padding,
      child: TextField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        textInputAction: widget.action,
        keyboardType: widget.inputType,
        style: TextStyle(fontSize: widget.textSize, color: widget.textColor),
        //监听输入事件
        onChanged: widget.onChanged,
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.maxLength),
        ],
        cursorColor: Colors.black,
        maxLines: widget.maxLines,
        textAlign: TextAlign.left,
        //装饰
        decoration: InputDecoration(
            //设置提示文字
            hintText: widget.hint,
            hintStyle:
                TextStyle(fontSize: widget.hintSize, color: widget.hintColor),
            //设置边框
            border: InputBorder.none //去除
            ),
      ),
    );
  }
}
