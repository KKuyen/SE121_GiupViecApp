import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:se121_giupviec_app/common/helpers/SecureStorage.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/data/models/location_model.dart';
import 'package:se121_giupviec_app/data/models/task_model.dart';
import 'package:se121_giupviec_app/data/models/taskerList_model.dart';
import 'package:se121_giupviec_app/domain/entities/location.dart';

abstract class TaskRemoteDatasource {
  Future<List<TaskModel>> getTS1Tasks(int userId);
  Future<List<TaskModel>> getTS2Tasks(int userId);
  Future<List<TaskModel>> getTS3Tasks(int userId);
  Future<List<TaskModel>> getTS4Tasks(int userId);
  Future<List<TaskModel>> TaskergetTS1Tasks(int userId);
  Future<List<TaskModel>> TaskergetTS2Tasks(int userId);
  Future<List<TaskModel>> TaskergetTS3Tasks(int userId);
  Future<List<TaskModel>> TaskergetTS4Tasks(int userId);
  Future<TaskModel> getATask(int taskId);
  Future<List<TaskerListModel>> getTaskerList(int userId);

  Future<void> deleteTask(int taskId, int cancelCode);
  Future<void> finishTask(int taskId);
  Future<void> updateTaskerStatus(int taskerListId, String status);
  Future<void> editTask(
      int taskId, DateTime? time, int? locationId, String? note);
  Future<Location> getdflocation(int userId);
  Future<List<Location>> getalllocation(int userId);
  Future<List<TaskModel>> taskerFindTask(
      int taskerId, List<int>? taskTypes, DateTime? fromDate, DateTime? toDate);
  Future<void> applyTask(int taskerId, int taskId);
  Future<void> taskercancel(int taskerId, int taskId);
  Future<void> review(
      int TaskId,
      int taskerId,
      int star,
      int userId,
      int taskTypeId,
      String content,
      String? image1,
      String? image2,
      String? image3,
      String? image4);
  Future<String> pushImage(File file);
  Future<LocationModel> getLocation(int taskId);
}

Future<String> getToken() async {
  return await SecureStorage().readAccess_token();
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
  Future<String> pushImage(File file) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      final uri = Uri.parse('$baseUrl/upload-image');
      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = token
        ..files.add(await http.MultipartFile.fromPath('image', file.path));

      final streamedResponse = await request.send();
      response = await http.Response.fromStream(streamedResponse);
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
      final List<dynamic> taskListJson = json.decode(response.body)['url'];
      print(taskListJson);
      return taskListJson.toString();
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<void> applyTask(int taskerId, int taskId) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      final uri = Uri.parse('$baseUrl/$apiVersion/apply-task').replace(
        queryParameters: {
          'taskerId': taskerId.toString(),
          'taskId': taskId.toString(),
        },
      );
      response = await client.post(
        uri,
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
      print("Unexpected errorrrrrrrr: $e");
      throw Exception('Unexpected error: $e');
    }

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      print("apply thanh cong");
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<void> taskercancel(int taskerId, int taskId) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      final uri = Uri.parse('$baseUrl/$apiVersion/cancel-task').replace(
        queryParameters: {
          'taskerId': taskerId.toString(),
          'taskId': taskId.toString(),
        },
      );
      response = await client.put(
        uri,
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
      print("Unexpected errorrrrrrrr: $e");
      throw Exception('Unexpected error: $e');
    }

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      print("cancel thanh cong");
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<List<TaskModel>> taskerFindTask(int taskerId, List<int>? taskTypes,
      DateTime? fromDate, DateTime? toDate) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      final Map<String, dynamic> body = {"taskerId": taskerId};
      if (taskTypes != null) {
        body['taskTypes'] = taskTypes;
      }
      if (fromDate != null) {
        body['fromDate'] = fromDate.toIso8601String();
      }
      if (toDate != null) {
        body['toDate'] = toDate.toIso8601String();
      }
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/get-find-tasks'),
        body: json.encode(body),
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
      final List<dynamic> taskListJson =
          json.decode(response.body)['taskerList'];
      print(taskListJson);

      return taskListJson.map((json) => TaskModel.fromJson(json)).toList();
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  review(
      int taskId,
      int taskerId,
      int star,
      int userId,
      int taskTypeId,
      String content,
      String? image1,
      String? image2,
      String? image3,
      String? image4) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      List<String?> imageArray = [image1, image2, image3, image4];
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/review'),
        body: json.encode({
          'taskId': taskId,
          'taskerId': taskerId,
          'star': star,
          'userId': userId,
          'taskTypeId': taskTypeId,
          'content': content,
          'imageArray': imageArray
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
      print("review thanhf coong");
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<LocationModel> getdflocation(int userId) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      final uri =
          Uri.parse('$baseUrl/$apiVersion/get-my-default-location').replace(
        queryParameters: {
          'userId': userId.toString(),
        },
      );
      response = await client.get(
        uri,
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
      print("Unexpected errorrrrrrrr: $e");
      throw Exception('Unexpected error: $e');
    }

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      print("get được my locatuon rôi");
      print(responseBody);
      return LocationModel.fromJson(responseBody['location']);
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<List<LocationModel>> getalllocation(int userId) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    print("get được rôi");
    try {
      final uri = Uri.parse('$baseUrl/$apiVersion/get-my-location').replace(
        queryParameters: {
          'userId': userId.toString(),
        },
      );
      response = await client.get(
        uri,
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
      print("Unexpected errorrrrrrrr: $e");
      throw Exception('Unexpected error: $e');
    }

    if (response.statusCode == 200) {
      final List<dynamic> LocationListJson =
          json.decode(response.body)['locations'];
      print("get được list my locatuon rôi");
      print(LocationListJson);
      return LocationListJson.map((json) => LocationModel.fromJson(json))
          .toList();
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<List<TaskModel>> getTS1Tasks(int userId) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/get-all-tasks'),
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
      final List<dynamic> taskListJson = json.decode(response.body)['taskList'];
      print("taskListJsonnnnnnnnnnnnnnnnnnnnnnnnnnnn: $taskListJson");
      return taskListJson
          .map((json) => TaskModel.fromJson(json))
          .where((task) =>
              task.taskStatus == 'TS1' && task.time.isAfter(DateTime.now()))
          .toList();
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<List<TaskModel>> TaskergetTS1Tasks(int userId) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      final uri = Uri.parse('$baseUrl/$apiVersion/get-apply-tasks').replace(
        queryParameters: {
          'taskerId': userId.toString(),
        },
      );
      response = await client.get(
        uri,
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
      final List<dynamic> taskListJson =
          json.decode(response.body)['taskerList'];
      print(taskListJson);
      return taskListJson.map((json) => TaskModel.fromJson(json)).toList();
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<List<TaskModel>> getTS2Tasks(int userId) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/get-all-tasks'),
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
  Future<List<TaskModel>> TaskergetTS2Tasks(int userId) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      final uri = Uri.parse('$baseUrl/$apiVersion/get-my-task').replace(
        queryParameters: {
          'taskerId': userId.toString(),
        },
      );
      response = await client.get(
        uri,
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
      final List<dynamic> taskListJson =
          json.decode(response.body)['taskerList'];
      print(taskListJson);
      return taskListJson.map((json) => TaskModel.fromJson(json)).toList();
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<List<TaskModel>> getTS4Tasks(int userId) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/get-all-tasks'),
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
      final List<dynamic> taskListJson = json.decode(response.body)['taskList'];

      print(taskListJson);
      final List<TaskModel> taskList = taskListJson
          .map((json) => TaskModel.fromJson(json))
          .where((task) =>
              task.taskStatus == 'TS4' ||
              (task.taskStatus == 'TS1' && task.time.isBefore(DateTime.now())))
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
  Future<List<TaskModel>> TaskergetTS4Tasks(int userId) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/get-all-tasks'),
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
      final List<dynamic> taskListJson = json.decode(response.body)['taskList'];

      print(taskListJson);
      final List<TaskModel> taskList = taskListJson
          .map((json) => TaskModel.fromJson(json))
          .where((task) =>
              task.taskStatus == 'TS4' ||
              (task.taskStatus == 'TS1' && task.time.isBefore(DateTime.now())))
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
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/get-a-task'),
        body: json.encode({
          'taskId': taskId,
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
      final Map<String, dynamic> responseBody = json.decode(response.body);
      final Map<String, dynamic> taskJson = responseBody['task'];
      final TaskModel taskModel = TaskModel.fromJson(taskJson);
      print("taskModel: $taskModel");
      return taskModel;
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<List<TaskerListModel>> getTaskerList(int taskId) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/get-tasker-list'),
        body: json.encode({
          'taskId': taskId,
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
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/get-all-tasks'),
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
  Future<List<TaskModel>> TaskergetTS3Tasks(int userId) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      final uri = Uri.parse('$baseUrl/$apiVersion/get-my-task-history').replace(
        queryParameters: {
          'taskerId': userId.toString(),
        },
      );
      response = await client.get(
        uri,
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
      final List<dynamic> taskListJson =
          json.decode(response.body)['taskerList'];
      print(taskListJson);
      return taskListJson.map((json) => TaskModel.fromJson(json)).toList();
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<void> deleteTask(int taskId, cancelCode) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      response = await client.put(
        Uri.parse('$baseUrl/$apiVersion/cancel-a-task'),
        body: json.encode({'taskId': taskId, 'cancelCode': cancelCode}),
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
      print("Task deleted successfully");
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed to delete task');
    }
  }

  @override
  Future<void> finishTask(int taskId) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      response = await client.put(
        Uri.parse('$baseUrl/$apiVersion/finish-a-task'),
        body: json.encode({'taskId': taskId}),
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
      print("Task finish successfully");
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed to finish task');
    }
  }

  @override
  Future<void> updateTaskerStatus(int taskerListId, String status) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      response = await client.put(
        Uri.parse('$baseUrl/$apiVersion/edit-tasker-list-status'),
        body: json.encode({'taskerListId': taskerListId, 'status': status}),
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
      print("edit successfully");
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed to finish task');
    }
  }

  @override
  Future<void> editTask(
      int TaskId, DateTime? time, int? locationId, String? note) async {
    String token = await getToken();
    token = 'Bearer $token';
    if (time != null) {
      final http.Response response;
      try {
        response = await client.put(
          Uri.parse('$baseUrl/$apiVersion/edit-a-task'),
          body: json.encode({
            'taskId': TaskId,
            'time': time.toIso8601String(),
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
        print("edit time successfully");
      } else {
        print("response.body failed: ${response.body}");
        throw Exception('Failed to finish task');
      }
    }
    if (locationId != null) {
      final http.Response response;
      try {
        response = await client.put(
          Uri.parse('$baseUrl/$apiVersion/edit-a-task'),
          body: json.encode({
            'taskId': TaskId,
            'locationId': locationId,
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
        print("edit successfully");
      } else {
        print("response.body failed: ${response.body}");
        throw Exception('Failed to finish task');
      }
    }
    if (note != null) {
      final http.Response response;
      try {
        response = await client.put(
          Uri.parse('$baseUrl/$apiVersion/edit-a-task'),
          body: json.encode({
            'taskId': TaskId,
            'note': note,
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
        print("edit successfully");
      } else {
        print("response.body failed: ${response.body}");
        throw Exception('Failed to finish task');
      }
    }
  }

  @override
  Future<LocationModel> getLocation(int taskId) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      final uri = Uri.parse('$baseUrl/$apiVersion/get-task-location').replace(
        queryParameters: {
          'taskId': taskId.toString(),
        },
      );
      response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
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
      print("Unexpected errorrrrrrrr: $e");
      throw Exception('Unexpected error: $e');
    }

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);

      print(responseBody);
      return LocationModel.fromJson(responseBody['location']);
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }
}
