// network/api_service.dart
import 'api_client.dart';

class ApiService {
  final ApiClient _apiClient;

  ApiService(this._apiClient);

  Future<Map<String, dynamic>> fetchUserData(String userId) async {
    try {
      return await _apiClient.get('/users/$userId');
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updateUser(String userId, Map<String, dynamic> data) async {
    try {
      return await _apiClient.put('/users/$userId', body: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> createUser(Map<String, dynamic> data) async {
    try {
      return await _apiClient.post('/users', body: data);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> deleteUser(String userId) async {
    try {
      return await _apiClient.delete('/users/$userId');
    } catch (e) {
      rethrow;
    }
  }
}
