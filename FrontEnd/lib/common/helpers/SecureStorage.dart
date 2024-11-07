import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/entities/user.dart';

class SecureStorage {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
//state.blockTaskers[index].tasker as Map<String, dynamic>)['id'],
  void writeUserInfo(User user, String accessToken) {
    final userMap = user.user as Map<String, dynamic>;
    _secureStorage.write(key: 'id', value: userMap['id'].toString());
    _secureStorage.write(key: 'email', value: userMap['email']);
    _secureStorage.write(key: 'name', value: userMap['name']);
    _secureStorage.write(key: 'phoneNumber', value: userMap['phoneNumber']);
    _secureStorage.write(key: 'avatar', value: userMap['avatar']);
    _secureStorage.write(key: 'birthday', value: userMap['birthday']);
    _secureStorage.write(key: 'access_token', value: accessToken);
  }

  Future<String> readId() async {
    String? id = await _secureStorage.read(key: 'id');
    return id!;
  }

  Future<String> readEmail() async {
    String? email = await _secureStorage.read(key: 'email');
    return email!;
  }

  Future<String> readName() async {
    String? name = await _secureStorage.read(key: 'name');
    return name!;
  }

  Future<String> readPhoneNumber() async {
    String? phoneNumber = await _secureStorage.read(key: 'phoneNumber');
    return phoneNumber!;
  }

  Future<String> readAvatar() async {
    String? avatar = await _secureStorage.read(key: 'avatar');
    return avatar!;
  }

  Future<String> readBirthday() async {
    String? birthday = await _secureStorage.read(key: 'birthday');
    return birthday!;
  }

  Future<String> readAccess_token() async {
    String? accessToken = await _secureStorage.read(key: 'access_token');
    return accessToken!;
  }
}
