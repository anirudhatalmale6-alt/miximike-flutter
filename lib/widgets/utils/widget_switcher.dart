import 'package:flutter/material.dart';

class WidgetSwitcher extends StatelessWidget {
  final bool condition;
  final Widget conditionWidget;
  final Widget child;


  const WidgetSwitcher({
    super.key,
    required this.condition,
    required this.conditionWidget,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return condition ? conditionWidget : child;
  }
}
