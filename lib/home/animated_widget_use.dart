import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedWidgetUse extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AnimatedWidgetUseState();
  }
}

class AnimatedWidgetUseState extends State<AnimatedWidgetUse>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    return Scaffold(
      appBar: AppBar(title: const Text("animation widget 使用")),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: animation.value,
          width: animation.value,
          child: const FlutterLogo(),
        ),
      ),
    );
  }
}

class TopMenuWidget extends AnimatedWidget {
  const TopMenuWidget({Key? key, required AnimationController controller})
      : super(key: key, listenable: controller);

  @override
  Widget build(BuildContext context) {
    Animation<double> animation = listenable as Animation<double>;

    return Transform.translate(offset: Offset(50, 100 * animation.value),
      child: Opacity(
        opacity: animation.value,
        child:Container(
          width: 200,
          height: 100,
          color: Colors.redAccent,
          child: Center(
            child: GestureDetector(
              onTap: ()=> print("animated widget"),
              child: Icon(Icons.person),
            ),
          ),
        ),
      ),);
  }
}
