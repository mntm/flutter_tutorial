import 'package:flutter/material.dart';

class AdaptiveDialog extends StatelessWidget {
  final Widget child;
  const AdaptiveDialog({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;

    return width > 400
        ? Dialog(
            child: ConstrainedBox(
              constraints: const BoxConstraints.tightFor(width: 400),
              child: child,
            ),
          )
        : Dialog.fullscreen(
            child: child,
          );
  }
}
