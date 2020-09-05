import 'package:flutter/material.dart';
import 'package:turn_based_snake/widgets/cards/BaseCard.dart';

class Discard extends StatefulWidget {
  Discard({this.model}) : super(key: GlobalKey<DiscardState>());
  final DiscardModel model;
  @override
  DiscardState createState() => DiscardState();
}

class DiscardState extends State<Discard> {
  final Color inactiveColor = Colors.red;
  final Color activeColor = Colors.blue;
  bool active = false;
  BaseCard baseCard;

  setActive() {
    setState(() {
      this.active = true;
    });
  }

  setInActive() {
    setState(() {
      this.active = false;
    });
  }

  addCard(BaseCard data) {
    setState(() {
      this.baseCard = data;
    });
  }

  removeCard() {
    setState(() {
      this.baseCard = null;
      this.active = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      builder: (context, List<BaseCard> candidateData, rejectedData) {
        return Padding(
          padding: EdgeInsets.all(6),
          child: SizedBox(
            width: 60,
            height: 60,
            child: Container(
              color: getColor(),
              child: baseCard == null ? Icon(Icons.delete) : baseCard,
            ),
          ),
        );
      },
      onWillAccept: (data) {
        if (baseCard != null) {
          return false;
        }
        setActive();
        return true;
      },
      onLeave: (data) {
        setInActive();
      },
      onAccept: (BaseCard data) {
        widget.model.callback(data);
      },
    );
  }

  Color getColor() {
    if (baseCard != null) {
      return Colors.grey;
    }
    if (active) {
      return activeColor;
    }
    return inactiveColor;
  }
}

class DiscardModel {
  final Function(BaseCard) callback;
  DiscardModel(this.callback);
}
