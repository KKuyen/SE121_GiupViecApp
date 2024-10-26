import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:se121_giupviec_app/data/models/task_model.dart';
import 'package:se121_giupviec_app/domain/entities/task.dart';

abstract class TaskRemoteDatasource {
  Future<List<TaskModel>> getAllTasks(int userId);
}

class TaskRemoteDataSourceImpl implements TaskRemoteDatasource {
  final http.Client client;
  final String baseUrl;
  final String apiVersion;

  TaskRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
    required this.apiVersion,
  });

  @override
  Future<List<TaskModel>> getAllTasks(int userId) async {
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/get-all-tasks'),
        body: json.encode({
          'userId': 1,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjUsInBob25lTnVtYmVyIjoiMDM0NTY2NDAyNSIsInJvbGUiOiJSMSIsImV4cGlyZXNJbiI6IjMwZCIsImlhdCI6MTcyODIyMzI3N30.HPD25AZolhKCteXhFbF34zMyh2oewByvVHKBrFfET88'
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
      final List<dynamic> taskListJson = json.decode(response.body)['taskList'];
      print(taskListJson);
      return taskListJson.map((json) => TaskModel.fromJson(json)).toList();
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }
}
