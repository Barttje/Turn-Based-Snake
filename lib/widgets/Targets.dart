import 'package:flutter/material.dart';
import 'package:turn_based_snake/events/Event.dart';
import 'package:turn_based_snake/widgets/Target.dart';

import 'cards/BaseCard.dart';

class Targets extends StatefulWidget {
  final TargetsModel targetsModel;
  const Targets({Key key, this.targetsModel}) : super(key: key);
  @override
  _TargetsState createState() => _TargetsState();
}

class _TargetsState extends State<Targets> {
  Map<int, Event> map = new Map();

  applyEvent(final BaseCard event, final int id) {
    map.putIfAbsent(id, () => event.getEvent());
    if (map.length == 3) {
      widget.targetsModel.callback(map.values.toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Target(
            model: TargetModel(
          applyEvent,
          1,
        )),
        Target(
            model: TargetModel(
          applyEvent,
          2,
        )),
        Target(
            model: TargetModel(
          applyEvent,
          3,
        )),
      ],
    );
  }
}

class TargetsModel {
  final int total;
  final Function(List<Event>) callback;

  TargetsModel(this.total, this.callback);
}
