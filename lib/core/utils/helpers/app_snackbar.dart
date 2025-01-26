import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/styles/app_text_style.dart';
import 'package:weather_app/core/utils/helpers/app_strings.dart';

class AppSnackBar {
  const AppSnackBar._();

  ///TODO: To change style
  static void showSuccessSnackBar(BuildContext context, String body, {int duration = 5}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            const Icon(
              Icons.check_circle,
              size: 18.0,
              color: Colors.green,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(body, style: regularStyle(fontSize: 14.0.sp, color: Colors.black), textAlign: TextAlign.start),
            ),
            GestureDetector(
              onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
              child: Text(
                AppStrings.hide,
                style: regularStyle(fontSize: 14.0.sp, color: Colors.black),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
        duration: Duration(seconds: duration),
        backgroundColor: Colors.black,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        margin: const EdgeInsets.all(12),
        animation: CurvedAnimation(
            reverseCurve: Curves.bounceOut,
            parent: AnimationController(duration: const Duration(milliseconds: 500), vsync: ScaffoldMessenger.of(context)),
            curve: Curves.bounceIn),
      ),
    );
  }

  static void showInfoSnackBar(BuildContext context, String body, {Duration? duration, Widget? messageText}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            const Icon(
              Icons.info_outline,
              size: 28.0,
              color: Color(0xFF1465B4),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: messageText ??
                  Text(
                    body,
                    style: regularStyle(
                      fontSize: 14.0,
                      lineHeight: 1.5,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.start,
                  ),
            ),
          ],
        ),
        duration: duration ?? const Duration(seconds: 3),
        backgroundColor: const Color(0xFFDCEDFC),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(8),
        animation: CurvedAnimation(
            reverseCurve: Curves.bounceOut,
            parent: AnimationController(duration: const Duration(milliseconds: 500), vsync: ScaffoldMessenger.of(context)),
            curve: Curves.bounceIn),
      ),
    );
  }

  static void showErrorSnackBar(BuildContext context, String body, {int duration = 5}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              child: const Icon(
                Icons.close_rounded,
                size: 12.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(body, style: regularStyle(fontSize: 14.0.sp, color: Colors.black), textAlign: TextAlign.start),
            ),
            GestureDetector(
              onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
              child: Text(
                AppStrings.hide,
                style: regularStyle(fontSize: 14.0.sp, color: Colors.black),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
        duration: Duration(seconds: duration),
        backgroundColor: Colors.black,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        margin: const EdgeInsets.all(12),
        animation: CurvedAnimation(
            reverseCurve: Curves.bounceOut,
            parent: AnimationController(duration: const Duration(milliseconds: 500), vsync: ScaffoldMessenger.of(context)),
            curve: Curves.bounceIn),
      ),
    );
  }

  static void showSuccessDownloadSnackBa(BuildContext context, {int duration = 5, required void Function()? onTap}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Row(
          children: [
            const Icon(
              Icons.check_circle,
              size: 28.0,
              color: Colors.green,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'تم التحميل بنجاح',
                style: regularStyle(
                  fontSize: 14.0,
                  lineHeight: 1.5,
                  color: Colors.black,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: onTap,
              child: Text(
                "فتح الملف",
                style: regularStyle(
                  fontSize: 14.0,
                  decoration: TextDecoration.underline,
                  color: Colors.black,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
        duration: Duration(seconds: duration),
        backgroundColor: Colors.greenAccent,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(8),
        animation: CurvedAnimation(
            reverseCurve: Curves.bounceOut,
            parent: AnimationController(duration: const Duration(milliseconds: 500), vsync: ScaffoldMessenger.of(context)),
            curve: Curves.bounceIn),
      ),
    );
  }
}
