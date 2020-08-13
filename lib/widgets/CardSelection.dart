import 'package:flutter/material.dart';
import 'package:turn_based_snake/events/Event.dart';
import 'package:turn_based_snake/widgets/Target.dart';
import 'package:turn_based_snake/widgets/cards/BaseCard.dart';
import 'package:turn_based_snake/widgets/cards/MoveDownCard.dart';
import 'package:turn_based_snake/widgets/cards/MoveLeftCard.dart';
import 'package:turn_based_snake/widgets/cards/MoveRightCard.dart';
import 'package:turn_based_snake/widgets/cards/MoveUpCard.dart';

class CardSelection extends StatefulWidget {
  final CardSelectionModel cardSelectionModel;

  const CardSelection({Key key, this.cardSelectionModel}) : super(key: key);

  @override
  _CardSelectionState createState() => _CardSelectionState();
}

class _CardSelectionState extends State<CardSelection> {
  Map<int, Event> map = new Map();
  List<Target> targets = [];
  List<BaseCard> baseCards = [];
  var left = MoveLeftCard(1);
  var right = MoveRightCard(2);
  var down = MoveDownCard(3);
  var up = MoveUpCard(4);

  addCard(BaseCard baseCard) {
    setState(() {
      if (!baseCards.contains(baseCard)) {
        removeCard(baseCard, null);
        baseCards.add(baseCard);
      }
    });
  }

  removeCard(BaseCard baseCard, final int id) {
    setState(() {
      baseCards.remove(baseCard);
      targets.where((element) => element.model.id != id).forEach((element) {
        GlobalKey<TargetState> key = element.key;
        if (key.currentState.baseCard == baseCard) {
          key.currentState.removeCard();
          map.remove(element.model.id);
        }
      });
    });
  }

  applyEvent(final BaseCard event, final int id) {
    removeCard(event, id);
    map.putIfAbsent(id, () => event.getEvent());
    if (map.length == widget.cardSelectionModel.totalTargets) {
      widget.cardSelectionModel.callback(map.values.toList());
    }
  }

  @override
  void initState() {
    baseCards.add(left);
    baseCards.add(right);
    baseCards.add(up);
    baseCards.add(down);
    targets.add(new Target(
        model: TargetModel(
      applyEvent,
      1,
    )));
    targets.add(new Target(
        model: TargetModel(
      applyEvent,
      2,
    )));
    targets.add(new Target(
        model: TargetModel(
      applyEvent,
      3,
    )));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.center, children: targets),
        DragTarget(
          builder: (context, List<BaseCard> candidateData, rejectedData) {
            return Padding(
              padding: EdgeInsets.all(6),
              child: SizedBox(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: baseCards),
              ),
            );
          },
          onWillAccept: (data) {
            return true;
          },
          onLeave: (data) {},
          onAccept: (BaseCard data) {
            addCard(data);
          },
        ),
      ],
    );
  }
}

class CardSelectionModel {
  final int totalTargets;
  final int totalCards;
  final Function(List<Event>) callback;

  CardSelectionModel(this.totalTargets, this.totalCards, this.callback);
}
