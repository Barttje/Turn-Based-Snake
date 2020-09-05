import 'package:turn_based_snake/widgets/cards/BaseCard.dart';
import 'package:turn_based_snake/widgets/cards/MoveDownCard.dart';
import 'package:turn_based_snake/widgets/cards/MoveUpCard.dart';
import 'package:turn_based_snake/widgets/cards/MoveLeftCard.dart';
import 'package:turn_based_snake/widgets/cards/MoveRightCard.dart';

class Deck {
  final List<BaseCard> deck = [];
  final List<BaseCard> discard = [];

  Deck() {
    deck.add(new MoveDownCard(1));
    deck.add(new MoveDownCard(2));
    deck.add(new MoveDownCard(3));
    deck.add(new MoveDownCard(4));
    deck.add(new MoveUpCard(5));
    deck.add(new MoveUpCard(6));
    deck.add(new MoveUpCard(7));
    deck.add(new MoveUpCard(8));
    deck.add(new MoveRightCard(9));
    deck.add(new MoveRightCard(10));
    deck.add(new MoveRightCard(11));
    deck.add(new MoveRightCard(12));
    deck.add(new MoveLeftCard(13));
    deck.add(new MoveLeftCard(14));
    deck.add(new MoveLeftCard(15));
    deck.add(new MoveLeftCard(16));
    deck.shuffle();
  }
}
