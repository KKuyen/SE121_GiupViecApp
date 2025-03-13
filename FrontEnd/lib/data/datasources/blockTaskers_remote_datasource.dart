import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:se121_giupviec_app/common/helpers/SecureStorage.dart';

import 'package:se121_giupviec_app/data/models/BlockTasker_model.dart';

abstract class BlockTaskersRemoteDatasource {
  Future<List<BlockTaskerModel>> getAllBlockTaskers(int userId);
}

Future<String> getToken() async {
  return await SecureStorage().readAccess_token();
}

class BlockTaskersRemoteDatasourceImpl implements BlockTaskersRemoteDatasource {
  final http.Client client;
  final String baseUrl;
  final String apiVersion;

  BlockTaskersRemoteDatasourceImpl({
    required this.client,
    required this.baseUrl,
    required this.apiVersion,
  });

  @override
  Future<List<BlockTaskerModel>> getAllBlockTaskers(int userId) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/get-block-tasker'),
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
      final List<dynamic> taskListJson =
          json.decode(response.body)['blockList'];
      print('--------------------------------------');
      print(taskListJson);
      return taskListJson
          .map((json) => BlockTaskerModel.fromJson(json))
          .toList();
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }
}
