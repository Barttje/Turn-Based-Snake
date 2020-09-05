import 'package:flutter/material.dart';
import 'package:turn_based_snake/deck/deck.dart';
import 'package:turn_based_snake/events/Event.dart';
import 'package:turn_based_snake/widgets/Discard.dart';
import 'package:turn_based_snake/widgets/Target.dart';
import 'package:turn_based_snake/widgets/cards/BaseCard.dart';

class CardSelection extends StatefulWidget {
  final CardSelectionModel cardSelectionModel;

  const CardSelection({Key key, this.cardSelectionModel}) : super(key: key);

  @override
  _CardSelectionState createState() => _CardSelectionState();
}

class _CardSelectionState extends State<CardSelection> {
  Map<int, Event> map = new Map();
  Deck deck = new Deck();
  List<Target> targets = [];
  List<BaseCard> baseCards = [];
  Discard discard;
  bool enabled = false;

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
      GlobalKey<DiscardState> discardState = discard.key;
      if (discardState.currentState.baseCard == baseCard) {
        discardState.currentState.removeCard();
      }
      targets.where((element) => element.model.id != id).forEach((element) {
        GlobalKey<TargetState> key = element.key;
        if (key.currentState.baseCard == baseCard) {
          key.currentState.removeCard();
          map.remove(element.model.id);
        }
      });
    });
  }

  addToDiscard(final BaseCard event) {
    removeCard(event, event.id);
    GlobalKey<DiscardState> discardState = discard.key;
    discardState.currentState.addCard(event);
  }

  applyEvent(final BaseCard event, final int id) {
    removeCard(event, id);
    map.putIfAbsent(id, () => event.getEvent());
    if (map.length == widget.cardSelectionModel.totalTargets) {
      setState(() {
        this.enabled = true;
      });
    }
  }

  finishedEvent() {
    GlobalKey<DiscardState> key = discard.key;
    key.currentState.removeCard();
    widget.cardSelectionModel.callback(map.values.toList());
    targets.forEach((element) {
      GlobalKey<TargetState> key = element.key;
      if (key.currentState.baseCard != null) {
        removeCard(key.currentState.baseCard, key.currentState.baseCard.id);
        baseCards.remove(key.currentState.baseCard);
        baseCards.add(deck.deck.removeLast());
      }
    });
  }

  @override
  void initState() {
    discard = new Discard(model: new DiscardModel(addToDiscard));
    baseCards.add(deck.deck.removeLast());
    baseCards.add(deck.deck.removeLast());
    baseCards.add(deck.deck.removeLast());
    baseCards.add(deck.deck.removeLast());
    baseCards.add(deck.deck.removeLast());
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
        Row(
          children: <Widget>[
            discard,
            RaisedButton(
              onPressed: enabled ? finishedEvent : null,
              child: Text("Done"),
            ),
          ],
        )
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
