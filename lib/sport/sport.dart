import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/sport/sport_keyboard.dart';
import 'package:flutter_demo/sport/widget/sport_banner.dart';
import 'package:flutter_demo/sport/widget/sport_noti.dart';
import 'package:flutter_demo/wallet/deposit_navi_bar_widget.dart';
import 'package:flutter_demo/sport/model/BannerAndMaqueeModel.dart'
    as BannerModel;

class SportPage extends StatefulWidget {
  const SportPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SportPageState();
}

class _SportPageState extends State<SportPage> {
  List<BannerModel.Page>? pages;
  List<String> maquaa = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: Text("123"),
        body: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView(shrinkWrap: true, children: [
            DepositNaviBar(
              balance: "10",
              height: MediaQuery.of(context).padding.top,
            ),
            SportBanner(
              pages: pages ?? [],
            ),
            SportNotificationView(
              maquaa: maquaa,
            ),
            InkWell(
              onTap: () async {
                print("右边侧滑");
                Navigator.push(
                    context,
                    _createRoute(
                        Tween(begin: Offset(1.0, 0), end: Offset.zero)));
              },
              child: Padding(
                padding: EdgeInsets.only(left: 12),
                child: Image.asset(
                  "imgs/mine/images/icon-edit@3x.png",
                  height: 30,
                  color: Colors.redAccent,
                ),
              ),
            ),
          ]),
        ));
  }

  Route _createRoute(Tween<Offset> tween) {
    return PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, animation, secondaryAnimation) =>
            SportKeyboard(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position:
                // animation.drive(tween.chain(CurveTween(curve: Curves.ease))),
                Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0))
                    .animate(animation),
            child: child,
          );
        });
  }
}
