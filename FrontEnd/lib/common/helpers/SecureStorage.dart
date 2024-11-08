import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/entities/user.dart';

class SecureStorage {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
//state.blockTaskers[index].tasker as Map<String, dynamic>)['id'],

  Future<void> writeUserInfo(User user, String access_token) async {
    final userMap = user.user as Map<String, dynamic>;
    await _secureStorage.write(key: 'id', value: userMap['id'].toString());
    await _secureStorage.write(key: 'email', value: userMap['email']);
    await _secureStorage.write(key: 'name', value: userMap['name']);
    await _secureStorage.write(
        key: 'phoneNumber', value: userMap['phoneNumber']);
    await _secureStorage.write(key: 'avatar', value: userMap['avatar']);
    await _secureStorage.write(key: 'birthday', value: userMap['birthday']);
    await _secureStorage.write(
        key: 'Rpoints', value: userMap['Rpoints'].toString());
    await _secureStorage.write(key: 'access_token', value: access_token);
  }

  Future<void> writeId(String id) async {
    await _secureStorage.write(key: 'id', value: id);
  }

  Future<void> writeEmail(String email) async {
    await _secureStorage.write(key: 'email', value: email);
  }

  Future<void> writeName(String name) async {
    await _secureStorage.write(key: 'name', value: name);
  }

  Future<void> writePhoneNumber(String phoneNumber) async {
    await _secureStorage.write(key: 'phoneNumber', value: phoneNumber);
  }

  Future<void> writeAvatar(String avatar) async {
    await _secureStorage.write(key: 'avatar', value: avatar);
  }

  Future<void> writeBirthday(String birthday) async {
    await _secureStorage.write(key: 'birthday', value: birthday);
  }

  Future<void> writeAccess_token(String access_token) async {
    await _secureStorage.write(key: 'access_token', value: access_token);
  }

  Future<void> writeRpoints(String Rpoints) async {
    await _secureStorage.write(key: 'Rpoints', value: Rpoints);
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

  Future<String> readRpoints() async {
    String? Rpoints = await _secureStorage.read(key: 'Rpoints');
    return Rpoints!;
  }
}
