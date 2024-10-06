import 'package:flutter/material.dart';

class MarkedInputDecoration extends InputDecoration {
  final String? _labelText;
  @override
  String? get labelText => null;
  @override
  Widget get label => Text.rich(
        TextSpan(
          children: <InlineSpan>[
            if (_labelText != null)
              WidgetSpan(
                child: Text(
                  _labelText,
                ),
              ),
            const WidgetSpan(
              child: Text(
                '*',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      );

  const MarkedInputDecoration({
    super.icon,
    super.iconColor,
    String? labelText,
    super.labelStyle,
    super.floatingLabelStyle,
    super.helper,
    super.helperText,
    super.helperStyle,
    super.helperMaxLines,
    super.hintText,
    super.hintStyle,
    super.hintTextDirection,
    super.hintMaxLines,
    super.hintFadeDuration,
    super.error,
    super.errorText,
    super.errorStyle,
    super.errorMaxLines,
    super.floatingLabelBehavior,
    super.floatingLabelAlignment,
    super.isCollapsed,
    super.isDense,
    super.contentPadding,
    super.prefixIcon,
    super.prefixIconConstraints,
    super.prefix,
    super.prefixText,
    super.prefixStyle,
    super.prefixIconColor,
    super.suffixIcon,
    super.suffix,
    super.suffixText,
    super.suffixStyle,
    super.suffixIconColor,
    super.suffixIconConstraints,
    super.counter,
    super.counterText,
    super.counterStyle,
    super.filled,
    super.fillColor,
    super.focusColor,
    super.hoverColor,
    super.errorBorder,
    super.focusedBorder,
    super.focusedErrorBorder,
    super.disabledBorder,
    super.enabledBorder,
    super.border,
    super.enabled = true,
    super.semanticCounterText,
    super.alignLabelWithHint,
    super.constraints,
  }) : _labelText = labelText;
}
