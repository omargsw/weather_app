import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/core/styles/app_colors.dart';
import 'package:weather_app/core/styles/app_text_style.dart';
import 'package:weather_app/core/utils/helpers/app_strings.dart';
import 'package:weather_app/features/weather_history/data/models/weather_history_model.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    super.key,
    required this.data,
  });

  final HistoryModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.primary,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${data.city}, ${data.country}",
                      style: boldStyle(fontSize: 18),
                    ),
                    Text(
                      "${data.temp}°C",
                      style: boldStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${AppStrings.windSpeed.tr()}: ${data.windSpeed} ${AppStrings.ms.tr()}',
                    style: boldStyle(fontSize: 14),
                  ),
                  Text(
                    '${AppStrings.humidity.tr()}: ${data.humidity}%',
                    style: boldStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          Text(
            data.weatherMain,
            style: boldStyle(fontSize: 14, color: Colors.grey),
          ),
          Text(
            data.description,
            style: boldStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
