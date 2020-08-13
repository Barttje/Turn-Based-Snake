import 'package:flutter/material.dart';
import 'package:turn_based_snake/events/Event.dart';
import 'package:turn_based_snake/model/Snake.dart';

class MoveRightEvent implements Event {
  final Offset relativePosition = Offset(1, 0);

  @override
  applyEvent(final Snake target) {
    target.move(relativePosition);
  }
}
