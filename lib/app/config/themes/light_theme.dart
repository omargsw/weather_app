import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/styles/app_colors.dart';
import 'package:weather_app/core/styles/app_text_style.dart';

ThemeData lightTheme() {
  return ThemeData(
    useMaterial3: true,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    // fontFamily: AppFontConstants.fontFamily,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.white,
    brightness: Brightness.light,
    elevatedButtonTheme: _elevatedButtonTheme(),
    // textButtonTheme: _textButtonTheme(),
    inputDecorationTheme: _inputDecorationTheme(),
    appBarTheme: _appBarTheme(),
    // bottomNavigationBarTheme: _bottomNavigationBarTheme(),
    // cardTheme: _cardTheme(),

    // iconTheme: _iconTheme(),
    // floatingActionButtonTheme: _floatingActionButtonTheme(),
  );
}

AppBarTheme _appBarTheme() {
  return AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.white,
      centerTitle: true,
      titleTextStyle: boldStyle(
        fontSize: 18,
        color: AppColors.black,
      ));
}

ElevatedButtonThemeData _elevatedButtonTheme() {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(AppColors.primary),
      minimumSize: WidgetStateProperty.all(Size(double.infinity, 50)),
      shape: WidgetStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          5,
        ),
      )),
      foregroundColor: WidgetStateProperty.all(AppColors.white),
      shadowColor: WidgetStateProperty.all(AppColors.white),
      elevation: WidgetStateProperty.all(0),
      padding: WidgetStateProperty.all(EdgeInsets.all(3.r)),
      textStyle: WidgetStateProperty.all(
        boldStyle(
          fontSize: 16.sp,
          color: AppColors.white,
        ),
      ),
    ),
  );
}

// TextButtonThemeData _textButtonTheme() {
//   return TextButtonThemeData(
//     style: ButtonStyle(
//       foregroundColor: MaterialStateProperty.all(AppColors.primaryColor),
//       textStyle: MaterialStateProperty.all(
//         mediumStyle(
//           fontSize: 16.sp,
//           color: AppColors.primaryColor,
//           fontFamily: AppFontConstants.fontFamily,
//         ),
//       ),
//     ),
//   );
// }

InputDecorationTheme _inputDecorationTheme() {
  return InputDecorationTheme(
    filled: true,
    fillColor: AppColors.primary.withValues(alpha: 0.2),
    hintStyle: lightStyle(
      fontSize: 16,
      color: AppColors.bluishColor,
      height: 1,
    ),
    errorStyle: lightStyle(
      color: Colors.red,
      fontSize: 16,
      height: 1,
    ),
    errorMaxLines: 1,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Colors.black),
    ),
    isDense: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide.none,
    ),
    labelStyle:
        lightStyle(fontSize: 16, height: 1, color: AppColors.bluishColor),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
  );
}

// BottomNavigationBarThemeData _bottomNavigationBarTheme() {
//   return BottomNavigationBarThemeData(
//     backgroundColor: AppColors.secondaryColor,
//     type: BottomNavigationBarType.fixed,
//     showSelectedLabels: false,
//     showUnselectedLabels: false,
//     selectedLabelStyle: const TextStyle(fontSize: 0),
//     unselectedLabelStyle: const TextStyle(fontSize: 0),
//   );
// }

// CardTheme _cardTheme() {
//   return CardTheme(
//     elevation: 0,
//     shape: RoundedRectangleBorder(
//       side: const BorderSide(
//         color: Colors.black12,
//       ),
//       borderRadius: BorderRadius.circular(15.r),
//     ),
//   );
// }

// IconThemeData _iconTheme() {
//   return IconThemeData(
//     size: AppSizes.size_24.w,
//     color: Colors.black45,
//   );
// }

// FloatingActionButtonThemeData _floatingActionButtonTheme() {
//   return FloatingActionButtonThemeData(
//     backgroundColor: AppColors.primaryColor,
//   );
// }
