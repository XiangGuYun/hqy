import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wobei/constant/Config.dart';
import '../extension/BaseExtension.dart';

///********************************************************************************************
///
/// 封装头像选择和显示工具类
///
///********************************************************************************************
class AvatarUtils {

  final picker = ImagePicker();

  void showSelectPhotoDialog(BuildContext context, Function callback) {
    showModalBottomSheet<void>(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        builder: (BuildContext context) {
          return Container(
            height: 152,
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 50,
                  color: Colors.white,
                  // 扩大点击区域
                  alignment: Alignment.center,
                  child: Text(
                    '拍照',
                    style: TextStyle(fontSize: 17, color: Config.BLACK_303133),
                  ),
                ).setGestureDetector(onTap: (){
                  _takePhoto(context, callback);
                }),
                Divider(
                  height: 1,
                  color: Config.DIVIDER_COLOR,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  color: Colors.white,
                  // 扩大点击区域
                  alignment: Alignment.center,
                  child: Text(
                    '从相册获取',
                    style: TextStyle(fontSize: 17, color: Config.BLACK_303133),
                  ),
                ).setGestureDetector(onTap: (){
                  _openGallery(context, callback);
                }),
                Divider(
                  height: 1,
                  color: Config.DIVIDER_COLOR,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  color: Colors.white,
                  // 扩大点击区域
                  alignment: Alignment.center,
                  child: Text(
                    '取消',
                    style: TextStyle(fontSize: 17, color: Config.BLACK_303133),
                  ),
                ).setGestureDetector(onTap: () {
                  Navigator.of(context).pop();
                }),
              ],
            ),
          );
        });
  }

  ///---------------------------------------------------------------------------
  /// 拍摄照片
  ///---------------------------------------------------------------------------
  void _takePhoto(BuildContext context, Function callback) async {
    _select(context, 1, callback);
  }

  ///---------------------------------------------------------------------------
  /// 打开相册
  ///---------------------------------------------------------------------------
  void _openGallery(BuildContext context, Function callback) async {
    _select(context, 2, callback);
  }

  ///---------------------------------------------------------------------------
  ///
  /// 选择、裁剪并上传头像照片
  ///
  /// method 1 相机 2 相册
  ///
  ///---------------------------------------------------------------------------
  void _select(BuildContext context, int method, Function callback) async {
    Navigator.of(context).pop();
    ImageSource source =
    (method == 1 ? ImageSource.camera : ImageSource.gallery);
    picker.getImage(source: source, maxWidth: 400, maxHeight: 400).then((pickedFile) {
      ImageCropper.cropImage(
          sourcePath: pickedFile.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.black,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          )).then((croppedFile) {
          callback(croppedFile);
      });
    });
  }
}