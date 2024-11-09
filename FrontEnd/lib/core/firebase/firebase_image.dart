import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class FirebaseImageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File image, String path) async {
    try {
      Reference ref = _storage.ref().child(path);
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      return snapshot.ref.fullPath;
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }

  Future<File> downloadImage(String path, String downloadPath) async {
    try {
      Reference ref = _storage.ref().child(path);
      File file = File(downloadPath);
      await ref.writeToFile(file);
      return file;
    } catch (e) {
      throw Exception('Error downloading image: $e');
    }
  }
}
