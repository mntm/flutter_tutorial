import 'package:flutter/material.dart';

class AutoHideBadgeCount extends StatelessWidget {
  const AutoHideBadgeCount({
    super.key,
    required this.count,
    this.child,
  });

  final int count;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    Widget effectiveChild = child ?? const SizedBox();
    return count > 0
        ? Container(
            margin: const EdgeInsets.only(right: 8),
            child: Badge.count(
              count: count,
              child: effectiveChild,
            ),
          )
        : effectiveChild;
  }
}
