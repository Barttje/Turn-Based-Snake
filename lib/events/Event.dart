import 'package:turn_based_snake/model/Snake.dart';

abstract class Event {
  applyEvent(final Snake target);
}
