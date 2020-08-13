import 'package:flutter/material.dart';

class Snake {
  final Color color;
  final int id;
  final List<Offset> pos = [];
  Snake(this.color, this.id, Offset head) {
    pos.add(head);
  }

  move(final Offset relativePosition) {
    Offset newHead = combine(head(), relativePosition);
    pos.removeLast();
    pos.insert(0, newHead);
  }

  Offset head() {
    return pos.first;
  }

  Offset tail() {
    return pos.last;
  }
}

Offset combine(Offset head, Offset relative) {
  return new Offset(head.dx + relative.dx, head.dy + relative.dy);
}
