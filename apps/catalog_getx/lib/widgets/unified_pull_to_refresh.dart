import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class UnifiedPullToRefresh extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const UnifiedPullToRefresh({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: onRefresh,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: child,
      ),
    );
  }
}
