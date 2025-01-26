import 'package:flutter/material.dart';

class CustomRefreshIndicator extends StatelessWidget {
  const CustomRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.displacement = 40.0,
    this.edgeOffset = 0.0,
    this.notificationPredicate = defaultScrollNotificationPredicate,
    this.semanticsLabel,
    this.semanticsValue,
    this.strokeWidth = 2.5,
    this.triggerMode = RefreshIndicatorTriggerMode.onEdge,
  });

  final Widget child;
  final Future<void> Function() onRefresh;
  final double displacement;
  final double edgeOffset;
  final ScrollNotificationPredicate notificationPredicate;
  final String? semanticsLabel;
  final String? semanticsValue;
  final double strokeWidth;
  final RefreshIndicatorTriggerMode triggerMode;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      color: Colors.white,
      backgroundColor: Colors.white,
      onRefresh: onRefresh,
      displacement: displacement,
      edgeOffset: edgeOffset,
      notificationPredicate: notificationPredicate,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
      strokeWidth: strokeWidth,
      triggerMode: triggerMode,
      child: child,
    );
  }
}
