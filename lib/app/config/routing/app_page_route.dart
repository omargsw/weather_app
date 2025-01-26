import 'dart:io' show Platform;

import 'package:flutter/material.dart';

class AppPageRoute<T> extends MaterialPageRoute<T> {
  AppPageRoute({required super.builder, super.settings});

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (Platform.isIOS) {
      return super.buildTransitions(
        context,
        animation,
        secondaryAnimation,
        child,
      );
    } else {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    }
  }
}
