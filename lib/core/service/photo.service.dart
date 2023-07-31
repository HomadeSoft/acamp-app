// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'dart:async';
import 'dart:io';
import 'package:campings_app/app/constants/app.strings.dart';
import 'package:campings_app/core/api/supabase.api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PhotoService with ChangeNotifier {
  final picker = ImagePicker();
  var imageFile;
  String? photo_url;
  String? errorUpload;
  File? image;

  Future selectFile() async {
    imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    image = File(imageFile.path);
    if (kDebugMode) {
      print(image);
    }
    notifyListeners();
  }

  Future upload<bool>({required BuildContext context}) async {
    final bytes = await imageFile.readAsBytes();
    final fileExt = imageFile.path.split('.').last;
    final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
    final filePath = fileName;

    final response = await SupabaseAPI.supabaseClient.storage
        .from('user-images')
        .uploadBinary(filePath, bytes);
    if (response.isEmpty) {
      errorUpload = Strings.errorUploadingPhoto;
      if (kDebugMode) {
        print(errorUpload!);
      }
      return false;
    } else {
      final imageUrlResponse = SupabaseAPI.supabaseClient.storage
          .from('user-images')
          .getPublicUrl(filePath);
      photo_url = imageUrlResponse;
      notifyListeners();
      return true;
    }
  }
}
