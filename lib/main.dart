import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/home/city_picker.dart';
import 'package:flutter_demo/home/device_info_page.dart';
import 'package:flutter_demo/home/home.dart';
import 'package:flutter_demo/home/upload_image_to_s3.dart';
import 'package:flutter_demo/tabbar/custom_bottom_navigation_bar.dart';
import 'package:magic_sdk/magic_sdk.dart';
import 'package:provider/provider.dart';

import 'home/animation_use.dart';
import 'home/app_lifecycle.dart';
import 'home/baidu_map_sdk_use.dart';
import 'home/blockchain_wallet_page.dart';
import 'home/card_use.dart';
import 'home/catalogue_list.dart';
import 'home/corner_radius_button.dart';
import 'home/expansion_use.dart';
import 'home/list_view_controller.dart';
import 'home/login_by_google.dart';
import 'home/magic_wallet.dart';
import 'home/navigator_use.dart';
import 'home/page_transition.dart';
import 'home/provider_use.dart';
import 'home/request_page.dart';
import 'home/share_preference_use.dart';
import 'home/stateful_use.dart';
import 'home/swiper_demo.dart';
import 'home/webview_use.dart';
import 'home/widget_lifecycle.dart';
import 'mine/mine.dart';

void main() async {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ProviderModel()),
    ChangeNotifierProvider(create: (_) => UserProviderModel()),
  ],child: const MyApp(),));

  Magic.instance = Magic("pk_live_B105F42AA2851AEC");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _config();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: Stack(
        children: [
          MaterialApp(
            home: CustomBottomNavigationBar(),
          ),
          Magic.instance.relayer // Insert Magic relayer here

        ],
      ),
      routes: <String, WidgetBuilder>{
        'home': (BuildContext context) => Home(),
        'mine': (BuildContext context) => Mine(),
        'stateful_use': (BuildContext context) => StatefulUse(),
        'navigator_use': (BuildContext context) => const NavigatorUse("123"),
        'list_view_controller': (BuildContext context) => ListViewController(),
        'widget_lifecycle': (BuildContext context) => WidgetLifeCycle(),
        'app_lifecycle': (BuildContext context) => AppLifeCycle(),
        'page_transition': (BuildContext context) => PageTransition(),
        'device_info': (BuildContext context) => DeviceInfo(),
        'request_use': (BuildContext context) => RequestUse(),
        'animation_use': (BuildContext context) => AnimationUse(),
        'swiper_demo': (BuildContext context) => SwiperDemo(),
        'share_preference_use': (BuildContext context) => SharePreferenceUse(),
        'expansion_title_use': (BuildContext context) => ExpansionUse(),
        'corner_radius_button': (BuildContext context) =>
            const CornerRadiusButton(),
        'catalogue_list': (BuildContext context) => CatalogueList(),
        'custom_webView': (BuildContext context) => const CustomWebView(),
        'card_use': (BuildContext context) => const CardUse(),
        'baidu_mapi_use': (BuildContext context) => BaiDuMapSdk(),
        'city_picker': (BuildContext context) =>
            CityPickerPage(title: "123123"),
        'provider_use': (BuildContext context) => ProviderPage(),
        'google_sign_in': (BuildContext context) => GoogleLoginPage(),
        'magic_wallet_page': (BuildContext context) => MagicWalletPage(),
        'blockchain_wallet_page': (BuildContext context) => BlockchainWalletPage(),
        'upload_image_page': (BuildContext context) => UploadImageExample(),
      },
    );
  }

  void _config() {

    if (!kIsWeb && Platform.isIOS) {
      BMFMapSDK.setApiKeyAndCoordType(
          'gb38j4SGzq83tL4z2amTus262D2w3QnR', BMF_COORD_TYPE.BD09LL);
    } else if (!kIsWeb && Platform.isAndroid) {
// Android 目前不支持接口设置Apikey,
// 请在主工程的Manifest文件里设置，详细配置方法请参考[https://lbs.baidu.com/ 官网][https://lbs.baidu.com/)demo
      BMFMapSDK.setCoordType(BMF_COORD_TYPE.BD09LL);
    }
  }

}
