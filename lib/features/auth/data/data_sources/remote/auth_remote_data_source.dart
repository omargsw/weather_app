import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/core/utils/helpers/app_logger.dart';

class AuthRemoteDataSource {
  Future<String?> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      String? userId = userCredential.user?.uid;

      if (userId != null) {
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'email': email,
          'uuid': userId,
          'createdAt': FieldValue.serverTimestamp(),
          'role': 'user', 
        });
      }

      return userId;
    } on FirebaseAuthException catch (e) {
      AppLogger.warning(e.code);

      if (e.code == 'email-already-in-use') {
        // return 'The email address is already in use.';
        throw ServerException(
            errorMessage: 'The email address is already in use.');
      } else if (e.code == 'invalid-email') {
        // return 'The email address is not valid.';
        throw ServerException(errorMessage: 'The email address is not valid.');
      } else if (e.code == 'weak-password') {
        // return 'The password is too weak.';
        throw ServerException(
          errorMessage: 'The password is too weak.',
        );
      } else {
        // return 'Registration failed: ${e.message}';
        throw ServerException(
            errorMessage: 'Registration failed: ${e.message}');
      }
    } catch (e) {
      // return 'An unknown error occurred: $e';
      AppLogger.warning(e.toString());
      throw ServerException(errorMessage: e.toString());
    }
  }

  Future<String?> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      AppLogger.warning(e.code);

      if (e.code == 'user-not-found') {
        throw ServerException(
            errorMessage: 'No user found for the provided email address.');
      } else if (e.code == 'wrong-password') {
        throw ServerException(errorMessage: 'Incorrect password.');
      } else if (e.code == 'invalid-email') {
        throw ServerException(errorMessage: 'The email address is not valid.');
      } else if (e.code == 'user-disabled') {
        throw ServerException(
            errorMessage: 'This user account has been disabled.');
      } else {
        throw ServerException(errorMessage: 'Login failed: ${e.message}');
      }
    } catch (e) {
      AppLogger.warning(e.toString());
      throw ServerException(errorMessage: 'An unexpected error occurred: $e');
    }
  }
}
