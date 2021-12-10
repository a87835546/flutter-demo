import 'dart:collection';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/utils/color_util.dart';
import 'package:flutter_demo/utils/http_manager.dart';
import 'package:image_picker/image_picker.dart';

typedef SuggestionSelectImageViewClick = Function(dynamic);

/// 选择图片
class SuggestionSelectImageView extends StatefulWidget {
  final SuggestionSelectImageViewClick click;

  const SuggestionSelectImageView({Key? key, required this.click})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SuggestionSelectImageViewState();
}

class _SuggestionSelectImageViewState extends State<SuggestionSelectImageView> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 14, top: 5),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "问题截图：",
                textAlign: TextAlign.left,
                style:
                    TextStyle(color: ColorUtil.mainTitleColor(), fontSize: 14),
              ),
            )),
        Padding(
            padding: const EdgeInsets.only(left: 14, right: 14),
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                  // border: Border.all(),
                  borderRadius: BorderRadius.circular(4),
                  color: ColorUtil.hexColor('0x2c2c2e')
                      .withAlpha((255 * 0.6).toInt())),
              child: Container(
                width: MediaQuery.of(context).size.width -28,

                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5, top: 5, right: 5),
                      child: Text(
                        "*文件格式为PNG，JPG，JPEG，且大小不超过15MB（目前仅支持上传一张）",
                        style: TextStyle(
                            color: ColorUtil.hexColor("0x919699"),
                            fontSize: 14),
                      ),
                    ),
                    Visibility(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top:5,left: 5),
                        child: image != null
                            ? Image.file(File(image?.path ?? ""),width: 100,height: 75,)
                            : null,
                      ),
                      visible: image != null,
                    ),
                    Padding(padding: EdgeInsets.only(top: 30)),
                    GestureDetector(
                      onTap: () {
                        widget.click(null);
                        getImage().then((value) {
                          // log(value);
                          setState(() {
                            image = value;
                          });
                        }).catchError((err) {
                          log("get image error ${err}");
                        });
                      },
                      child: Container(
                        height: 70,
                        width: 70,
                        color: ColorUtil.hexColor("0x333539"),
                        alignment: Alignment.center,
                        child: Image.asset("imgs/images/icon-add@3x.png",
                            width: 30, height: 30, fit: BoxFit.contain),
                      ),
                    )
                  ],
                ),
              ),
            ))
      ],
    ));
  }

  Future getImage() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery).then((value){
      updateImage(value!.path);
    });
    log("${file?.path}");
    return file;
    //     .then((value) {
    //   log("selected images : $value");
    //   return value;
    // }).onError((error, stackTrace) {
    //   log("select image error :$error");
    // }).whenComplete(() {
    //   log("select image finish");
    // });
  }
  void updateImage(String path) async {
    String name = path.split('/').last;
    log(name);
    FormData formData = FormData.fromMap({'file': await MultipartFile.fromFile(path,filename: name)});
    log('form data ${formData.length}');
    await HttpManager.upload(params: formData, url: "user/upload").then((
        result) {
      log('update image result $result');
    });
  }


  void upload(String path) async{
    Dio dio =  Dio();
    var formData = FormData.fromMap({
      'name': 'wendux',
      'age': 25,
      'file': await MultipartFile.fromFile(path,filename: 'upload.png')
    });
    dio.post("http://192.168.55.104:9000/user/upload",data: formData,onSendProgress: (progress,total){
      log("${progress/total}");
    }).then((value) {
      log('upload result $value');
    }).catchError((err){
      log("upload err ${err.toString()}");
    });
  }
}
