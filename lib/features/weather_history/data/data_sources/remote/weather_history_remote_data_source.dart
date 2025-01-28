import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/core/utils/helpers/app_constants.dart';
import 'package:weather_app/core/utils/helpers/app_logger.dart';
import 'package:weather_app/core/utils/helpers/app_secure_storage.dart';
import 'package:weather_app/features/weather_history/data/models/weather_history_model.dart';

class WeatherHistoryRemoteDataSource {
  Future<List<HistoryModel>> fetchHistory() async {
    try {
      String uuid =
          await AppSecureStorage.getData(key: AppConstants.userID) ?? "";
      if (uuid.isEmpty) return [];

      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      final CollectionReference historyCollection =
          firestore.collection("users").doc(uuid).collection("history");

      final QuerySnapshot snapshot =
          await historyCollection.orderBy('timestamp', descending: true).get();

      List<HistoryModel> historyList = snapshot.docs.map((doc) {
        return HistoryModel.fromFirestore(doc);
      }).toList();

      return historyList;
    } catch (e) {
      AppLogger.warning('Error fetching history: $e');
      throw ServerException(errorMessage: 'Failed to fetch history: $e');
    }
  }
}
