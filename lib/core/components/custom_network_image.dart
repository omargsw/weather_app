import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.height = 300,
    this.width = 300,
    this.isCircle = false,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });
  final String imageUrl;
  final double height;
  final double width;
  final BoxFit fit;
  final bool? isCircle;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: FancyShimmerImage(
        width: width,
        height: height,
        imageUrl: imageUrl,
        boxFit: fit,
        imageBuilder: (context, imageProvider) {
          if (isCircle!) {
            return CircleAvatar(
              backgroundColor: const Color(0xffF5F5F5),
              backgroundImage: imageProvider,
            );
          } else {
            return Image(image: imageProvider, fit: BoxFit.cover);
          }
        },
        errorWidget: Image.asset(
          ///TODO: Add default image
          "AppImages.defaultImage",
          width: width,
          height: height,
        ),
        shimmerBaseColor: Colors.grey[300],
        shimmerHighlightColor: Colors.grey[100],
      ),
    );
  }
}
