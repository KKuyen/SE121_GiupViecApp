import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/data/models/task_model.dart';
import 'package:se121_giupviec_app/data/models/taskerList_model.dart';
import 'package:se121_giupviec_app/domain/entities/task.dart';

abstract class TaskRemoteDatasource {
  Future<List<TaskModel>> getTS1Tasks(int userId);
  Future<List<TaskModel>> getTS2Tasks(int userId);
  Future<List<TaskModel>> getTS3Tasks(int userId);
  Future<List<TaskModel>> getTS4Tasks(int userId);
  Future<TaskModel> getATask(int taskId);
  Future<List<TaskerListModel>> getTaskerList(int userId);

  Future<void> deleteTask(int taskId, int cancelCode);
  Future<void> finishTask(int taskId);
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
  Future<List<TaskModel>> getTS1Tasks(int userId) async {
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/get-all-tasks'),
        body: json.encode({
          'userId': userId,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': AppInfor1.user_token
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

      return taskListJson
          .map((json) => TaskModel.fromJson(json))
          .where((task) => task.taskStatus == 'TS1')
          .toList();
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<List<TaskModel>> getTS2Tasks(int userId) async {
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/get-all-tasks'),
        body: json.encode({
          'userId': userId,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': AppInfor1.user_token
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

      return taskListJson
          .map((json) => TaskModel.fromJson(json))
          .where((task) => task.taskStatus == 'TS2')
          .toList();
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<List<TaskModel>> getTS4Tasks(int userId) async {
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/get-all-tasks'),
        body: json.encode({
          'userId': userId,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': AppInfor1.user_token
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
      final List<TaskModel> taskList = taskListJson
          .map((json) => TaskModel.fromJson(json))
          .where((task) => task.taskStatus == 'TS4')
          .toList();
      taskList.sort((a, b) =>
          (b.cancelAt ?? DateTime(0)).compareTo(a.cancelAt ?? DateTime(0)));

      return taskList;
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<TaskModel> getATask(int taskId) async {
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/get-a-task'),
        body: json.encode({
          'taskId': taskId,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': AppInfor1.user_token
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
      final Map<String, dynamic> responseBody = json.decode(response.body);
      print(responseBody);
      final Map<String, dynamic> taskJson = responseBody['task'];
      print(taskJson);
      final TaskModel taskModel = TaskModel.fromJson(taskJson);
      return taskModel;
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<List<TaskerListModel>> getTaskerList(int taskId) async {
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/get-tasker-list'),
        body: json.encode({
          'taskId': taskId,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': AppInfor1.user_token
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
      final List<dynamic> taskListJson =
          json.decode(response.body)['taskerList'];
      print(taskListJson);
      return taskListJson
          .map((json) => TaskerListModel.fromJson(json))
          .toList();
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<List<TaskModel>> getTS3Tasks(int userId) async {
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/get-all-tasks'),
        body: json.encode({
          'userId': userId,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': AppInfor1.user_token
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

      return taskListJson
          .map((json) => TaskModel.fromJson(json))
          .where((task) => task.taskStatus == 'TS3')
          .toList();
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<void> deleteTask(int taskId, cancelCode) async {
    final http.Response response;
    try {
      response = await client.put(
        Uri.parse('$baseUrl/$apiVersion/cancel-a-task'),
        body: json.encode({'taskId': taskId, 'cancelCode': cancelCode}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': AppInfor1.user_token
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
      print("Task deleted successfully");
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed to delete task');
    }
  }

  @override
  Future<void> finishTask(int taskId) async {
    final http.Response response;
    try {
      response = await client.put(
        Uri.parse('$baseUrl/$apiVersion/finish-a-task'),
        body: json.encode({'taskId': taskId}),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': AppInfor1.user_token
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
      print("Task finish successfully");
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed to finish task');
    }
  }
}
