import 'package:flutter/material.dart';
import 'package:turn_based_snake/model/Snake.dart';
import 'package:turn_based_snake/model/SnakeGraphic.dart';
import 'package:turn_based_snake/painter/Circle.dart';
import 'package:turn_based_snake/widgets/CardSelection.dart';
import 'package:turn_based_snake/widgets/cards/BaseCard.dart';
import 'package:turn_based_snake/widgets/cards/MoveDownCard.dart';
import 'package:turn_based_snake/widgets/cards/MoveLeftCard.dart';
import 'package:turn_based_snake/widgets/cards/MoveRightCard.dart';
import 'package:turn_based_snake/widgets/cards/MoveUpCard.dart';
import 'package:turn_based_snake/widgets/Targets.dart';

import 'events/Event.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Circle> circles = [];
  final nrX = 11;
  final nrY = 12;
  Snake snake1 = Snake(Colors.orange, 1, Offset(3, 6));
  Snake snake2 = Snake(Colors.blue, 1, Offset(6, 7));

  @override
  void initState() {
    super.initState();
    snake1.pos.add(Offset(2, 6));
    snake1.pos.add(Offset(2, 5));
    snake1.pos.add(Offset(2, 4));
    for (int x = 0; x < nrX; x++) {
      for (int y = 0; y < nrY; y++) {
        circles.add(createCircle(x, y));
      }
    }
  }

  void _incrementCounter() {
    setState(() {});
  }

  Circle createCircle(int x, int y) {
    double dx = ((x + 1) * 30).toDouble();
    double dy = ((y + 1) * 30).toDouble();
    return Circle(
      model: CircleModel(
        x,
        y,
        Offset(dx, dy),
        determineRadius(x, y),
        color: determineColor(x, y),
      ),
    );
  }

  Color determineColor(final int x, final int y) {
    if (isPlayer(x, y, snake1)) {
      return snake1.color;
    }
    if (isPlayer(x, y, snake2)) {
      return snake2.color;
    }
    if (isBorder(x, y)) {
      return Colors.black54;
    }
    return Colors.grey[400];
  }

  update() {
    setState(() {
      circles.clear();
      for (int x = 0; x < nrX; x++) {
        for (int y = 0; y < nrY; y++) {
          circles.add(createCircle(x, y));
        }
      }
    });
  }

  applyEvents(final List<Event> events) {
    events.forEach((element) {
      element.applyEvent(snake1);
      update();
    });
  }

  bool isPlayer(int x, int y, Snake snake) =>
      snake.pos.any((element) => isPlayerPosition(x, y, element));

  bool isPlayerPosition(int x, int y, Offset offset) =>
      x.toDouble() == offset.dx && y.toDouble() == offset.dy;

  double determineRadius(final int x, final int y) =>
      isPlayer(x, y, snake1) || isPlayer(x, y, snake2) ? 12 : 8;

  bool isBorder(int x, int y) =>
      x == 0 || y == 0 || x == (nrX - 1) || y == (nrY - 1);

  var color = Colors.orange;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Snake"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 400,
            child: Stack(children: [
              Stack(
                children: circles,
              ),
            ]),
          ),
          CardSelection(
            cardSelectionModel: CardSelectionModel(
              3,
              4,
              applyEvents,
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
