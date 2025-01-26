import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../styles/app_colors.dart';

class ButtonLoading extends StatelessWidget {
  const ButtonLoading({
    super.key,
    this.size = 30,
    this.color,
  });
  final double size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        size: size,
        color: color ?? AppColors.white,
      ),
    );
  }
}
