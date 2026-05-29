import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

void main() async {
  final dio = Dio(BaseOptions(baseUrl: 'https://calorie-tracker-backend-ybji.onrender.com'));
  
  try {
    final loginResponse = await dio.post('/api/auth/login', data: {
      'identifier': 'testuser12345@example.com',
      'password': 'Password123!',
    });
    final token = loginResponse.data['token'] ?? loginResponse.data['jwt'];
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
      print('Logged in, token received');
      
      final mealResponse = await dio.post('/api/meals', data: {
        "date": DateTime.now().toIso8601String().split('T')[0],
        "mealType": "snack_${DateTime.now().millisecondsSinceEpoch}",
      });
      print('Meal created with random type: ${mealResponse.data}');
      
    }
  } catch (e) {
    if (e is DioException) {
      print('Login Error: ${e.response?.data}');
    } else {
      print(e);
    }
  }
}
