import 'dart:math';

import 'package:flutter/material.dart';

class Item {
  final int id;
  final String name;
  final Color color;
  final int price = Random().nextInt(100);

  Item(this.id, this.name)
      : color = Colors.primaries[id % Colors.primaries.length];

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}
