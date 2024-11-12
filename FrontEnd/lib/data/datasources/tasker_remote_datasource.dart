import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:se121_giupviec_app/common/helpers/SecureStorage.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/data/models/taskType_model.dart';

import 'package:se121_giupviec_app/data/models/taskerInfo_model.dart';

abstract class TaskerRemoteDatasource {
  Future<TaskerInfoModel> getATasker(int userId, int taskerId);
  Future<List<TasktypeModel>> getTaskTypeList();
}

class TaskerRemoteDataSourceImpl implements TaskerRemoteDatasource {
  final http.Client client;
  final String baseUrl;
  final String apiVersion;

  TaskerRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
    required this.apiVersion,
  });
  Future<String> getToken() async {
    return await SecureStorage().readAccess_token();
  }

  @override
  Future<TaskerInfoModel> getATasker(int userId, int taskerId) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/get-tasker-info'),
        body: json.encode({
          "userId": userId,
          'taskerId': taskerId,
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
      final dynamic taskerJson = json.decode(response.body);

      print("tasker: $taskerJson");
      return TaskerInfoModel.fromJson(taskerJson);
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<List<TasktypeModel>> getTaskTypeList() async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/get-all-task-type'),
        body: json.encode({}),
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
      final List<dynamic> taskTypeListJson =
          json.decode(response.body)['taskTypeList'];
      print('taskType--------------------------------------');
      print(taskTypeListJson);

      return taskTypeListJson
          .map((json) => TasktypeModel.fromJson(json))
          .toList();
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }
}
