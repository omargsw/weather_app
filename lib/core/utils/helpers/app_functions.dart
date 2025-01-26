import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'app_logger.dart';

class AppFunctions {
  const AppFunctions._();

  static bool isDarkTheme(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    return isDarkTheme;
  }

  static bool isEnglish(BuildContext context) {
    final Locale currentLocale = Localizations.localeOf(context);
    final String currentLanguageCode = currentLocale.languageCode;
    AppLogger.debug('currentLanguageCode$currentLanguageCode');
    return currentLanguageCode == 'en';
  }

  /// Keyboard functions
  static void unFocusKeyboard(BuildContext context) {
    final FocusScopeNode currentScope = FocusScope.of(context);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  static bool isKeyboardAppeared(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  /// Images functions
  static Future<XFile?> pickImage(ImageSource source) async {
    try {
      final pickImage = ImagePicker();
      final cameraImage = await pickImage.pickImage(
        source: source,
      );
      if (cameraImage != null) AppLogger.info('Picked image : ${cameraImage.name}');
      if (cameraImage == null) return null;
      return cameraImage;
    } catch (_) {
      return null;
    }
  }

  static Future<List<File>?> uploadMultiImagesFromGallery() async {
    final List<File> selectedImagesList = [];
    final List<File> selectedImagesListPaths = [];
    final List<File> selectedImagesListFileNames = [];
    final pickImage = ImagePicker();
    final multiImage = await pickImage.pickMultiImage();
    if (multiImage.isEmpty) return null;
    for (final XFile image in multiImage) {
      final imagesTemporary = File(image.path);
      selectedImagesList.add(imagesTemporary);
    }
    for (int i = 0; i < selectedImagesList.length; i++) {
      selectedImagesListPaths.add(File(selectedImagesList[i].path));
      selectedImagesListFileNames.add(File(selectedImagesList[i].path.split("/").last));
    }
    AppLogger.debug('selected Images List File Names ---> $selectedImagesListFileNames');
    return selectedImagesListFileNames;
  }

  static Future<String?> uploadVideo() async {
    final pickVideo = ImagePicker();
    final video = await pickVideo.pickVideo(source: ImageSource.gallery);
    if (video == null) return null;
    AppLogger.debug('Video file ---------> ${video.path}');
    return video.path;
  }
}
