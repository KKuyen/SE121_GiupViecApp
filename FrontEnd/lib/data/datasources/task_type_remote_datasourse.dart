import 'dart:convert';
import 'dart:io';

import 'package:se121_giupviec_app/common/helpers/SecureStorage.dart';

import '../models/task_type_model.dart';
import 'package:http/http.dart' as http;

abstract class TaskTypeRemoteDatasource {
  Future<List<TaskTypeModel>> getAllTasksType();
}

Future<String> getToken() async {
  return await SecureStorage().readAccess_token();
}

class TaskTypeRemoteDatasourceImpl implements TaskTypeRemoteDatasource {
  final http.Client client;
  final String baseUrl;
  final String apiVersion;

  TaskTypeRemoteDatasourceImpl({
    required this.client,
    required this.baseUrl,
    required this.apiVersion,
  });

  @override
  Future<List<TaskTypeModel>> getAllTasksType() async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/get-all-task-type'),
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
      final List<dynamic> taskTypeListJson =
          json.decode(response.body)['taskTypeList'];
      return taskTypeListJson
          .map((json) => TaskTypeModel.fromJson(json))
          .toList();
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }
}
