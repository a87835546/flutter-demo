import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

class Page3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DrawerPage();
  }
}

class DrawerPage extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, left: 10),
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height,
      color: Color(0xff2c2c2e),
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: IconButton(onPressed: (){},icon: Icon(Icons.close),iconSize: 20),
            ),
            SliverToBoxAdapter(
              child: Text(
                "Scaffold 上的endDrawer 右侧抽屉盒子Drawer的使用，和 CustomScrollView 下得SliverToBoxAdapter 使用",
                style: TextStyle(
                  color: Colors.white,
                ),
                maxLines: 4,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
              ),
            ),
            SliverToBoxAdapter(
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      color: Colors.red,
                      height: 40,
                      child: Text("row :$index"),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      height: 10,
                      color: Colors.grey,
                    );
                  },
                  itemCount: 10),
            ),
            SliverToBoxAdapter(
              child: Text("1232312"),
            )
          ],
        ),
      ),
    );
  }
}
