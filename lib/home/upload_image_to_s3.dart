import 'dart:async';
import 'dart:collection';
import 'dart:developer';

import 'package:amazon_s3_cognito/amazon_s3_cognito.dart';
import 'package:amazon_s3_cognito/aws_region.dart';
import 'package:amazon_s3_cognito/image_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/utils/http_manager.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageExample extends StatefulWidget {
  const UploadImageExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UploadImageExampleState();
}

class _UploadImageExampleState extends State<UploadImageExample> {
  String _platformVersion = 'Unknown';

  EventChannel _amazonS3Stream =
      EventChannel('amazon_s3_cognito_images_upload_steam');
  StreamSubscription? uploadListenerSubscription;

  List<ImageData> filesToUpload = [];

  @override
  void initState() {
    super.initState();
    _listenToFileUpload();
  }

  void _listenToFileUpload() {
    //when you want to upload multi-files or listen to upload then
    //you get the image progress via this stream
    uploadListenerSubscription =
        _amazonS3Stream.receiveBroadcastStream().listen((event) {
      LinkedHashMap<Object?, Object?> map = event;
      print(map);
      ImageData imageData = ImageData.fromMap(map);
      //update the ui based on the object returned in stream
    });
  }

  void uploadMultipleFileUploads() async {
    String bucketName = "test";
    String cognitoPoolId = "your pool id";
    String bucketRegion = "imageUploadRegion";
    String bucketSubRegion = "Sub region of bucket";

    //fileUploadFolder - this is optional parameter
    String fileUploadFolder =
        "folder inside bucket where we want file to be uploaded";

    String filePath = ""; //path of file you want to upload
    ImageData imageData = ImageData("uniqueFileName", filePath,
        uniqueId: "uniqueIdToTrackImage", imageUploadFolder: fileUploadFolder);
    filesToUpload.add(imageData);
    filesToUpload.add(imageData);
    filesToUpload.add(imageData);

    //needProgressUpdateAlso - in event stream you will get progress of the image also
    //needMultipartUpload - only applicable for IOS, when your uploads are so large that they take more than 1 hour to complete set its value to true
    await AmazonS3Cognito.uploadImages(bucketName, cognitoPoolId, bucketRegion,
        bucketSubRegion, filesToUpload, false);
  }

  void uploadSingleImage() async {
    String bucketName = "rk-db";
    String cognitoPoolId = "arn:aws:s3:::rk-db";
    String bucketRegion = "aws:s3";
    String bucketSubRegion = "ap-southeast-1";

    //fileUploadFolder - this is optional parameter
    String fileUploadFolder =
        "https://rk-db.s3.ap-southeast-1.amazonaws.com/avatar/";

    String filePath =
        "https://rk-db.s3.ap-southeast-1.amazonaws.com/avatar/"; //path of file you want to upload
    ImageData imageData = ImageData("uniqueFileName", filePath,
        uniqueId: "uniqueIdToTrackImage", imageUploadFolder: fileUploadFolder);

    //result is either amazon s3 url or failure reason
    String? result = await AmazonS3Cognito.upload(
        bucketName, cognitoPoolId, bucketRegion, bucketSubRegion, imageData,
        needMultipartUpload: true);
    //once upload is success or failure update the ui accordingly
    print(result);
  }

  void deleteImage() async {
    String cognitoPoolId = "your pool id";
    String bucketRegion = "imageUploadRegion";
    String bucketSubRegion = "Sub region of bucket";

    //fileUploadFolder - this is optional parameter
    //folder inside bucket where file exists
    //example - if file is there in test/101/abc.jpg. where test is bucket name
    //then fileUploadFolder = "101/"

    String bucketName = "test";
    String fileUploadFolder = "101/";
    String fileName = "abc.jpg";

    String? result = await AmazonS3Cognito.delete(bucketName, cognitoPoolId,
        fileName, fileUploadFolder, bucketRegion, bucketSubRegion);

    if (result != null) {
      print(result);
    }
  }

  void dispose() {
    super.dispose();
    uploadListenerSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
            child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  final ImagePicker _picker = ImagePicker();
                  // Pick an image
                  final XFile? image =
                      await _picker.pickImage(source: ImageSource.gallery);
                  String path = image?.path ?? "";
                  String BUCKET_NAME = "rk-db";
                  String IDENTITY_POOL_ID = "ap-southeast-1:64ff2184-0ce0-4704-8ee8-71024a97f7c4";
                  String IMAGE_NAME = image?.path ?? "";
                  List<String> _temp = IMAGE_NAME.split("/");

                  log("image name ---->>>>> $IMAGE_NAME path---- >>>>${_temp.last}");
                  ImageData im = ImageData("avatar/${_temp.last}", "${path}");
                  String? uploadedImageUrl = await AmazonS3Cognito.upload(
                    BUCKET_NAME,
                    IDENTITY_POOL_ID,
                    AwsRegion.AP_SOUTHEAST_1,
                    AwsRegion.AP_SOUTHEAST_1,
                    im,
                  );
                  log("upload image url --->>>>$uploadedImageUrl");


                },
                child: Text("选择图片"))
          ],
        )),
      ),
    );
  }


  void uploadImage(path,name) async{
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(path, filename: name),
      'key': '$name' // 这个是我们加传的，所以采用单文件上传
    });
    HttpManager.upload(url: "https://rk-db.s3.amazonaws.com/avatar/", params: formData);
  }

//
//   void test(file) async{
//     final key = new DateTime.now().toString();
//     Map<String, String> metadata = <String, String>{};
//     metadata['name'] = 'filename';
//     metadata['desc'] = 'A test file';
//     S3UploadFileOptions options = S3UploadFileOptions(accessLevel: StorageAccessLevel.guest, metadata: metadata);
//     try {
//       UploadFileResult result = await Amplify.Storage.uploadFile(
//           key: key,
//           local: file,
//           options: options
//       );
//     } on StorageException catch (e) {
//       print(e.message);
//     }
//   }
//   Future<void> createAndUploadFile(path) async {
//     // Add this line, to include Auth and Storage plugins.
//     await Amplify.addPlugins([AmplifyAuthCognito(), AmplifyStorageS3()]);
// // ... add other plugins, if any
//     await Amplify.configure(amplifyconfig);
//
//     File file = File(path);
//     // Upload the file to S3
//     try {
//       final UploadFileResult result = await Amplify.Storage.uploadFile(
//           local: file,
//           key: 'admin',
//           onProgress: (progress) {
//             print("Fraction completed: " + progress.getFractionCompleted().toString());
//           }
//       );
//       print('Successfully uploaded file: ${result.key}');
//     } on StorageException catch (e) {
//       print('Error uploading file: $e');
//     }
//   }
}
