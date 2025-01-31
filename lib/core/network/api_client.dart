// network/api_client.dart
import 'package:dio/dio.dart';

class ApiClient {
  final Dio dio;

  ApiClient({String? baseUrl})
      : dio = Dio(BaseOptions(
    baseUrl: baseUrl ?? 'https://example.com/api',
    connectTimeout: const Duration(milliseconds: 5000), // Timeout for connection
    receiveTimeout: const Duration(milliseconds: 3000), // Timeout for response
    headers: {'Content-Type': 'application/json'},
  ));

  Future<Map<String, dynamic>> get(String path) async {
    try {
      final response = await dio.get(path);
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<Map<String, dynamic>> post(String path, {required Map<String, dynamic> body}) async {
    try {
      final response = await dio.post(path, data: body);
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }

  Future<Map<String, dynamic>> put(String path, {required Map<String, dynamic> body}) async {
    try {
      final response = await dio.put(path, data: body);
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to put data: $e');
    }
  }

  Future<Map<String, dynamic>> delete(String path) async {
    try {
      final response = await dio.delete(path);
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to delete data: $e');
    }
  }
}
