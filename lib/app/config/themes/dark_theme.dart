import 'package:flutter/material.dart';
import 'package:weather_app/core/styles/app_colors.dart';
import 'package:weather_app/core/styles/app_text_style.dart';

ThemeData darkTheme() {
  return ThemeData(
    useMaterial3: true,

    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    // fontFamily: AppFontConstants.fontFamily,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.black,
    brightness: Brightness.dark,
    // elevatedButtonTheme: _elevatedButtonTheme(),
    // textButtonTheme: _textButtonTheme(),
    // inputDecorationTheme: _inputDecorationTheme(),
    appBarTheme: _appBarTheme(),
    // cardTheme: _cardTheme(),

    // bottomNavigationBarTheme: _bottomNavigationBarTheme(),
    // iconTheme: _iconTheme(),
    // floatingActionButtonTheme: _floatingActionButtonTheme(),
  );
}

AppBarTheme _appBarTheme() {
  return AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.black,
      centerTitle: true,
      titleTextStyle: boldStyle(
        fontSize: 18,
        color: AppColors.white,
      ));
}

// ElevatedButtonThemeData _elevatedButtonTheme() {
//   return ElevatedButtonThemeData(
//     style: ButtonStyle(
//       backgroundColor: MaterialStateProperty.all(AppColors.secondaryColor),
//       shape: MaterialStateProperty.all(
//         RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(90.r),
//         ),
//       ),
//       padding: MaterialStateProperty.all(
//         EdgeInsets.symmetric(
//           vertical: 10.h,
//           horizontal: 60.w,
//         ),
//       ),
//       foregroundColor: MaterialStateProperty.all(AppColors.whiteColor),
//       textStyle: MaterialStateProperty.all(
//         regularStyle(
//           fontFamily: AppFontConstants.fontFamily,
//           fontSize: AppFontSizes.s20.sp,
//           color: AppColors.whiteColor,
//         ),
//       ),
//     ),
//   );
// }

// TextButtonThemeData _textButtonTheme() {
//   return TextButtonThemeData(
//     style: ButtonStyle(
//       foregroundColor: MaterialStateProperty.all(AppColors.secondaryColor),
//       textStyle: MaterialStateProperty.all(
//         regularStyle(
//           fontSize: 14.sp,
//           color: AppColors.secondaryColor,
//           fontFamily: AppFontConstants.fontFamily,
//         ),
//       ),
//     ),
//   );
// }

// InputDecorationTheme _inputDecorationTheme() {
//   return InputDecorationTheme(
//     filled: true,
//     fillColor: AppColors.darkThemeBackGroundColor,
//     hintStyle: regularStyle(
//       fontSize: AppFontSizes.s15.sp,
//       color: AppColors.whiteColor,
//     ),
//     errorStyle: regularStyle(
//       color: AppColors.whiteColor,
//       fontSize: 14.0.sp,
//     ),
//     errorMaxLines: 1,
//     enabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(100.r),
//       borderSide: BorderSide(color: Colors.grey.withOpacity(0.5)),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(100.r),
//       borderSide: BorderSide(color:AppColors.whiteColor),
//     ),
//     labelStyle: regularStyle(
//       fontSize: AppFontSizes.s18.sp,
//       color: AppColors.whiteColor,
//     ),
//     isDense: true,
//     contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
//     border: OutlineInputBorder(borderRadius: BorderRadius.circular(100.r), borderSide: BorderSide.none),
//     errorBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(100.r),
//       borderSide: BorderSide(color: AppColors.whiteColor),
//     ),
//   );
// }

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
