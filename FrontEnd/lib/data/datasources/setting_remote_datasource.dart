import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:se121_giupviec_app/common/helpers/SecureStorage.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/data/models/setting_model.dart';
import 'package:se121_giupviec_app/data/models/simpleRes_model.dart';

abstract class SettingRemoteDatasource {
  Future<SimpleResModel> changePassword(
      int userId, String oldPassword, String newPassword);
  Future<SettingModel> getSetting(int userId);
  Future<void> setting(
      int userId, bool autoAcceptStatus, bool loveTaskerOnly, int upperStar);
}

Future<String> getToken() async {
  return await SecureStorage().readAccess_token();
}

class SettingRemoteDataSourceImpl implements SettingRemoteDatasource {
  final http.Client client;
  final String baseUrl;
  final String apiVersion;

  SettingRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
    required this.apiVersion,
  });
  @override
  Future<void> setting(int userId, bool autoAcceptStatus, bool loveTaskerOnly,
      int upperStar) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/edit-setting'),
        body: json.encode({
          'userId': userId,
          'autoAcceptStatus': autoAcceptStatus,
          'loveTaskerOnly': loveTaskerOnly,
          'upperStar': upperStar,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );
    } on SocketException {
      // Handle network errors
      print("No Internet connection");
      throw Exception('No Internet connection');
    } on HttpException {
      // Handle HTTP errors
      print("HTTP error occurred");
      throw Exception('HTTP error occurred');
    } on FormatException {
      // Handle JSON format errors
      print("Bad response format");
      throw Exception('Bad response format');
    } catch (e) {
      // Handle any other exceptions
      print("Unexpected error: $e");
      throw Exception('Unexpected error: $e');
    }

    if (response.statusCode == 200) {
      print("setting thành công");
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed to delete task');
    }
  }

  @override
  Future<SettingModel> getSetting(int userId) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/get-user-setting'),
        body: json.encode({
          'userId': userId,
        }),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
      );
    } on SocketException {
      // Handle network errors
      print("No Internet connection");
      throw Exception('No Internet connection');
    } on HttpException {
      // Handle HTTP errors
      print("HTTP error occurred");
      throw Exception('HTTP error occurred');
    } on FormatException {
      // Handle JSON format errors
      print("Bad response format");
      throw Exception('Bad response format');
    } catch (e) {
      // Handle any other exceptions
      print("Unexpected error: $e");
      throw Exception('Unexpected error: $e');
    }

    if (response.statusCode == 200) {
      final simpleRes = json.decode(response.body)['setting'];
      print(simpleRes);

      return SettingModel.fromJson(simpleRes);
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed to delete task');
    }
  }

  @override
  Future<SimpleResModel> changePassword(
      int userId, String oldPassword, String newPassword) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      response = await client.put(
        Uri.parse('$baseUrl/$apiVersion/change-password'),
        body: json.encode({
          'userId': userId,
          'oldPassword': oldPassword,
          'newPassword': newPassword,
        }),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
      );
    } on SocketException {
      // Handle network errors
      print("No Internet connection");
      throw Exception('No Internet connection');
    } on HttpException {
      // Handle HTTP errors
      print("HTTP error occurred");
      throw Exception('HTTP error occurred');
    } on FormatException {
      // Handle JSON format errors
      print("Bad response format");
      throw Exception('Bad response format');
    } catch (e) {
      // Handle any other exceptions
      print("Unexpected error: $e");
      throw Exception('Unexpected error: $e');
    }

    if (response.statusCode == 200) {
      final simpleRes = json.decode(response.body);
      print(simpleRes);

      return SimpleResModel.fromJson(simpleRes);
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed to delete task');
    }
  }
}
