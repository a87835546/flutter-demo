
import 'package:flutter/cupertino.dart';

class ScreenUtils {
  static final ScreenUtils _instance = ScreenUtils();
  late double width;
  late double height;
  late bool allowFontScaling;

  static MediaQueryData _mediaQueryData = MediaQueryData();
  static double _screenWidth = 0;
  static double _screenHeight = 0;

  ///设备的像素密度
  static double _pixelRatio = 0;
  /// 状态栏高度
  static double _statusBarHeight = 0;
  /// 底部tabbar 高度
  static double _bottomBarHeight = 0;

  /// 每个逻辑像素的字体像素
  static double _textScaleFactor = 0;

  ScreenUtils(){
    width = 1080;
    height = 1920;
    allowFontScaling = false;
  }

  static ScreenUtils getInstance(){
    return _instance;
  }

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    _pixelRatio = _mediaQueryData.devicePixelRatio;

    _screenHeight = _mediaQueryData.size.height;

    _screenWidth = _mediaQueryData.size.width;

    _statusBarHeight = _mediaQueryData.padding.top;

    _bottomBarHeight = _mediaQueryData.padding.bottom;

    _textScaleFactor = _mediaQueryData.textScaleFactor;
  }

  static MediaQueryData get mediaQueryData => _mediaQueryData;

  static double get kTextScaleFactor => _textScaleFactor;

  static double get kPixelRatio => _pixelRatio;

  static double get kScreenWidth => _screenWidth;

  static double get kScreenHeight => _screenHeight;

  static double get kStatusBarHeight => _statusBarHeight;

  static double get kBottomBarHeight => _bottomBarHeight;

  get kScaleWidth => _screenWidth / _instance.width;
  get kScaleHeight => _screenHeight / _instance.height;


  ///根据设计稿的设备宽度适配
  ///高度也根据这个来做适配可以保证不变形
  setWidth(double width) => width* kScaleWidth;

  /// 根据设计稿的设备高度适配
  /// 当发现设计稿中的一屏显示的与当前样式效果不符合时,
  /// 或者形状有差异时,高度适配建议使用此方法
  /// 高度适配主要针对想根据设计稿的一屏展示一样的效果
  setHeight(double height) => height * kScaleHeight;
  ///字体大小适配方法
  ///@param fontSize 传入设计稿上字体的px ,
  ///@param allowFontScaling 控制字体是否要根据系统的“字体大小”辅助选项来进行缩放。默认值为false。
  ///@param allowFontScaling Specifies whether fonts should scale to respect Text Size accessibility settings. The default is false.
  setSp(double fontSize) => allowFontScaling? setWidth(fontSize) : setWidth(fontSize) / _textScaleFactor;
}