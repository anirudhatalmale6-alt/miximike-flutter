import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingButton extends StatelessWidget {
  final bool isLoading;
  final Widget? iconLoading;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool? autofocus;
  final Clip? clipBehavior;
  final WidgetStatesController? statesController;
  final Widget? icon;
  final Widget label;

  const LoadingButton({
    super.key,
    required this.isLoading,
    required this.label,
    this.iconLoading,
    this.icon,
    this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.focusNode,
    this.autofocus,
    this.clipBehavior,
    this.statesController,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      label: label,
      onPressed: isLoading ? null : onPressed,
      icon: isLoading ? SizedBox(
        width: 24,
        height: 24,
        child: iconLoading ?? SpinKitCircle(
          color: Theme.of(context).primaryColor,
          size: 20,
        ),
      ) : (icon ?? Container()),
      style: style ?? ElevatedButton.styleFrom(padding: const EdgeInsets.all(16.0)),
      onLongPress: onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      statesController: statesController,
    );
  }
}
