import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/core/styles/app_text_style.dart';

class AppSnackBar {
  const AppSnackBar._();

  static void show({
    required BuildContext context,
    SnackBarType type = SnackBarType.success,
    required String message,
    SnackBarPosition position = SnackBarPosition.bottom,
    Duration duration = const Duration(seconds: 3),
  }) {
    final icon = _getIcon(type);
    final backgroundColor = _getBackgroundColor(type);

    if (position == SnackBarPosition.top) {
      _showOverlaySnackbar(
        context: context,
        message: message,
        icon: icon,
        backgroundColor: backgroundColor,
        duration: duration,
      );
    } else {
      _showBottomSnackbar(
        context: context,
        message: message,
        icon: icon,
        backgroundColor: backgroundColor,
        duration: duration,
      );
    }
  }

  static void _showBottomSnackbar({
    required BuildContext context,
    required String message,
    required Icon icon,
    required Color backgroundColor,
    required Duration duration,
  }) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          icon,
          const Gap(8),
          Expanded(
            child: Text(
              message,
              style: regularStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      duration: duration,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
    );

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(snackBar);
  }

  static void _showOverlaySnackbar({
    required BuildContext context,
    required String message,
    required Icon icon,
    required Color backgroundColor,
    required Duration duration,
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                icon,
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    message,
                    style: regularStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(duration, () => overlayEntry.remove());
  }

  static Icon _getIcon(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return const Icon(Icons.check_circle, color: Colors.white);
      case SnackBarType.error:
        return const Icon(Icons.error, color: Colors.white);
      case SnackBarType.info:
        return const Icon(Icons.info, color: Colors.white);
    }
  }

  static Color _getBackgroundColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Colors.green;
      case SnackBarType.error:
        return Colors.red;
      case SnackBarType.info:
        return Colors.blue;
    }
  }
}

enum SnackBarType { success, error, info }

enum SnackBarPosition { top, bottom }
