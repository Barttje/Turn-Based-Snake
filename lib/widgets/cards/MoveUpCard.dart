import 'package:flutter/material.dart';
import 'package:turn_based_snake/events/Event.dart';
import 'package:turn_based_snake/events/MoveLeftEvent.dart';
import 'package:turn_based_snake/events/MoveUpEvent.dart';

import 'package:turn_based_snake/widgets/cards/BaseCard.dart';

class MoveUpCard extends BaseCard {
  final Color color = Colors.blue;
  final Event event = MoveUpEvent();

  MoveUpCard(int id) : super(id);

  @override
  Event getEvent() {
    return event;
  }

  @override
  Icon getIcon() {
    return Icon(Icons.keyboard_arrow_up);
  }
}
