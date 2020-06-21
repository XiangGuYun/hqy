import 'package:flutter/material.dart';

///图片
//Flutter中，我们可以通过Image组件来加载并显示图片，Image的数据源可以是asset、文件、内存以及网络。
//Image在显示图片时定义了一系列参数，通过这些参数我们可以控制图片的显示外观、大小、混合效果等。
//我们看一下Image的主要参数：
/*
const Image({
  ...
  //用于设置图片的宽、高，当不指定宽高时，图片会根据当前父容器的限制，
  //尽可能的显示其原始大小，如果只设置width、height的其中一个，
  //那么另一个属性默认会按比例缩放，但可以通过下面介绍的fit属性来指定适应规则。
  this.width, //图片宽度
  this.height, //图片高度
  this.color, //图片的混合色值
  this.colorBlendMode, //混合模式
  this.fit,//缩放模式
  this.alignment = Alignment.center, //对齐方式
  this.repeat = ImageRepeat.noRepeat, //重复方式
  ...
})
 */
//fit:该属性用于在图片的显示空间和图片本身大小不同时指定图片的适应模式。
//适应模式是在BoxFit中定义，它是一个枚举类型，有如下值：
//fill：会拉伸填充满显示空间，图片本身长宽比会发生变化，图片会变形。
//cover：会按图片的长宽比放大后居中填满显示空间，图片不会变形，超出显示空间部分会被剪裁。
//contain：这是图片的默认适应规则，图片会在保证图片本身长宽比不变的情况下缩放以适应当前显示空间，图片不会变形。
//fitWidth：图片的宽度会缩放到显示空间的宽度，高度会按比例缩放，然后居中显示，图片不会变形，超出显示空间部分会被剪裁。
//fitHeight：图片的高度会缩放到显示空间的高度，宽度会按比例缩放，然后居中显示，图片不会变形，超出显示空间部分会被剪裁。
//none：图片没有适应策略，会在显示空间内显示图片，如果图片比显示空间大，则显示空间只会显示图片中间部分。

final String IMG =
    'https://dss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1368451564,780267377&fm=111&gp=0.jpg';

class ImageTest1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network(
              IMG,
              width: 150,
              height: 100,
              fit: BoxFit.fill,
            ),
            Image.network(
              IMG,
              width: 150,
              height: 100,
              fit: BoxFit.cover,
            ),
            Image.network(
              IMG,
              width: 150,
              height: 100,
              fit: BoxFit.contain,
            ),
            Image.network(
              IMG,
              width: 150,
              height: 100,
              fit: BoxFit.fitWidth,
            ),
            Image.network(
              IMG,
              width: 150,
              height: 100,
              fit: BoxFit.fitHeight,
            ),
            Image.network(
              IMG,
              width: 150,
              height: 100,
              fit: BoxFit.none,
            ),
          ],
        ),
      ),
    );
  }
}

//color和 colorBlendMode：在图片绘制时可以对每一个像素进行颜色混合处理，color指定混合色，
//而colorBlendMode指定混合模式，下面是一个简单的示例
class ImageTest2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
          IMG,
          width: 100.0,
          color: Colors.blue,
          colorBlendMode: BlendMode.difference,
        ),
      ),
    );
  }
}

//repeat：当图片本身大小小于显示空间时，指定图片的重复规则。简单示例如下：
class ImageTest3Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
          IMG,
          width: 100.0,
          height: 200.0,
          repeat: ImageRepeat.repeatY,
        ),
      ),
    );
  }
}

///Image缓存
//Flutter框架对加载过的图片是有缓存的（内存），默认最大缓存数量是1000，最大缓存空间为100M。
//关于Image的详细内容及原理我们将会在后面进阶部分深入介绍。

///ICON
//Flutter中，可以像Web开发一样使用iconfont，iconfont即“字体图标”，它是将图标做成字体文件，
//然后通过指定不同的字符而显示不同的图片。
//
//在字体文件中，每一个字符都对应一个位码，而每一个位码对应一个显示字形，不同的字体就是指字形不同，
//即字符对应的字形是不同的。而在iconfont中，只是将位码对应的字形做成了图标，所以不同的字符最终就会渲染成不同的图标。
//
//在Flutter开发中，iconfont和图片相比有如下优势：
//
//体积小：可以减小安装包大小。
//矢量的：iconfont都是矢量图标，放大不会影响其清晰度。
//可以应用文本样式：可以像文本一样改变字体图标的颜色、大小对齐等。
//可以通过TextSpan和文本混用。

//使用Material Design字体图标
//Flutter默认包含了一套Material Design的字体图标，在pubspec.yaml文件中的配置如下
/*
flutter:
  uses-material-design: true
 */
//Material Design所有图标可以在其官网查看：https://material.io/tools/icons/
class ImageTest4Page extends StatelessWidget {
  String icons = "\uE914\uE000\uE90D";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          icons,
          style: TextStyle(
              fontFamily: "MaterialIcons", fontSize: 24.0, color: Colors.green),
        ),
      ),
    );
  }
}

//通过这个示例可以看到，使用图标就像使用文本一样，但是这种方式需要我们提供每个图标的码点，
//这并对开发者不友好，所以，Flutter封装了IconData和Icon来专门显示字体图标，上面的例子也可以用如下方式实现：
class ImageTest5Page extends StatelessWidget {
  String icons = "\uE914\uE000\uE90D";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.accessible,
              color: Colors.green,
            ),
            Icon(
              Icons.error,
              color: Colors.green,
            ),
            Icon(
              Icons.fingerprint,
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}

///使用自定义字体图标
//我们也可以使用自定义字体图标。iconfont.cn上有很多字体图标素材，我们可以选择自己需要的图标打包下载后，
//会生成一些不同格式的字体文件，在Flutter中，我们使用ttf格式即可。
//
//假设我们项目中需要使用一个书籍图标和微信图标，我们打包下载后导入：
//导入字体图标文件；这一步和导入字体文件相同，
//假设我们的字体图标文件保存在项目根目录下，路径为"fonts/iconfont.ttf"：
/*
fonts:
  - family: myIcon  #指定一个字体名
    fonts:
      - asset: fonts/iconfont.ttf
 */
//为了使用方便，我们定义一个MyIcons类，功能和Icons类一样：将字体文件中的所有图标都定义成静态变量：
/*
class MyIcons{
  // book 图标
  static const IconData book = const IconData(
      0xe614,
      fontFamily: 'myIcon',
      matchTextDirection: true
  );
  // 微信图标
  static const IconData wechat = const IconData(
      0xec7d,
      fontFamily: 'myIcon',
      matchTextDirection: true
  );
}
 */
//使用
/*
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
    Icon(MyIcons.book,color: Colors.purple,),
    Icon(MyIcons.wechat,color: Colors.green,),
  ],
)
 */