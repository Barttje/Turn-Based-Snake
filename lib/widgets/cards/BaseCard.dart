import 'package:flutter/material.dart';
import 'package:turn_based_snake/events/Event.dart';

abstract class BaseCard extends StatelessWidget {
  final int id;
  Event getEvent();
  Icon getIcon();

  BaseCard(this.id);

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: this,
      feedback: CardImage(
        icon: getIcon(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: CardImage(
          icon: getIcon(),
        ),
      ),
      childWhenDragging: Container(),
    );
  }
}

class CardImage extends StatelessWidget {
  final Icon icon;
  const CardImage({Key key, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 50,
        height: 50,
        child: Container(
          child: icon,
          color: Colors.blue,
        ));
  }
}
