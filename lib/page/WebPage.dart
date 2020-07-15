import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:wobei/widget/TitleBar.dart';

///*****************************************************************************
///
/// 通用WebView
///
///*****************************************************************************
class WebPage extends StatefulWidget {

  final String url;

  WebPage({this.url});

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> with SingleTickerProviderStateMixin{

  String title = '';
  FlutterWebviewPlugin flutterWebViewPlugin = FlutterWebviewPlugin();

  //获取h5页面标题
  Future<String> getWebTitle() async {
    String script = 'window.document.title';
    var title = await
    flutterWebViewPlugin.evalJavascript(script);
    setState(() {
      this.title = title.replaceAll('"', '');
      print('####################   $title');
    });
  }


  @override
  void initState() {
    super.initState();

    /**
     * 监听web页加载状态
     */
    flutterWebViewPlugin.onStateChanged.listen((
        WebViewStateChanged webViewState) async {
//      setState(() {
//        title = webViewState.type.toString();
//      });
      switch (webViewState.type) {
        case WebViewState.finishLoad:
          handleJs();
          getWebTitle();

          break;
        case WebViewState.shouldStart:
          break;
        case WebViewState.startLoad:
          break;
        case WebViewState.abortLoad:
          break;
      }
    });

    /**
     * 监听页面加载url
     */
    flutterWebViewPlugin.onUrlChanged.listen((String url) {
//      getWebTitle(url: url);

//      setState(() {
//        title = url;
//      });
    });

  }

  void handleJs() {
//    flutterWebViewPlugin.evalJavascript(
//        "abc(${title}')")
//        .then((result) {
//    });
  }


  @override
  Widget build(BuildContext context) {
    return  WebviewScaffold(
      url: widget.url,
      withLocalStorage: true,
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(44.0),
        child: TitleBar(title: title,),
      ),
    );
  }
}
