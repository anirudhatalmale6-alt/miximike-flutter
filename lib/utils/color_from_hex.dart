import 'dart:ui';

extension HexToColor on String {
  Color hexToColor() {
    return Color(
        int.parse(toLowerCase().substring(1, 7), radix: 16) + 0xFF000000);
  }
}