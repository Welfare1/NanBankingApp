import 'package:flutter/material.dart';

class TestApp extends StatefulWidget {
  @override
  _TestAppState createState() => _TestAppState();
}

enum WidgetSide { Face, Pile }

class _TestAppState extends State<TestApp> with SingleTickerProviderStateMixin {
  WidgetSide _currentSide = WidgetSide.Face;
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.repeat(); // Répète l'animation en continu
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleSide() {
    setState(() {
      _currentSide =
          _currentSide == WidgetSide.Face ? WidgetSide.Pile : WidgetSide.Face;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSide,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        transitionBuilder: (child, animation) {
          final rotateAnimation =
              Tween<double>(begin: 0, end: 0.5).animate(animation);

          return Transform(
            transform: Matrix4.rotationY(rotateAnimation.value * 3.141592),
            child: child,
          );
        },
        child: _currentSide == WidgetSide.Face
            ? Container(
                key: ValueKey(WidgetSide.Face),
                width: 200,
                height: 200,
                color: Colors.blue,
                child: Center(child: Text('Widget A')),
              )
            : Container(
                key: ValueKey(WidgetSide.Pile),
                width: 200,
                height: 200,
                color: Colors.red,
                child: Center(child: Text('Widget B')),
              ),
      ),
    );
  }
}
