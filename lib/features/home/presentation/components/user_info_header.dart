import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/app/config/routing/app_router.dart';
import 'package:weather_app/core/utils/helpers/app_constants.dart';
import 'package:weather_app/core/utils/helpers/app_secure_storage.dart';
import 'package:weather_app/core/utils/helpers/app_strings.dart';

class UserInfoHeader extends StatelessWidget {
  const UserInfoHeader({
    super.key,
    required this.userEmail,
  });
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.welcomeBack.tr(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                userEmail,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey[400]!, width: 2),
          ),
          child: IconButton(
              onPressed: () {
                AppSecureStorage.removeData(key: AppConstants.userID);
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.loginScreen, (route) => false);
              },
              icon: Icon(context.locale.languageCode == 'ar'
                  ? Icons.login_outlined
                  : Icons.logout_outlined)),
        ),
      ],
    );
  }
}
