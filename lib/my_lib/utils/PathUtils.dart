import 'dart:io';

import 'package:path_provider/path_provider.dart';

class PathUtils{

  ///临时目录
  ///获取应用的缓存路径，系统可随时清除的临时目录（缓存）
  ///在iOS上，这对应于NSTemporaryDirectory() 返回的值。
  ///在Android上，这是getCacheDir())返回的值（data/data/0/包名/cache）
  static Future<String> getTempPath() async {
    Directory tempDir = await getTemporaryDirectory();
    return tempDir.path;
  }

  ///外部存储目录
  ///获取SDCard路径，仅限Android系统使用
  static Future<String> getSDCardPath() async {
    Directory sdDir = await getExternalStorageDirectory();
    return sdDir.path;
  }

  ///文档目录
  ///可以使用getApplicationDocumentsDirectory()来获取应用程序的文档目录，
  ///该目录用于存储只有自己可以访问的文件。只有当应用程序被卸载时，系统才会清除该目录。
  ///在iOS上，这对应于NSDocumentDirectory。
  ///在Android上，这是AppData目录。
  static Future<String> getDocPath() async {
    Directory docDir = await getApplicationDocumentsDirectory();
    return docDir.path;
  }

}