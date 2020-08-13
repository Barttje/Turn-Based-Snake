import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'CirclePainter.dart';

class Circle extends StatefulWidget {
  Circle({this.model}) : super(key: GlobalKey<CircleState>());
  final CircleModel model;
  final stateKey = GlobalKey<CircleState>();
  @override
  CircleState createState() => CircleState();
}

class CircleState extends State<Circle> {
  updateColor(Color color) {
    setState(() {
      widget.model.color = color;
    });
  }

  updateVisible(bool visible) {
    setState(() {
      widget.model.visible = visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CirclePainter(widget.model.center, widget.model.radius,
          widget.model.color, widget.model.visible),
      child: Container(),
    );
  }
}

class CircleModel {
  CircleModel(this.x, this.y, this.center, this.radius,
      {this.color = Colors.grey});
  final int x;
  final int y;
  final Offset center;
  final double radius;
  bool visible = true;
  Color color;
}
