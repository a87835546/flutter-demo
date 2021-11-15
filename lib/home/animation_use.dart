import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/home/animated_widget_use.dart';

class AnimationUse extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AnimationState();
  }
}

bool _isAnimated = true;

/// animation 动画的使用
class AnimationState extends State<AnimationUse>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  late double _animationValue = 0;
  late AnimationStatus _animationState = AnimationStatus.reverse;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _animation = Tween<double>(begin: 0, end: 300).animate(_animationController)
      ..addListener(() {
        setState(() {
          _animationValue = _animation.value;
        });
      })
      ..addStatusListener((status) {
        print("status ---->>>>> $status");
        setState(() {
          _animationState = status;
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("animation 的使用"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  _animationController.reverse();
                  _animationController.forward();
                },
                child: Text("开始动画")),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isAnimated = true;
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AnimationWidgetUse();
                  }));
                },
                child: Text("animated widget 动画1")),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isAnimated = false;
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AnimationWidgetUse();
                  }));
                },
                child: Text("animated widget 动画2")),
            Container(
              width: _animationValue,
              height: _animationValue,
              child: FlutterLogo(),
            ),
            Text("animation value:${_animationValue}"),
            Text("animation status : ${_animationState}")
          ],
        ),
      ),
    );
  }
}

class AnimationWidgetUse extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AnimationWidgetUseState();
  }
}

class AnimationWidgetUseState extends State<AnimationWidgetUse>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation =
        Tween<double>(begin: 0, end: 300).animate(_animationController);
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return TopMenuWidget(controller: _animationController);
    return _isAnimated
        ? TopMenuWidget(controller: _animationController)
        : AnimatedLogo(animation: _animation);
  }
}
