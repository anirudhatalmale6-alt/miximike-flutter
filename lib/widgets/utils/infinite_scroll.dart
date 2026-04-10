import 'package:flutter/material.dart';


class InfiniteScroll<Bloc> extends ScrollController {
  final bool Function() canCallNextPage;
  final double minPercentageToCall;

  double get currentPercentage => (position.pixels / position.maxScrollExtent) * 100;
  bool get inToEnd => currentPercentage >= minPercentageToCall;

  InfiniteScroll({
    required this.canCallNextPage,
    this.minPercentageToCall = 70,
    super.initialScrollOffset,
    super.keepScrollOffset = true,
    super.debugLabel,
    super.onAttach,
    super.onDetach,
  });

  void setAddPageRequestListener(Function() listener) {
    addListener(() async {
      if (!inToEnd) return;
      if (!canCallNextPage()) return;

      listener();
    });
  }
}
