import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';

/// 百度地图sdk 使用
class BaiDuMapSdk extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BaiDuMapSdkState();
}

class _BaiDuMapSdkState extends State<BaiDuMapSdk> {
  BMFMapOptions mapOptions = BMFMapOptions(
      center: BMFCoordinate(39.917215, 116.380341),
      zoomLevel: 12,
      mapPadding: BMFEdgeInsets(left: 30, top: 0, right: 30, bottom: 0));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("百度地图sdk使用"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: BMFMapWidget(
          onBMFMapCreated: (controller) {
            onBMFMapCreated(controller);
          },
          mapOptions: mapOptions,
        ),
      ),
    );
  }

  void onBMFMapCreated(BMFMapController controller) {}
}
