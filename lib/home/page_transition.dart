import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'draw_page.dart';

///页面的切换动画
///
class PageTransition extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PageTransitionPage();
  }
}

class PageTransitionPage extends State<PageTransition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("flutter 页面之间的转场动画"),
      ),
      endDrawer: Page3(),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      _createRoute(
                          Tween(begin: Offset(1.0, 0), end: Offset.zero)));
                },
                child: Text("right in"))
          ],
        ),
      ),
    );
  }
}

Route _createRoute(Tween<Offset> tween) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Page2(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position:
              animation.drive(tween.chain(CurveTween(curve: Curves.ease))),
          child: child,
        );
      });
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("page2"),
      ),
      body: Center(
        child: Text("转场页面"),
      ),
    );
  }
}

