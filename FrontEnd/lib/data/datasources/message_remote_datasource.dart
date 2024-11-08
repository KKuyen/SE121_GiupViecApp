import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/message_model.dart';
import '../models/message_review_model.dart';

abstract class MessageRemoteDatasource {
  Future<List<MessageModel>> getMessages(int sourceId, int targetId);
  Future<List<MessageReviewModel>> getMessagesReview(int sourceId);
}

class MessageRemoteDatasourceImpl implements MessageRemoteDatasource {
  final http.Client client;
  final String baseUrl;
  final String apiVersion;

  MessageRemoteDatasourceImpl({
    required this.client,
    required this.baseUrl,
    required this.apiVersion,
  });

  @override
  Future<List<MessageModel>> getMessages(int sourceId, int targetId) async {
    final http.Response response;
    try {
      print("sourceId: $sourceId, targetId: $targetId");
      final uri = Uri.parse('$baseUrl/$apiVersion/messages').replace(
        queryParameters: {
          'sourceId': sourceId.toString(),
          'targetId': targetId.toString(),
        },
      );

      response = await client.get(
        uri,
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
      print("Unexpected errorrrrrrrr: $e");
      throw Exception('Unexpected error: $e');
    }

    if (response.statusCode == 200) {
      final List<dynamic> messagesListJson =
          json.decode(response.body)['messages'];
      return messagesListJson
          .map((json) => MessageModel.fromJson(json))
          .toList();
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<List<MessageReviewModel>> getMessagesReview(int sourceId) async {
    final http.Response response;
    try {
      final uri = Uri.parse('$baseUrl/$apiVersion/messages-review').replace(
        queryParameters: {
          'sourceId': sourceId.toString(),
        },
      );

      response = await client.get(
        uri,
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
      print("Unexpected errorrrrrrrr: $e");
      throw Exception('Unexpected error: $e');
    }

    if (response.statusCode == 200) {
      final List<dynamic> messagesListJson =
          json.decode(response.body)['messages'];
      return messagesListJson
          .map((json) => MessageReviewModel.fromJson(json))
          .toList();
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }
}
