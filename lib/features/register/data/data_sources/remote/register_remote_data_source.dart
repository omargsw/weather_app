import 'package:firebase_auth/firebase_auth.dart';

class RegisterRemoteDataSource {
  Future<String?> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // Create a new user with the provided email and password
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Successfully registered, return user ID
      return userCredential.user?.uid;
    } on FirebaseAuthException catch (e) {
      // Handle specific error codes
      if (e.code == 'email-already-in-use') {
        return 'The email address is already in use.';
      } else if (e.code == 'invalid-email') {
        return 'The email address is not valid.';
      } else if (e.code == 'weak-password') {
        return 'The password is too weak.';
      } else {
        return 'Registration failed: ${e.message}';
      }
      //   AppLogger.warning(response.data);
      //   throw ServerException(errorMessage: AppStrings.errorCode.tr().replaceAll(AppExpressions.textPattern, response.statusCode.toString()));
    } catch (e) {
      // Handle general errors
      return 'An unknown error occurred: $e';
    }
  }
}
