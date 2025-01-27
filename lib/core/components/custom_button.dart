import 'package:flutter/material.dart';
import 'package:weather_app/core/components/button_loading.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.isLoading = false});
  final String title;
  final Function() onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: isLoading
            ? const ButtonLoading(key: ValueKey('loading'))
            : Text(
                title,
                key: const ValueKey('loginText'),
              ),
      ),
    );
  }
}
