import 'package:flutter/material.dart';
import 'package:turn_based_snake/widgets/cards/BaseCard.dart';

class Target extends StatefulWidget {
  Target({this.model}) : super(key: GlobalKey<TargetState>());
  final TargetModel model;
  @override
  TargetState createState() => TargetState();
}

class TargetState extends State<Target> {
  final Color inactiveColor = Colors.red;
  final Color activeColor = Colors.blue;
  bool active = false;
  BaseCard baseCard = null;

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      builder: (context, List<BaseCard> candidateData, rejectedData) {
        return Padding(
          padding: EdgeInsets.all(6),
          child: SizedBox(
            width: 80,
            height: 80,
            child: Container(
              color: getColor(),
              child: baseCard,
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
        addCard(data);
        widget.model.callback(data, widget.model.id);
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

class TargetModel {
  final Function(BaseCard, int) callback;
  final int id;
  TargetModel(this.callback, this.id);
}
