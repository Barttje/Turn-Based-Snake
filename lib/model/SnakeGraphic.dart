import 'package:flutter/material.dart';
import 'package:turn_based_snake/painter/CirclePainter.dart';

class SnakeUI extends StatefulWidget {
  SnakeUI({this.model}) : super(key: GlobalKey<SnakeUIState>());
  final SnakeUIModel model;
  @override
  SnakeUIState createState() => SnakeUIState();
}

class SnakeUIState extends State<SnakeUI> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  Offset center;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 100).animate(controller)
      ..addListener(() {
        setState(() {
          center = average(
              animation.value, widget.model.center_o, widget.model.center);
        });
      });
    controller.forward();
  }

  Offset getPosition() {
    if (center == null) {
      return widget.model.center_o;
    }
    return center;
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CirclePainter(getPosition(), widget.model.radius,
          widget.model.color, widget.model.visible),
      child: Container(),
    );
  }

  Offset average(double percentage, Offset origin, Offset target) {
    return Offset(
        ((origin.dx * (100 - percentage)) + (target.dx * percentage)) / 100,
        ((origin.dy * (100 - percentage)) + (target.dy * percentage)) / 100);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class SnakeUIModel {
  SnakeUIModel(this.x, this.y, this.center, this.radius, this.center_o,
      {this.color = Colors.grey});
  final int x;
  final int y;
  final Offset center;
  final Offset center_o;
  final double radius;
  bool visible = true;
  Color color;
}
