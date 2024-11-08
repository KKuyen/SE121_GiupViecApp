import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class FirebaseImageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File image, String path) async {
    try {
      Reference ref = _storage.ref().child(path);
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }

  Future<String> getImageUrl(String path) async {
    try {
      String downloadUrl = await _storage.ref().child(path).getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Error getting image URL: $e');
    }
  }
}
