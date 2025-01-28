import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryModel {
  final String city;
  final String country;
  final double windSpeed;
  final double temp;
  final int humidity;
  final String weatherMain;
  final String description;
  final Timestamp timestamp;

  HistoryModel({
    required this.city,
    required this.country,
    required this.windSpeed,
    required this.temp,
    required this.humidity,
    required this.weatherMain,
    required this.description,
    required this.timestamp,
  });

  // Factory constructor to create a HistoryModel from Firestore data
  factory HistoryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return HistoryModel(
      city: data['city'] ?? '',
      country: data['country'] ?? '',
      windSpeed: data['windSpeed']?.toDouble() ?? 0.0,
      temp: data['temp']?.toDouble() ?? 0.0,
      humidity: data['humidity'] ?? 0,
      weatherMain: data['weatherMain'] ?? '',
      description: data['description'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }

  // Method to convert HistoryModel to a Map for Firestore saving
  Map<String, dynamic> toMap() {
    return {
      'city': city,
      'country': country,
      'windSpeed': windSpeed,
      'temp': temp,
      'humidity': humidity,
      'weatherMain': weatherMain,
      'description': description,
      'timestamp': timestamp,
    };
  }
}
