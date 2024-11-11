import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

class FirebaseImageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadImage(File imageFile) async {
    try {
      // Get the filename from the File path
      String fileName = path.basename(imageFile.path);

      // Create a reference to Firebase Storage
      final ref = _storage.ref().child(fileName);

      // Upload the file to Firebase Storage
      await ref.putFile(imageFile);

      // Return the filename after a successful upload
      return fileName;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<String> loadImage(String path) async {
    final ref = FirebaseStorage.instance.ref().child(path);
    return await ref.getDownloadURL();
  }
}
