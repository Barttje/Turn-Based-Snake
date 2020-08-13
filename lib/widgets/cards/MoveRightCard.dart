import 'package:flutter/material.dart';
import 'package:turn_based_snake/events/Event.dart';
import 'package:turn_based_snake/events/MoveLeftEvent.dart';
import 'package:turn_based_snake/events/MoveRightEvent.dart';
import 'package:turn_based_snake/widgets/cards/BaseCard.dart';

class MoveRightCard extends BaseCard {
  final Event event = MoveRightEvent();

  MoveRightCard(int id) : super(id);

  @override
  Event getEvent() {
    return event;
  }

  @override
  Icon getIcon() {
    return Icon(Icons.keyboard_arrow_right);
  }
}
