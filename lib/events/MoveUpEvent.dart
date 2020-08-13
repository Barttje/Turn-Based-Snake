import 'package:flutter/material.dart';
import 'package:turn_based_snake/events/Event.dart';
import 'package:turn_based_snake/model/Snake.dart';

class MoveUpEvent implements Event {
  final Offset relativePosition = Offset(0, -1);

  @override
  applyEvent(final Snake target) {
    target.move(relativePosition);
  }
}
